import 'package:aszcars_tfg_andrei/constants/color_palette.dart';
import 'package:aszcars_tfg_andrei/models/user.dart';
import 'package:aszcars_tfg_andrei/screens/edit_profile_screen/edit_profile_page.dart';
import 'package:aszcars_tfg_andrei/services/authentication_service.dart';
import 'package:aszcars_tfg_andrei/widgets/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool posts;
  bool saved;

  //Propiedades del usuario

  String _profileImage;
  String _userName;
  String _description;
  String _uid;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    postsList.clear();
    posts = true;
    saved = false;
  }

  getCurrentUser() async {
    UserModel currentUser = await context
        .read<AuthenticationService>()
        .getUserFromDB(uid: auth.currentUser.uid);

    _currentUser = currentUser;

    setState(() {
      _profileImage = _currentUser.profileimage;
      _userName = _currentUser.username;
      _description = _currentUser.descripcion;
    });
  }

  //Obtenemos el usuario actual
  FirebaseAuth auth = FirebaseAuth.instance;
  UserModel _currentUser;

  //Aqui cogemos y guardamos todos los posts que el usuario haya creado
  List<Post> postsList = [];

  //Aqui se guardarán todas las imagenes que el usuario haya creado
  List<String> images = [];

  //Auth service para poder desloguear

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              Container(
                height: screenHeight,
                width: screenWidth,
                color: Colors.transparent,
              ),
              Container(
                  height: screenHeight * 0.20,
                  width: screenWidth,
                  color: Colors.grey.shade900),
              Positioned(
                  top: screenHeight * 0.15,
                  child: Container(
                    height: screenHeight * 0.70,
                    width: screenWidth,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30)),
                  )),
              Positioned(
                  left: screenWidth * 0.82,
                  top: screenHeight * 0.18,
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                EditProfilePage()));
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ))),
              Positioned(
                  left: screenWidth * 0.33,
                  right: screenWidth * 0.33,
                  top: screenHeight * 0.07,
                  child: _profileImage == null
                      ? Container(
                          height: screenWidth * 0.34,
                          width: screenWidth * 0.34,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/noimage.png'),
                                  fit: BoxFit.cover),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                        )
                      : Container(
                          height: screenWidth * 0.34,
                          width: screenWidth * 0.34,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: _profileImage == ""
                                      ? AssetImage('assets/images/noimage.png')
                                      : NetworkImage(_profileImage),
                                  fit: BoxFit.cover),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                        )),
              Positioned(
                  top: screenHeight * 0.25,
                  right: 0,
                  left: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _userName == null
                          ? Text("",
                              style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500))
                          : Text("$_userName",
                              style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500))
                    ],
                  )),
              Positioned(
                top: screenHeight * 0.31,
                child: Container(
                  width: screenWidth,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: _description == null
                          ? Text(
                              "",
                              style: GoogleFonts.montserrat(
                                  color: Colors.white, fontSize: 13),
                              textAlign: TextAlign.center,
                            )
                          : Text(
                              "$_description",
                              style: GoogleFonts.montserrat(
                                  color: Colors.white, fontSize: 13),
                              textAlign: TextAlign.center,
                            )),
                ),
              ),
              Positioned(
                top: screenHeight * 0.36,
                right: 10,
                left: 10,
                child: Container(
                  height: 50,
                  width: screenWidth,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            saved = false;
                            posts = true;
                          });
                        },
                        child: AnimatedContainer(
                            width: screenWidth * 0.47,
                            height: 48,
                            decoration: BoxDecoration(
                                color:
                                    posts ? Colors.white : Colors.grey.shade900,
                                borderRadius: BorderRadius.circular(20)),
                            duration: Duration(milliseconds: 300),
                            child: Center(
                                child: Text("POSTS",
                                    style: GoogleFonts.montserrat(
                                        color:
                                            posts ? Colors.black : Colors.white,
                                        fontWeight: FontWeight.w500)))),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            saved = true;
                            posts = false;
                          });
                        },
                        child: AnimatedContainer(
                          width: screenWidth * 0.47,
                          height: 48,
                          duration: Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                              color:
                                  saved ? Colors.white : Colors.grey.shade900,
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                              child: Text("GRID",
                                  style: GoogleFonts.montserrat(
                                      color:
                                          saved ? Colors.black : Colors.white,
                                      fontWeight: FontWeight.w500))),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("posts")
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      Positioned(
                          top: screenHeight * 0.53,
                          child: Container(
                              height: screenHeight * 0.4,
                              width: screenWidth,
                              color: Colors.black,
                              child:
                                  Center(child: CircularProgressIndicator())));
                    } else {
                      postsList.clear();
                      snapshot.data.docs.forEach((element) async {
                        postsList.add(Post(
                          comments: element["comments"],
                          userName: _userName == null ? "" : _userName,
                          imageURL: element["imageLink"],
                          profile: _profileImage == null ? "" : _profileImage,
                          saved: false,
                          description: element["descripcion"],
                          userCar: element["usercar"],
                          likes: element["likes"],
                          postDocument: element.id,
                          canDelete: false,
                        ));
                      });
                    }
                    return Positioned(
                        top: screenHeight * 0.43,
                        child: Container(
                            height: screenHeight * 0.45,
                            width: screenWidth,
                            color: Colors.black,
                            child: posts
                                ? ListView.builder(
                                    physics: AlwaysScrollableScrollPhysics(
                                        parent: BouncingScrollPhysics()),
                                    itemCount: postsList.length,
                                    itemBuilder: (context, index) {
                                      return postsList[index];
                                    })
                                : Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: GridView.builder(
                                        itemCount: postsList.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                crossAxisSpacing: 0,
                                                mainAxisSpacing: 0),
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(1.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          postsList[index]
                                                              .imageURL),
                                                      fit: BoxFit.cover)),
                                            ),
                                          );
                                        }),
                                  )));
                  })
            ],
          )),
    );
  }
}
