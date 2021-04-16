import 'package:aszcars_tfg_andrei/components/input_form.dart';
import 'package:aszcars_tfg_andrei/constants/color_palette.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatelessWidget {
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
            InputForm(
              screenWidth: screenWidth,
              icono: Icons.email,
              labelhint: "Nombre de Usuario",
              password: false,
            ),
            SizedBox(height: 15),
            InputForm(
              screenWidth: screenWidth,
              icono: Icons.lock,
              labelhint: "Email",
              password: false,
            ),
            SizedBox(height: 15),
            InputForm(
              screenWidth: screenWidth,
              icono: Icons.lock,
              labelhint: "Contraseña",
              password: true,
            ),
            SizedBox(height: 15),
            InputForm(
              screenWidth: screenWidth,
              icono: Icons.lock,
              labelhint: "Repetir Contraseña",
              password: true,
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
                    "Registrarse",
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
}
