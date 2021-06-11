import 'package:aszcars_tfg_andrei/constants/color_palette.dart';
import 'package:aszcars_tfg_andrei/models/posts.dart';
import 'package:aszcars_tfg_andrei/models/user.dart';
import 'package:aszcars_tfg_andrei/screens/detail_screen/detail_screen.dart';
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
  //Booleano para controlar los posts
  bool posts;

  //Obtenemos el usuario actual

  UserModel _currentUser;

  //Aqui cogemos y guardamos todos los posts que el usuario haya creado
  List<Post> postsList = [];
  List<Post> savedList = [];
  FirebaseAuth auth;
  @override
  void initState() {
    auth = FirebaseAuth.instance;

    getCurrentUser(auth.currentUser.uid);
    posts = true;
    super.initState();
  }

  getCurrentUser(String uid) async {
    print("Cogiendo usuario****************************");
    UserModel currentUser =
        await context.read<AuthenticationService>().getUserFromDB(uid: uid);
    setState(() {
      _currentUser = currentUser;
    });
    print("usuario cogido");

    getPostFromDB();
  }

  @override
  void dispose() {
    postsList.clear();
    print("posts borrados");
    super.dispose();
  }

  Future<void> getPostFromDB() async {
    print("añadinedo Posts");
    FirebaseFirestore.instance
        .collection("posts")
        .orderBy("timestamp", descending: true)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        final datosPost = PostModel.fromMap(result.data());
        Post post = Post(
          canDelete: true,
          userCar: datosPost.usercar,
          description: datosPost.descripcion,
          imageURL: datosPost.imageLink,
          profile: _currentUser.profileimage,
          postDocument: result.id,
          saved: false,
          userName: _currentUser.username,
          comments: datosPost.comments,
          likes: datosPost.likes,
        );

        if (datosPost.uid == _currentUser.uid) {
          setState(() {
            postsList.add(post);
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: _currentUser != null
            ? Stack(
                children: [
                  Container(
                    height: screenHeight,
                    width: screenWidth,
                    color: Colors.black,
                  ),
                  profileImage(screenWidth, screenHeight),
                  userName(screenHeight, screenWidth),
                  userDescription(screenHeight, screenWidth),
                  botonEditarPerfil(screenHeight, screenWidth, context),
                  Positioned(
                    top: screenHeight * 0.30,
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
                          tabPosts(screenWidth),
                          tabSaved(screenWidth),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      top: screenHeight * 0.37,
                      child: Container(
                          height: screenHeight * 0.45,
                          width: screenWidth,
                          color: Colors.black,
                          child: posts ? gridOwnPosts() : gridSaved())),
                ],
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Positioned botonEditarPerfil(
      double screenHeight, double screenWidth, BuildContext context) {
    return Positioned(
      top: screenHeight * 0.1,
      left: screenWidth * 0.42,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => EditProfilePage()));
        },
        child: Container(
          height: 50,
          width: screenWidth * 0.5,
          decoration: BoxDecoration(
              color: ColorsPalette().colorBoton,
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Editar Perfil",
                style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 13),
              )
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector tabPosts(double screenWidth) {
    return GestureDetector(
      onTap: () {
        setState(() {
          posts = !posts;
        });
      },
      child: AnimatedContainer(
          width: screenWidth * 0.47,
          height: 48,
          decoration: BoxDecoration(
              color: posts ? Colors.white : Colors.grey.shade900,
              borderRadius: BorderRadius.circular(20)),
          duration: Duration(milliseconds: 300),
          child: Center(
              child: Text("POSTS",
                  style: GoogleFonts.montserrat(
                      color: posts ? Colors.black : Colors.white,
                      fontWeight: FontWeight.w500)))),
    );
  }

  GestureDetector tabSaved(double screenWidth) {
    return GestureDetector(
      onTap: () {
        setState(() {
          posts = !posts;
        });
      },
      child: AnimatedContainer(
        width: screenWidth * 0.47,
        height: 48,
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
            color: !posts ? Colors.white : Colors.grey.shade900,
            borderRadius: BorderRadius.circular(20)),
        child: Center(
            child: Text("SAVED",
                style: GoogleFonts.montserrat(
                    color: !posts ? Colors.black : Colors.white,
                    fontWeight: FontWeight.w500))),
      ),
    );
  }

  Padding gridOwnPosts() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
      child: postsList.length != 0
          ? GridView.builder(
              itemCount: postsList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 0, mainAxisSpacing: 0),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PostDetailedPage(postsList[index])),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(postsList[index].imageURL),
                              fit: BoxFit.cover)),
                    ),
                  ),
                );
              })
          : Center(
              child: Text(
              "No hay posts subidos.",
              style: GoogleFonts.montserrat(color: Colors.white, fontSize: 15),
              textAlign: TextAlign.left,
            )),
    );
  }

  Padding gridSaved() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
      child: savedList.length != 0
          ? GridView.builder(
              itemCount: postsList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 0, mainAxisSpacing: 0),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                //TODO -> Hacer posts guardados cuando este la lista
                                "https://images.unsplash.com/photo-1621412989559-92f76025ad0d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=634&q=80"),
                            fit: BoxFit.cover)),
                  ),
                );
              })
          : Center(
              child: Text(
              "No hay posts guardados.",
              style: GoogleFonts.montserrat(color: Colors.white, fontSize: 15),
              textAlign: TextAlign.left,
            )),
    );
  }

  Positioned userDescription(double screenHeight, double screenWidth) {
    return Positioned(
      top: screenHeight * 0.21,
      child: Container(
        width: screenWidth,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: _currentUser.descripcion == null
                ? Text(
                    "",
                    style: GoogleFonts.montserrat(
                        color: Colors.white, fontSize: 13),
                    textAlign: TextAlign.justify,
                  )
                : Text(
                    "${_currentUser.descripcion}",
                    style: GoogleFonts.montserrat(
                        color: Colors.white, fontSize: 15),
                    textAlign: TextAlign.left,
                  )),
      ),
    );
  }

  Positioned userName(double screenHeight, double screenWidth) {
    return Positioned(
        top: screenHeight * 0.05,
        left: screenWidth * 0.43,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _currentUser.username == null
                ? Text("",
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w500))
                : Text("${_currentUser.username}",
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500))
          ],
        ));
  }

  Positioned profileImage(double screenWidth, double screenHeight) {
    return Positioned(
        left: screenWidth * 0.05,
        top: screenHeight * 0.03,
        child: _currentUser.profileimage == null
            ? Container(
                height: screenWidth * 0.34,
                width: screenWidth * 0.34,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage('assets/images/noimage.png'),
                      fit: BoxFit.cover),
                  color: Colors.white,
                ),
              )
            : Container(
                height: screenWidth * 0.34,
                width: screenWidth * 0.34,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade800, width: 2),
                  image: DecorationImage(
                      image: _currentUser.profileimage == ""
                          ? AssetImage('assets/images/noimage.png')
                          : NetworkImage(_currentUser.profileimage),
                      fit: BoxFit.cover),
                  color: Colors.white,
                ),
              ));
  }
}
