import 'package:aszcars_tfg_andrei/models/posts.dart';
import 'package:aszcars_tfg_andrei/models/savedPostmodel.dart';
import 'package:aszcars_tfg_andrei/models/user.dart';
import 'package:aszcars_tfg_andrei/screens/message_screen/messages_screen.dart';
import 'package:aszcars_tfg_andrei/services/authentication_service.dart';
import 'package:aszcars_tfg_andrei/widgets/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  FirebaseAuth auth;
  @override
  void initState() {
    auth = FirebaseAuth.instance;
    super.initState();
    getPostFromDB();
  }

  Future<UserModel> getCurrentUser(String uid) async {
    UserModel currentUser =
        await context.read<AuthenticationService>().getUserFromDB(uid: uid);
    return currentUser;
  }

  Future<void> getPostFromDB() async {
    List<String> postsSavedByCurrentUser = [];

    FirebaseFirestore.instance.collection("saved").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) async {
        final datosPost = SavedPostModel.fromMap(result.data());

        if (datosPost.userWhoSaved == auth.currentUser.uid) {
          setState(() {
            postsSavedByCurrentUser.add(datosPost.postDocument);
          });
        }
      });
    });

    FirebaseFirestore.instance
        .collection("posts")
        .orderBy("timestamp", descending: true)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) async {
        final datosPost = PostModel.fromMap(result.data());
        UserModel usuario = await getCurrentUser(datosPost.uid);
        Post post = Post(
          userUid: usuario.uid,
          canDelete: false,
          userCar: datosPost.usercar,
          description: datosPost.descripcion,
          imageURL: datosPost.imageLink,
          profile: usuario.profileimage,
          postDocument: result.id,
          saved: postsSavedByCurrentUser.contains(result.id) ? true : false,
          userName: usuario.username,
          comments: datosPost.comments,
          likes: datosPost.likes,
        );
        setState(() {
          postsList.add(post);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            AppBar(),
            Expanded(
              child: listaPosts(),
            ),
          ],
        ),
      ),
    );
  }

  ListView listaPosts() {
    return ListView.builder(
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        itemCount: postsList.length,
        itemBuilder: (context, index) {
          return postsList[index];
        });
  }
}

class AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: 60,
      width: screenWidth,
      color: Colors.black,
      /*APP BAR */
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: () async {
                //Metodo para salir de la aplicación
                final singedOut =
                    await context.read<AuthenticationService>().signOut();
                if (singedOut == "Singed out") {
                  Navigator.of(context).pushReplacement(new MaterialPageRoute(
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
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
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
                  MaterialPageRoute(builder: (context) => MessagesPage()),
                );
              }),
        ],
      ),
    );
  }
}
