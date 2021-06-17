import 'dart:convert';
import 'dart:io';
import 'package:aszcars_tfg_andrei/constants/color_palette.dart';
import 'package:aszcars_tfg_andrei/models/posts.dart';
import 'package:aszcars_tfg_andrei/models/user.dart';
import 'package:aszcars_tfg_andrei/services/authentication_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../main.dart';
import 'coche.dart';

class AddPicturePage extends StatefulWidget {
  @override
  _AddPicturePageState createState() => _AddPicturePageState();
}

class _AddPicturePageState extends State<AddPicturePage> {
  FirebaseAuth auth = FirebaseAuth.instance;

  String _uid;

  UserModel _currentUser;
  ColorsPalette color = ColorsPalette();
  final TextEditingController car = TextEditingController();
  final TextEditingController descripcion = TextEditingController();
  File _imagefile;
  ImagePicker imagePicker = ImagePicker();
  String imageUrl;
  bool show;
  String publicada;

  Future<void> _chooseImage() async {
    PickedFile pickedFile = await imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 20);
    setState(() {
      _imagefile = File(pickedFile.path);
    });
    _uploadImage();
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    publicada = "";
    imageUrl = "";
    show = false;
  }

  getCurrentUser() async {
    UserModel currentUser = await context
        .read<AuthenticationService>()
        .getUserFromDB(uid: auth.currentUser.uid);
    _currentUser = currentUser;
    setState(() {
      _uid = _currentUser.uid;
    });
  }

  void _uploadImage() async {
    String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();
    final _firebaseStorage = FirebaseStorage.instance;

    var snapshot = await _firebaseStorage
        .ref()
        .child('posts/')
        .child(imageFileName)
        .putFile(_imagefile);

    var downloadUrl = await snapshot.ref.getDownloadURL();
    setState(() {
      imageUrl = downloadUrl;
      show = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "CREAR POST NUEVO",
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  )
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      _chooseImage();
                    },
                    child: Container(
                        height: screenWidth * 0.30,
                        width: screenWidth * 0.30,
                        decoration: BoxDecoration(
                            color: color.colorSecundario,
                            borderRadius: BorderRadius.circular(20),
                            image: imageUrl == ""
                                ? DecorationImage(
                                    scale: 10,
                                    image: AssetImage(
                                      'assets/images/camara.png',
                                    ),
                                  )
                                : DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(imageUrl),
                                  ))),
                  ),
                  GestureDetector(
                    onTap: () {
                      _navigateAndDisplaySelection(context);
                    },
                    child: Container(
                      height: screenWidth * 0.20,
                      width: screenWidth * 0.50,
                      decoration: BoxDecoration(
                          color: color.colorSecundario,
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, left: 20, bottom: 16),
                        child: TextFormField(
                          enabled: false,
                          controller: car,
                          obscureText: false,
                          cursorColor: Colors.white,
                          style: GoogleFonts.montserrat(
                              color: Colors.white, fontWeight: FontWeight.w400),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              focusColor: Colors.white,
                              hoverColor: Colors.white,
                              fillColor: Colors.white,
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              icon: Icon(
                                Icons.car_rental,
                                color: color.colorTextoSecundario,
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              labelText: "Seleccionar Coche",
                              labelStyle: GoogleFonts.montserrat(
                                  color: color.colorTextoSecundario,
                                  fontSize: 15)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                height: 100,
                width: screenWidth * 0.85,
                decoration: BoxDecoration(
                    color: color.colorSecundario,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 20),
                  child: TextFormField(
                    controller: descripcion,
                    obscureText: false,
                    cursorColor: Colors.white,
                    style: GoogleFonts.montserrat(
                        color: Colors.white, fontWeight: FontWeight.w400),
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    maxLength: 50,
                    decoration: InputDecoration(
                        counterText: '',
                        focusColor: Colors.white,
                        hoverColor: Colors.white,
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelText: "Descripcion",
                        labelStyle: GoogleFonts.montserrat(
                            color: color.colorTextoSecundario, fontSize: 15)),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              show
                  ? car.text != ""
                      ? Container(
                          height: 70,
                          width: screenWidth * 0.85,
                          decoration: BoxDecoration(
                              color: color.colorBoton,
                              borderRadius: BorderRadius.circular(20)),
                          child: GestureDetector(
                            onTap: () {
                              addPostToDB();
                              setState(() {
                                publicada = "Post publicado.";
                              });
                              Future.delayed(const Duration(milliseconds: 100),
                                  () {
                                Navigator.of(context).pushReplacement(
                                    new MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            AuthenticationWrapper()));
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Publicar",
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13),
                                )
                              ],
                            ),
                          ))
                      : Container(
                          height: 70,
                          width: screenWidth * 0.85,
                          decoration: BoxDecoration(
                              color: color.colorSecundario,
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Selecciona un coche",
                                style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13),
                              )
                            ],
                          ),
                        )
                  : Container(
                      height: 70,
                      width: screenWidth * 0.85,
                      decoration: BoxDecoration(
                          color: color.colorSecundario,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Selecciona una imagen",
                            style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 13),
                          )
                        ],
                      ),
                    ),
              SizedBox(
                height: 20,
              ),
              Text(
                publicada,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addPostToDB() async {
    final userRef = FirebaseFirestore.instance.collection("posts");
    final postModel = PostModel(
        uid: _uid,
        likes: 0,
        comments: 0,
        descripcion: descripcion.text,
        imageLink: imageUrl,
        usercar: car.text,
        timestamp: Timestamp.now());
    await userRef.doc().set(postModel.toMap(postModel));
  }

  void _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ElegirCoche()),
    );

    setState(() {
      car.text = result;
    });
  }
}

class ElegirCoche extends StatefulWidget {
  @override
  _ElegirCocheState createState() => _ElegirCocheState();
}

class _ElegirCocheState extends State<ElegirCoche> {
  ColorsPalette color = ColorsPalette();

  List<Coche> _coches = [];

  final List<String> _allCars = [];
  List<String> _withFilter = [];
  onItemChanged(String value) {
    setState(() {
      _withFilter = _allCars
          .where((string) => string.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          body: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  "ELEGIR COCHE",
                  style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                )
              ],
            ),
            Container(
              height: 70,
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: BoxDecoration(
                  color: color.colorSecundario,
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20, bottom: 16),
                child: TextField(
                  onChanged: (value) => onItemChanged(value),
                  cursorColor: Colors.white,
                  style: GoogleFonts.montserrat(
                      color: Colors.white, fontWeight: FontWeight.w400),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      focusColor: Colors.white,
                      hoverColor: Colors.white,
                      fillColor: Colors.white,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      icon: Icon(
                        Icons.search,
                        color: color.colorTextoSecundario,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: "Elegir coche",
                      labelStyle: GoogleFonts.montserrat(
                          color: color.colorTextoSecundario, fontSize: 15)),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: _withFilter.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(context, _withFilter[index]);
                    },
                    child: Card(
                        color: color.colorSecundario,
                        child: ListTile(
                          title: Text(
                            _withFilter[index],
                            style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        )),
                  );
                },
              ),
            ),
          ])),
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
}
