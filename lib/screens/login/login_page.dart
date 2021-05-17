import 'package:aszcars_tfg_andrei/constants/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController email = TextEditingController();
  final password = TextEditingController();

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
            Container(
              height: 70,
              width: screenWidth * 0.85,
              decoration: BoxDecoration(
                  color: color.colorSecundario,
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20, bottom: 16),
                child: TextFormField(
                  controller: email,
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
                        Icons.email,
                        color: color.colorTextoSecundario,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: "Email",
                      labelStyle: GoogleFonts.montserrat(
                          color: color.colorTextoSecundario, fontSize: 15)),
                ),
              ),
            ),
            SizedBox(height: 15),
            Container(
              height: 70,
              width: screenWidth * 0.85,
              decoration: BoxDecoration(
                  color: color.colorSecundario,
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20, bottom: 16),
                child: TextFormField(
                  controller: password,
                  obscureText: true,
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
                        Icons.security,
                        color: color.colorTextoSecundario,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: "Contraseña",
                      labelStyle: GoogleFonts.montserrat(
                          color: color.colorTextoSecundario, fontSize: 15)),
                ),
              ),
            ),
            SizedBox(
              height: 20,
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
                onTap: () {
                  print("Resultados-------------------------------");
                  print(email.text);
                  print(password.text);
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
                    Navigator.pushNamed(context, 'register');
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
