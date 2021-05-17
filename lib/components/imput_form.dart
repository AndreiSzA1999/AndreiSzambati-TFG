import 'package:aszcars_tfg_andrei/constants/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputForm extends StatelessWidget {
  InputForm(
      {@required this.screenWidth,
      @required this.icono,
      @required this.labelhint,
      @required this.password});

  final double screenWidth;
  final IconData icono;
  final String labelhint;
  final bool password;

  @override
  Widget build(BuildContext context) {
    ColorsPalette color = ColorsPalette();

    return Container(
      height: 70,
      width: screenWidth * 0.85,
      decoration: BoxDecoration(
          color: color.colorSecundario,
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 20, bottom: 16),
        child: TextFormField(
          obscureText: password,
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
                icono,
                color: color.colorTextoSecundario,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelText: labelhint,
              labelStyle: GoogleFonts.montserrat(
                  color: color.colorTextoSecundario, fontSize: 15)),
        ),
      ),
    );
  }
}
