import 'package:aszcars_tfg_andrei/constants/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordForm extends StatefulWidget {
  PasswordForm(
      {@required this.icono,
      @required this.labelhint,
      @required this.controllertext});

  final IconData icono;
  final String labelhint;

  final TextEditingController controllertext;

  @override
  _PasswordFormState createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  bool verPassword = true;

  @override
  Widget build(BuildContext context) {
    ColorsPalette color = ColorsPalette();
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(children: [
      Container(
        height: 70,
        width: screenWidth * 0.85,
        decoration: BoxDecoration(
            color: color.colorSecundario,
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 20, bottom: 16),
          child: TextFormField(
            controller: widget.controllertext,
            obscureText: verPassword,
            cursorColor: Colors.white,
            inputFormatters: [
              new LengthLimitingTextInputFormatter(18),
            ],
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
                  widget.icono,
                  color: color.colorTextoSecundario,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelText: widget.labelhint,
                labelStyle: GoogleFonts.montserrat(
                    color: color.colorTextoSecundario, fontSize: 15)),
          ),
        ),
      ),
      Positioned(
          left: screenWidth * 0.68,
          top: MediaQuery.of(context).size.height * 0.03,
          child: GestureDetector(
            onTap: () {
              setState(() {
                verPassword = !verPassword;
              });
            },
            child: Icon(
              Icons.remove_red_eye,
              color: ColorsPalette().colorTextoSecundario,
            ),
          ))
    ]);
  }
}
