import 'package:aszcars_tfg_andrei/components/email_form.dart';
import 'package:aszcars_tfg_andrei/components/name_form.dart';
import 'package:aszcars_tfg_andrei/components/password_form.dart';
import 'package:aszcars_tfg_andrei/constants/color_palette.dart';
import 'package:aszcars_tfg_andrei/services/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../main.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final nombreUsuario = TextEditingController();
  final password1 = TextEditingController();
  final password2 = TextEditingController();
  final email = TextEditingController();
  final DateTime timestamp = DateTime.now();
  String error = "";
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    ColorsPalette color = ColorsPalette();

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: color.fondo,
        body: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.06,
              width: screenWidth,
            ),
            Text("Crea una nueva cuenta",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.w500)),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Text("Rellena el formulario para continuar",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    color: Colors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.w400)),
            SizedBox(
              height: screenHeight * 0.09,
            ),
            NameForm(
              controllertext: nombreUsuario,
              icono: Icons.person,
              labelhint: "Nombre de Usuario",
            ),
            SizedBox(height: 15),
            EmailForm(
              controllertext: email,
              icono: Icons.email,
              labelhint: "Email",
            ),
            SizedBox(height: 15),
            PasswordForm(
              controllertext: password1,
              icono: Icons.lock,
              labelhint: "Contraseña",
            ),
            SizedBox(height: 15),
            PasswordForm(
              controllertext: password2,
              icono: Icons.lock,
              labelhint: "Repetir Contraseña",
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              error,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.w400,
                  fontSize: 13),
            ),
            SizedBox(
              height: screenHeight * 0.05,
            ),
            Container(
              height: 70,
              width: screenWidth * 0.85,
              decoration: BoxDecoration(
                  color: color.colorBoton,
                  borderRadius: BorderRadius.circular(20)),
              child: GestureDetector(
                onTap: () async {
                  String p =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regExp = new RegExp(p);

                  if (regExp.hasMatch(email.text) &&
                      email.text.isNotEmpty &&
                      password1.text.isNotEmpty) {
                    final logMessage = await context
                        .read<AuthenticationService>()
                        .signUp(email: email.text, password: password1.text);
                    if (logMessage == "Signed Up") {
                      Navigator.of(context).pushReplacement(
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  AuthenticationWrapper()));
                    } else {
                      setState(() {
                        error = logMessage;
                      });
                    }
                  } else {
                    setState(() {
                      error = "No puede haber campos vacios o no validos";
                    });
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Registrarse",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Ya tienes una cuenta",
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500)),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text("Inicia Sesión",
                      style: GoogleFonts.montserrat(
                          color: color.colorBoton,
                          fontSize: 15,
                          fontWeight: FontWeight.w500)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  createUserInFirestore() async {
    context.read<AuthenticationService>().addUserToDB(
        uid: auth.currentUser.uid,
        username: nombreUsuario.text,
        email: auth.currentUser.email,
        timestamp: timestamp);
  }
}
