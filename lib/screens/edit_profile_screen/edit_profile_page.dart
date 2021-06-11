import 'dart:io';
import 'package:aszcars_tfg_andrei/components/name_form.dart';
import 'package:aszcars_tfg_andrei/constants/color_palette.dart';
import 'package:aszcars_tfg_andrei/main.dart';
import 'package:aszcars_tfg_andrei/models/user.dart';
import 'package:aszcars_tfg_andrei/services/authentication_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String _profileImage;
  String _nombreUsuario;
  String _description;
  String _newProfileImage;
  String _error = "";

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  getCurrentUser() async {
    UserModel currentUser = await context
        .read<AuthenticationService>()
        .getUserFromDB(uid: auth.currentUser.uid);

    _currentUser = currentUser;
    setState(() {
      _profileImage = _currentUser.profileimage;
      _nombreUsuario = _currentUser.username;
      _description = _currentUser.descripcion;
    });
  }

  //Obtenemos el usuario actual
  FirebaseAuth auth = FirebaseAuth.instance;
  UserModel _currentUser;

  ColorsPalette color = ColorsPalette();

  // Metodos

  File _imagefile;
  ImagePicker imagePicker = ImagePicker();

  Future<void> _chooseImage() async {
    PickedFile pickedFile = await imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 10);
    setState(() {
      _imagefile = File(pickedFile.path);
    });
    _uploadImage();
  }

  void _uploadImage() async {
    String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();
    final _firebaseStorage = FirebaseStorage.instance;

    var snapshot = await _firebaseStorage
        .ref()
        .child('profile/')
        .child(imageFileName)
        .putFile(_imagefile);

    var downloadUrl = await snapshot.ref.getDownloadURL();
    setState(() {
      _newProfileImage = downloadUrl;
    });
  }

  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          body: _description != null
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: width,
                        height: height * 0.1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                                icon:
                                    Icon(Icons.arrow_back, color: Colors.white),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                }),
                            Text(
                              "EDITAR PERFIL",
                              style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _chooseImage();
                            _newProfileImage = "";
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage:
                              _profileImage == null || _profileImage == ""
                                  ? AssetImage("assets/images/noimage.png")
                                  : _newProfileImage == "" ||
                                          _newProfileImage == null
                                      ? NetworkImage(_profileImage)
                                      : NetworkImage(_newProfileImage),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 40,
                          ),
                          radius: 60,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      NameForm(
                          icono: Icons.person,
                          labelhint: "Nuevo nombre",
                          controllertext: nombreController),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Container(
                        height: 150,
                        width: width * 0.85,
                        decoration: BoxDecoration(
                            color: color.colorSecundario,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 20, bottom: 16),
                          child: TextFormField(
                            controller: descripcionController,
                            obscureText: false,
                            cursorColor: Colors.white,
                            style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.next,
                            maxLines: 3,
                            maxLength: 50,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 10, right: 10, bottom: 10),
                                focusColor: Colors.white,
                                hoverColor: Colors.white,
                                fillColor: Colors.white,
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                icon: Icon(
                                  Icons.description,
                                  color: color.colorTextoSecundario,
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                labelText: "Nueva Descripcion",
                                labelStyle: GoogleFonts.montserrat(
                                    color: color.colorTextoSecundario,
                                    fontSize: 15)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      _newProfileImage == ""
                          ? Container(
                              height: 70,
                              width: width * 0.85,
                              decoration: BoxDecoration(
                                  color: color.colorSecundario,
                                  borderRadius: BorderRadius.circular(20)),
                              child: GestureDetector(
                                onTap: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Subiendo Imagen",
                                      style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Container(
                              height: 70,
                              width: width * 0.85,
                              decoration: BoxDecoration(
                                  color: color.colorBoton,
                                  borderRadius: BorderRadius.circular(20)),
                              child: GestureDetector(
                                onTap: () {
                                  if (nombreController.text.length == 0 ||
                                      descripcionController.text.length == 0) {
                                    setState(() {
                                      _error = "No puede haber campos vacios";
                                    });
                                  } else {
                                    if (_newProfileImage == "" ||
                                        _newProfileImage == null) {
                                      updateDescription();
                                      updateUser();
                                      setState(() {
                                        _error = "Actualizado";
                                      });
                                      Future.delayed(
                                          const Duration(milliseconds: 100),
                                          () {
                                        Navigator.of(context).pushReplacement(
                                            new MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    AuthenticationWrapper()));
                                      });
                                    } else {
                                      updateDescription();
                                      updateUser();
                                      updatePhoto();
                                      setState(() {
                                        _error = "Actualizado";
                                      });
                                      Future.delayed(
                                          const Duration(milliseconds: 100),
                                          () {
                                        Navigator.of(context).pushReplacement(
                                            new MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    AuthenticationWrapper()));
                                      });
                                    }
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Guardar",
                                      style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13),
                                    )
                                  ],
                                ),
                              ),
                            ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        _error,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.w400,
                            fontSize: 13),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                )),
    );
  }

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> updateUser() {
    return users
        .doc(_currentUser.uid)
        .update({'username': nombreController.text})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> updateDescription() {
    return users
        .doc(_currentUser.uid)
        .update({'descripcion': descripcionController.text})
        .then((value) => print("Descripcion Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> updatePhoto() {
    return users
        .doc(_currentUser.uid)
        .update({'profileimage': _newProfileImage})
        .then((value) => print("Photo Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
}
