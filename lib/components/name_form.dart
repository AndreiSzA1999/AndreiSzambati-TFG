import 'package:aszcars_tfg_andrei/constants/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NameForm extends StatefulWidget {
  NameForm(
      {@required this.icono,
      @required this.labelhint,
      @required this.controllertext});

  final IconData icono;
  final String labelhint;
  final TextEditingController controllertext;

  @override
  _NameFormState createState() => _NameFormState();
}

class _NameFormState extends State<NameForm> {
  @override
  Widget build(BuildContext context) {
    ColorsPalette color = ColorsPalette();
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 70,
      width: screenWidth * 0.85,
      decoration: BoxDecoration(
          color: color.colorSecundario,
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 20, bottom: 16),
        child: TextFormField(
          controller: widget.controllertext,
          cursorColor: Colors.white,
          style: GoogleFonts.montserrat(
              color: Colors.white, fontWeight: FontWeight.w400),
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              focusColor: Colors.white,
              hoverColor: Colors.white,
              fillColor: Colors.white,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              icon: Icon(
                widget.icono,
                color: color.colorTextoSecundario,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelText: widget.labelhint,
              labelStyle: GoogleFonts.montserrat(
                  color: color.colorTextoSecundario, fontSize: 15)),
        ),
      ),
    );
  }
}
