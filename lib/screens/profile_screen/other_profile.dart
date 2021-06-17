import 'package:aszcars_tfg_andrei/models/posts.dart';
import 'package:aszcars_tfg_andrei/models/savedPostmodel.dart';
import 'package:aszcars_tfg_andrei/models/user.dart';
import 'package:aszcars_tfg_andrei/screens/detail_screen/detail_screen.dart';
import 'package:aszcars_tfg_andrei/services/authentication_service.dart';
import 'package:aszcars_tfg_andrei/widgets/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OtherProfilePage extends StatefulWidget {
  final userUid;

  OtherProfilePage(this.userUid);

  @override
  _OtherProfilePageState createState() => _OtherProfilePageState();
}

class _OtherProfilePageState extends State<OtherProfilePage> {
  //Booleano para controlar los posts
  bool posts;

  //Obtenemos el usuario actual

  UserModel _currentUser;

  //Aqui cogemos y guardamos todos los posts que el usuario haya creado
  List<Post> postsList = [];
  String status;
  @override
  void initState() {
    status = "nada";
    getCurrentUser(widget.userUid);
    posts = true;
    super.initState();
  }

  getCurrentUser(String uid) async {
    UserModel currentUser =
        await context.read<AuthenticationService>().getUserFromDB(uid: uid);
    setState(() {
      _currentUser = currentUser;
    });

    getPostFromDB();
  }

  Future<UserModel> getUserFromPost(String uid) async {
    UserModel currentUser =
        await context.read<AuthenticationService>().getUserFromDB(uid: uid);

    return currentUser;
  }

  @override
  void dispose() {
    postsList.clear();
    super.dispose();
  }

  Future<void> getPostFromDB() async {
    List<String> postsSavedByCurrentUser = [];
    List<String> postsLikedByCurrentUser = [];
    FirebaseFirestore.instance.collection("saved").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) async {
        final datosPost = SavedPostModel.fromMap(result.data());

        if (datosPost.userWhoSaved == _currentUser.uid) {
          setState(() {
            postsSavedByCurrentUser.add(datosPost.postDocument);
          });
        }
      });
    });

    FirebaseFirestore.instance.collection("likes").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) async {
        if (result["userWhoLikedUid"] == _currentUser.uid) {
          setState(() {
            postsLikedByCurrentUser.add(result["postDoc"]);
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
        UserModel usuario = await getUserFromPost(datosPost.uid);

        Post post = Post(
          liked: postsLikedByCurrentUser.contains(result.id) ? true : false,
          userUid: _currentUser.uid,
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

        if (datosPost.uid == _currentUser.uid) {
          setState(() {
            postsList.add(post);
          });
        }
      });
      setState(() {
        status = "done";
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
        body: status != "nada"
            ? Stack(
                children: [
                  Container(
                    height: screenHeight,
                    width: screenWidth,
                    color: Colors.black,
                  ),
                  Container(
                    height: 60,
                    width: screenWidth,
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(Icons.arrow_back,
                                  color: Colors.white, size: 30)),
                          Text(
                            "PERFIL",
                            style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          ),
                          SizedBox(width: 30),
                        ],
                      ),
                    ),
                  ),
                  profileImage(screenWidth, screenHeight),
                  userName(screenHeight, screenWidth),
                  userDescription(screenHeight, screenWidth),
                  botonEditarPerfil(screenHeight, screenWidth, context),
                  Positioned(
                    top: screenHeight * 0.34,
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
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      top: screenHeight * 0.42,
                      child: Container(
                          height: screenHeight * 0.3,
                          width: screenWidth,
                          color: Colors.black,
                          child: gridOwnPosts())),
                ],
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Positioned botonEditarPerfil(
      double screenHeight, double screenWidth, BuildContext context) {
    return Positioned(
      top: screenHeight * 0.13,
      left: screenWidth * 0.43,
      child: Container(
        height: 50,
        width: screenWidth * 0.3,
        decoration: BoxDecoration(
            color: Colors.transparent, borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "POSTS : ${postsList.length}",
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            )
          ],
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
          width: screenWidth * 0.94,
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
                    ).then((_) {
                      postsList.clear();
                      setState(() {
                        getCurrentUser(widget.userUid);
                      });
                    });
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

  Positioned userDescription(double screenHeight, double screenWidth) {
    return Positioned(
      top: screenHeight * 0.25,
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
        top: screenHeight * 0.08,
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
        top: screenHeight * 0.08,
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
