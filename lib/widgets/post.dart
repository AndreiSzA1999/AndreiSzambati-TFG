import 'package:aszcars_tfg_andrei/constants/color_palette.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Post extends StatelessWidget {
  final String userName;
  final String userCar;
  final String description;
  final String imageURL;
  final int likes;
  final int comments;
  final bool saved;
  final String profile;
  final String postDocument;
  final bool canDelete;

  Post(
      {@required this.userName,
      @required this.userCar,
      @required this.description,
      @required this.imageURL,
      @required this.likes,
      @required this.comments,
      @required this.saved,
      @required this.profile,
      @required this.postDocument,
      @required this.canDelete});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    ColorsPalette color = new ColorsPalette();
    return Container(
      margin: EdgeInsets.all(10),
      width: screenWidth * 0.9,
      decoration: BoxDecoration(
          color: color.colorSecundario,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              CircleAvatar(
                  radius: 20,
                  backgroundImage: profile == null || profile.isEmpty
                      ? AssetImage("assets/images/noimage.png")
                      : NetworkImage(profile)),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(userName,
                      style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500)),
                  Text(userCar,
                      style: GoogleFonts.montserrat(
                          color: Colors.grey.shade600,
                          fontSize: 15,
                          fontWeight: FontWeight.w400)),
                ],
              ),
              Expanded(child: SizedBox()),
              canDelete
                  ? IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                  title: Text(
                                      "¿Seguro que quieres borrar la imagen?"),
                                  actions: [
                                    TextButton(
                                      child: Text("Si"),
                                      onPressed: () {
                                        FirebaseFirestore.instance
                                            .collection("posts")
                                            .doc(postDocument)
                                            .delete();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text("No"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ));
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    )
                  : SizedBox(width: 5),
              SizedBox(width: 5)
            ],
          ),
          SizedBox(height: 10),
          Container(
            width: screenWidth,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Text(
                description,
                textAlign: TextAlign.start,
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 13,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
              width: screenWidth,
              height: screenWidth,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        imageURL,
                      ),
                      fit: BoxFit.cover))),
          Row(
            children: [
              IconButton(
                icon: FaIcon(FontAwesomeIcons.solidHeart,
                    size: 20, color: Colors.white),
                onPressed: () {},
              ),
              Text("$likes",
                  style: GoogleFonts.montserrat(
                      color: Colors.grey.shade400,
                      fontWeight: FontWeight.w500)),
              SizedBox(width: 10),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.solidComments,
                    size: 20, color: Colors.white),
                onPressed: () {},
              ),
              Text("$comments",
                  style: GoogleFonts.montserrat(
                      color: Colors.grey.shade400,
                      fontWeight: FontWeight.w500)),
              Expanded(child: SizedBox()),
              IconButton(
                icon: Icon(
                  Ionicons.ios_paper_plane,
                  color: Colors.white,
                ),
                splashColor: Colors.black,
                onPressed: () {},
              ),
              IconButton(
                splashColor: Colors.black,
                icon: !saved
                    ? FaIcon(FontAwesomeIcons.bookmark,
                        size: 20, color: Colors.white)
                    : FaIcon(FontAwesomeIcons.solidBookmark,
                        size: 20, color: Colors.white),
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
