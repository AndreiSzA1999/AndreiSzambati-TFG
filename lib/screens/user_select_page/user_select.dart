import 'package:aszcars_tfg_andrei/constants/color_palette.dart';

import 'package:aszcars_tfg_andrei/models/user.dart';
import 'package:aszcars_tfg_andrei/services/authentication_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nanoid/nanoid.dart';
import 'package:provider/provider.dart';

class UserSelectPage extends StatefulWidget {
  final String postUid;

  UserSelectPage(this.postUid);

  @override
  _UserSelectPageState createState() => _UserSelectPageState();
}

class _UserSelectPageState extends State<UserSelectPage> {
  List<UserModel> usuarios = [];
  List<bool> enviados = List<bool>.generate(100, (index) => false);
  TextEditingController nombreUsuario = TextEditingController();
  String estado;
  FirebaseAuth auth;

  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;
    estado = "buscando";
    getUser();
  }

  Future<void> getUser() async {
    await FirebaseFirestore.instance
        .collection("users")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) async {
        UserModel user = await context
            .read<AuthenticationService>()
            .getUserFromDB(uid: result["uid"]);
        if (user.uid != auth.currentUser.uid) {
          setState(() {
            usuarios.add(user);
          });
        }
      });
    });
    setState(() {
      estado = "terminado";
    });
  }

  Future<void> getFilterUser(String filter) async {
    await FirebaseFirestore.instance
        .collection("users")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) async {
        UserModel user = await context
            .read<AuthenticationService>()
            .getUserFromDB(uid: result["uid"]);

        if (user.username.toLowerCase().contains(filter.toLowerCase())) {
          setState(() {
            usuarios.add(user);
          });
        }
      });
    });
    setState(() {
      estado = "terminado";
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            children: [
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
                        "ENVIAR MENSAJE",
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                child: Container(
                  height: 60,
                  width: screenWidth,
                  decoration: BoxDecoration(
                      color: ColorsPalette().colorSecundario,
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
                          controller: nombreUsuario,
                          onTap: () {
                            nombreUsuario.clear();
                            usuarios.clear();
                            getUser();
                          },
                          onChanged: (value) {
                            setState(() {
                              usuarios.clear();
                              getFilterUser(value);
                            });
                          },
                          textInputAction: TextInputAction.done,
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 18),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Busca usuario",
                            hintStyle: GoogleFonts.montserrat(
                                color: ColorsPalette().colorTextoSecundario,
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              estado != "buscando"
                  ? Expanded(
                      child: ListView.builder(
                          itemCount: usuarios.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        usuarios[index].profileimage),
                                    radius: 30,
                                  ),
                                  title: Text(
                                    usuarios[index].username,
                                    style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 22),
                                  ),
                                  trailing: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: enviados[index]
                                          ? Icon(
                                              Icons.send,
                                              color: ColorsPalette().colorBoton,
                                            )
                                          : GestureDetector(
                                              onTap: () async {
                                                setState(() {
                                                  enviados[index] =
                                                      !enviados[index];
                                                });
                                                final messagesRef =
                                                    FirebaseFirestore.instance
                                                        .collection("messages");
                                                await messagesRef.add({
                                                  "from": auth.currentUser.uid,
                                                  "to": usuarios[index].uid,
                                                  "postid": widget.postUid,
                                                  "unicuid": nanoid(10)
                                                });
                                              },
                                              child: Icon(
                                                Icons.send,
                                                color: Colors.white,
                                              ),
                                            )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: Divider(
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            );
                          }),
                    )
                  : Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
            ],
          )),
    );
  }
}
