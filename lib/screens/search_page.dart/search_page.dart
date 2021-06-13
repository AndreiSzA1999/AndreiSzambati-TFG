import 'dart:convert';
import 'package:aszcars_tfg_andrei/constants/color_palette.dart';
import 'package:aszcars_tfg_andrei/models/posts.dart';
import 'package:aszcars_tfg_andrei/models/user.dart';
import 'package:aszcars_tfg_andrei/screens/add_picture_screen/coche.dart';
import 'package:aszcars_tfg_andrei/screens/detail_screen/detail_screen.dart';
import 'package:aszcars_tfg_andrei/services/authentication_service.dart';
import 'package:aszcars_tfg_andrei/widgets/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool teclado = false;
  List<Coche> _coches = [];
  final List<String> _allCars = [];
  List<String> _withFilter = [];
  TextEditingController car = TextEditingController();
  ColorsPalette colors = ColorsPalette();
  List<Post> postsList = [];

  @override
  void initState() {
    super.initState();
    getPostFromDB();
    readJson();
    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardVisibilityController.onChange.listen((bool visible) {
      setState(() {
        teclado = visible;
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
              header(),
              buscador(),
              !teclado
                  ? gridPosts()
                  : Expanded(
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemCount: _withFilter.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                car.text = _withFilter[index];
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);
                                postsList.clear();
                                getPostFromDB();
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                              });
                            },
                            child: Card(
                                color: colors.colorSecundario,
                                child: ListTile(
                                  title: Text(
                                    _withFilter[index],
                                    style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20),
                                  ),
                                )),
                          );
                        },
                      ),
                    ),
            ],
          )),
    );
  }

  Expanded gridPosts() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Container(
            child: GridView.builder(
                itemCount: postsList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, crossAxisSpacing: 1, mainAxisSpacing: 0),
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
                })),
      ),
    );
  }

  Container header() {
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 60,
      width: screenWidth,
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "EXPLORAR",
            style: GoogleFonts.montserrat(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
          ),
        ],
      ),
    );
  }

  Padding buscador() {
    var screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
      child: Container(
        height: 60,
        width: screenWidth,
        decoration: BoxDecoration(
            color: colors.colorSecundario,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Row(
          children: [
            SizedBox(
              width: 15,
            ),
            Icon(Icons.search, color: Colors.white, size: 30),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextFormField(
                onTap: () {
                  car.clear();
                },
                controller: car,
                onChanged: (value) => onItemChanged(value),
                textInputAction: TextInputAction.done,
                style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 18),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Busca un coche",
                  hintStyle: GoogleFonts.montserrat(
                      color: colors.colorTextoSecundario,
                      fontWeight: FontWeight.w400,
                      fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/json/coches.json');
    final data = await json.decode(response);

    setState(() {
      for (final item in data) {
        _coches.add(Coche(item["brand"], item["models"]));
      }
    });

    setState(() {
      for (int i = 0; i < _coches.length; i++) {
        for (int j = 0; j < _coches[i].modelos.length; j++) {
          _allCars.add(_coches[i].marca + " " + _coches[i].modelos[j]);
        }
      }

      _withFilter = List.from(_allCars);
    });
  }

  onItemChanged(String value) {
    setState(() {
      _withFilter = _allCars
          .where((string) => string.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  Future<UserModel> getCurrentUser(String uid) async {
    print("Cogiendo usuario****************************");
    UserModel currentUser =
        await context.read<AuthenticationService>().getUserFromDB(uid: uid);
    print("usuario cogido");
    return currentUser;
  }

  Future<void> getPostFromDB() async {
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
          saved: false,
          userName: usuario.username,
          comments: datosPost.comments,
          likes: datosPost.likes,
        );
        if (car.text == "") {
          setState(() {
            postsList.add(post);
          });
        } else {
          if (post.userCar == car.text) {
            setState(() {
              postsList.add(post);
            });
          }
        }
      });
    });
  }
}
