import 'package:aszcars_tfg_andrei/constants/color_palette.dart';
import 'package:aszcars_tfg_andrei/screens/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FirstScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    ColorsPalette color = ColorsPalette();
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: Stack(
        children: [
          Container(
            height: screenHeight,
            width: screenWidth,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/images/imagenscreen.jpg"),
              fit: BoxFit.fitHeight,
            )),
          ),
          Positioned(
              top: screenHeight * 0.67,
              child: Container(
                width: screenWidth,
                child: Column(
                  children: [
                    Text("ASZCARS",
                        style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 25,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 5.0,
                                color: Colors.black,
                              ),
                            ],
                            fontWeight: FontWeight.w600)),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Bienvenido a la mejor red social de coches, donde podras compartir tu pasión por los coches con mas amantes del mundo del motor!",
                      style: GoogleFonts.montserrat(
                          color: Colors.white,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(5.0, 5.0),
                              blurRadius: 4.0,
                              color: Colors.black,
                            ),
                          ],
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              )),
          Positioned(
            top: screenHeight * 0.85,
            left: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                    color: color.colorBoton,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Comenzar!",
                      style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
