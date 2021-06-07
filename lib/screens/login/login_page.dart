import 'package:aszcars_tfg_andrei/components/email_form.dart';
import 'package:aszcars_tfg_andrei/components/password_form.dart';
import 'package:aszcars_tfg_andrei/constants/color_palette.dart';

import 'package:aszcars_tfg_andrei/screens/register/register_page.dart';
import 'package:aszcars_tfg_andrei/services/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final DateTime timestamp = DateTime.now();
  final TextEditingController email = TextEditingController();
  final password = TextEditingController();
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
              height: screenHeight * 0.12,
              width: screenWidth,
            ),
            Text("Bienvenido!",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.w500)),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Text("Por favor, inicia sesión en tu cuenta",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    color: Colors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.w400)),
            SizedBox(
              height: screenHeight * 0.09,
            ),
            EmailForm(
              controllertext: email,
              icono: Icons.email,
              labelhint: "Email",
            ),
            SizedBox(height: 15),
            PasswordForm(
              controllertext: password,
              icono: Icons.lock,
              labelhint: "Contraseña",
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
              height: screenHeight * 0.1,
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
                      password.text.isNotEmpty) {
                    final resultadoLogin = await context
                        .read<AuthenticationService>()
                        .signIn(email: email.text, password: password.text);
                    if (resultadoLogin == "Signed In") {
                      Navigator.of(context).pushReplacement(
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  AuthenticationWrapper()));
                    } else {
                      setState(() {
                        error = resultadoLogin;
                      });
                    }
                  } else {
                    setState(() {
                      error = "Email o contraseña introducidos \n no validos";
                    });
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Iniciar Sesión",
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
              height: 15,
            ),
            Container(
              height: 70,
              width: screenWidth * 0.85,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: GestureDetector(
                onTap: () {
                  print("Con google");
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/google-logo.png",
                      height: 40,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Iniciar Sesión con Google",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600, fontSize: 13),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("No tienes una cuenta?",
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500)),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  child: Text("Registrate",
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
}
