import 'package:aszcars_tfg_andrei/widgets/post.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Mensaje extends StatelessWidget {
  final String nombreRemitente;
  final String nombreCreadorPost;
  final String cochePost;
  final String descripcion;
  final String imgUrl;
  final int likes;
  final int comments;
  final String fotoPerfil;
  final String uidUnico;
  Mensaje(
      {@required this.nombreRemitente,
      @required this.nombreCreadorPost,
      @required this.cochePost,
      @required this.descripcion,
      @required this.likes,
      @required this.comments,
      @required this.imgUrl,
      @required this.fotoPerfil,
      @required this.uidUnico});

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
          SizedBox(
            height: 5.0,
          ),
          Text(
            "$nombreRemitente te ha enviado un mensaje",
            style: GoogleFonts.montserrat(
                color: Colors.white, fontWeight: FontWeight.w300, fontSize: 10),
          ),
          Post(
            liked: false,
            userName: nombreCreadorPost,
            userCar: cochePost,
            description: descripcion,
            imageURL: imgUrl,
            likes: likes,
            comments: comments,
            saved: false,
            profile: fotoPerfil,
            canDelete: false,
            postDocument: '',
            userUid: '',
          ),
        ],
      ),
    );
  }
}
