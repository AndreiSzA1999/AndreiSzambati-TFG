import 'package:aszcars_tfg_andrei/screens/color_palette.dart';
import 'package:aszcars_tfg_andrei/screens/login/components/input_form.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
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
            InputForm(
              screenWidth: screenWidth,
              icono: Icons.email,
              labelhint: "Email",
            ),
            SizedBox(height: 15),
            InputForm(
              screenWidth: screenWidth,
              icono: Icons.lock,
              labelhint: "Contraseña",
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Has olvidado la contraseña?",
              style: GoogleFonts.montserrat(
                  color: color.colorTextoSecundario,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
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
            SizedBox(
              height: 15,
            ),
            Container(
              height: 70,
              width: screenWidth * 0.85,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
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
                Text("Registrate",
                    style: GoogleFonts.montserrat(
                        color: color.colorBoton,
                        fontSize: 15,
                        fontWeight: FontWeight.w500)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
