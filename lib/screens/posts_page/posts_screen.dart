import 'package:aszcars_tfg_andrei/screens/message_screen/messages_screen.dart';
import 'package:aszcars_tfg_andrei/services/authentication_service.dart';
import 'package:aszcars_tfg_andrei/widgets/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class PostsPage extends StatefulWidget {
  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  List<Post> postsList = [];

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              width: screenWidth,
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () async {
                        //Metodo para salir de la aplicación
                        final singedOut = await context
                            .read<AuthenticationService>()
                            .signOut();
                        if (singedOut == "Singed out") {
                          Navigator.of(context).pushReplacement(
                              new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      AuthenticationWrapper()));
                        }
                      },
                      child: Icon(
                        Icons.exit_to_app,
                        color: Colors.white,
                        size: 30,
                      )),
                  Text(
                    "ASZCARS",
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                  IconButton(
                      splashColor: Colors.black,
                      icon: Icon(
                        Ionicons.ios_paper_plane,
                        color: Colors.white,
                        size: 25,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MessagesPage()),
                        );
                      }),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("posts")
                      .orderBy("timestamp", descending: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(
                        child: Container(
                            width: screenWidth,
                            color: Colors.black,
                            child: Center(child: CircularProgressIndicator())),
                      );
                    } else {
                      postsList.clear();
                      snapshot.data.docs.forEach((element) {
                        postsList.add(Post(
                          comments: element["comments"],
                          userName: element["username"],
                          imageURL: element["imageLink"],
                          profile: element["profileImage"],
                          saved: false,
                          description: element["descripcion"],
                          userCar: element["usercar"],
                          likes: element["likes"],
                          postDocument: element.id,
                          canDelete: false,
                        ));
                      });
                      return ListView.builder(
                          physics: AlwaysScrollableScrollPhysics(
                              parent: BouncingScrollPhysics()),
                          itemCount: postsList.length,
                          itemBuilder: (context, index) {
                            return postsList[index];
                          });
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
