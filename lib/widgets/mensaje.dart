import 'package:aszcars_tfg_andrei/widgets/post.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Mensaje extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "09/05/2021",
                style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 10),
              ),
            ],
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            "Andrei te ha enviado un mensaje",
            style: GoogleFonts.montserrat(
                color: Colors.white, fontWeight: FontWeight.w300, fontSize: 10),
          ),
          Post(
            userName: "AndreiSzA",
            userCar: "Wolkswagen Golf R",
            description:
                "Malesuada facilisi eget dis et sed proin, accumsan magnis elementum inceptos pulvinar conubia rhoncus, per magna ridiculus fringilla vehicula.",
            imageURL:
                "https://images.unsplash.com/photo-1565756875620-3e1b865daac0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1350&q=80",
            likes: 32422,
            comments: 1232,
            saved: true,
            profile:
                "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80",
            canDelete: true,
            postDocument: '',
            userUid: '',
          ),
        ],
      ),
    );
  }
}
