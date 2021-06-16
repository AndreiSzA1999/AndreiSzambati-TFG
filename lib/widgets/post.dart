import 'package:aszcars_tfg_andrei/constants/color_palette.dart';
import 'package:aszcars_tfg_andrei/models/savedPostmodel.dart';
import 'package:aszcars_tfg_andrei/screens/coments_screen/post_comments.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_icons/flutter_icons.dart';

// ignore: must_be_immutable
class Post extends StatefulWidget {
  final String userName;
  final String userCar;
  final String description;
  final String imageURL;
  int likes;
  int comments;
  bool saved;
  final String profile;
  final String postDocument;
  final bool canDelete;
  final String userUid;
  bool liked;
  Post(
      {@required this.userUid,
      @required this.userName,
      @required this.userCar,
      @required this.description,
      @required this.imageURL,
      @required this.likes,
      @required this.comments,
      @required this.saved,
      @required this.profile,
      @required this.postDocument,
      @required this.canDelete,
      @required this.liked});

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    ColorsPalette color = new ColorsPalette();
    return Container(
      margin: EdgeInsets.all(10),
      width: screenWidth * 0.9,
      decoration: BoxDecoration(
        color: color.colorSecundario,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
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
                  backgroundImage:
                      widget.profile == null || widget.profile.isEmpty
                          ? AssetImage("assets/images/noimage.png")
                          : NetworkImage(widget.profile)),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.userName,
                      style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500)),
                  widget.userCar.length < 20
                      ? Text(widget.userCar,
                          style: GoogleFonts.montserrat(
                              color: Colors.grey.shade600,
                              fontSize: 15,
                              fontWeight: FontWeight.w400))
                      : Text(widget.userCar.substring(0, 20) + "...",
                          style: GoogleFonts.montserrat(
                              color: Colors.grey.shade600,
                              fontSize: 15,
                              fontWeight: FontWeight.w400)),
                ],
              ),
              Expanded(
                child: SizedBox(),
              ),
              widget.canDelete
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
                                            .doc(widget.postDocument)
                                            .delete();
                                        deletePostFromSavedDB();
                                        Navigator.of(context)
                                            .popUntil((route) => route.isFirst);
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
                widget.description,
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
                        widget.imageURL,
                      ),
                      fit: BoxFit.cover))),
          Row(
            children: [
              widget.liked
                  ? IconButton(
                      icon: FaIcon(FontAwesomeIcons.solidHeart,
                          size: 20, color: Colors.red),
                      onPressed: () {
                        removePostFromLike();
                        setState(() {
                          widget.liked = !widget.liked;
                        });
                      },
                    )
                  : IconButton(
                      icon: FaIcon(FontAwesomeIcons.solidHeart,
                          size: 20, color: Colors.white),
                      onPressed: () {
                        addPostToLikes();
                        setState(() {
                          widget.liked = !widget.liked;
                        });
                      },
                    ),
              Text("${widget.likes}",
                  style: GoogleFonts.montserrat(
                      color: Colors.grey.shade400,
                      fontWeight: FontWeight.w500)),
              SizedBox(width: 10),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.solidComments,
                    size: 20, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CommentsPage(
                            postDocument: widget.postDocument,
                            comments: widget.comments)),
                  );
                },
              ),
              Text("${widget.comments}",
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
                icon: !widget.saved
                    ? FaIcon(FontAwesomeIcons.bookmark,
                        size: 20, color: Colors.white)
                    : FaIcon(FontAwesomeIcons.solidBookmark,
                        size: 20, color: Colors.white),
                onPressed: () {
                  setState(() {
                    widget.saved = !widget.saved;
                    if (widget.saved) {
                      addPostToDB();
                    } else {
                      deletePostFromSavedDB();
                    }
                  });
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> removePostFromLike() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final postsRef = FirebaseFirestore.instance.collection("posts");

    String docToDelete;
    await FirebaseFirestore.instance
        .collection("likes")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) async {
        if (result["postDoc"] == widget.postDocument &&
            result["userWhoLikedUid"] == auth.currentUser.uid) {
          setState(() {
            docToDelete = result.id;
          });
        }
      });
    });

    FirebaseFirestore.instance.collection("likes").doc(docToDelete).delete();

    setState(() {
      widget.likes = widget.likes - 1;
    });
    postsRef.doc(widget.postDocument).update({"likes": widget.likes});
  }

  Future<void> addPostToLikes() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String docToUpdate;
    CollectionReference likesRef =
        FirebaseFirestore.instance.collection("likes");
    final postsRef = FirebaseFirestore.instance.collection("posts");

    await likesRef.add({
      "userWhoLikedUid": auth.currentUser.uid,
      "postDoc": widget.postDocument
    });
    setState(() {
      widget.likes = widget.likes + 1;
    });

    await FirebaseFirestore.instance
        .collection("saved")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) async {
        if (result["postDocument"] == widget.postDocument) {
          setState(() {
            docToUpdate = result.id;
          });
        }
      });
    });
    FirebaseFirestore.instance
        .collection("saved")
        .doc(docToUpdate)
        .update({"likes": widget.likes});
    postsRef.doc(widget.postDocument).update({"likes": widget.likes});
  }

  Future<void> addPostToDB() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final userRef = FirebaseFirestore.instance.collection("saved");
    final postModel = SavedPostModel(
        userWhoSaved: auth.currentUser.uid,
        uid: widget.userUid,
        likes: widget.likes,
        comments: widget.comments,
        descripcion: widget.description,
        imageLink: widget.imageURL,
        usercar: widget.userCar,
        timestamp: DateTime.now(),
        postDocument: widget.postDocument);
    await userRef.doc().set(postModel.toMap(postModel));
  }

  Future<void> deletePostFromSavedDB() async {
    String docToDelete;
    await FirebaseFirestore.instance
        .collection("saved")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) async {
        if (result["postDocument"] == widget.postDocument) {
          setState(() {
            docToDelete = result.id;
          });
          FirebaseFirestore.instance
              .collection("saved")
              .doc(docToDelete)
              .delete();
        }
      });
    });
  }
}
