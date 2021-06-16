import 'package:aszcars_tfg_andrei/constants/color_palette.dart';
import 'package:aszcars_tfg_andrei/models/user.dart';
import 'package:aszcars_tfg_andrei/services/authentication_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nanoid/nanoid.dart';
import 'package:provider/provider.dart';

class CommentsPage extends StatefulWidget {
  final String postDocument;
  int comments;

  CommentsPage({@required this.postDocument, @required this.comments});

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  UserModel usuario;
  String estado;
  @override
  initState() {
    super.initState();
    FirebaseAuth auth = FirebaseAuth.instance;
    getCurrentUser(auth.currentUser.uid);
    estado = "sin";
    getComments();
  }

  List<Comentario> comentarios = [];

  TextEditingController comentario = TextEditingController();

  getComments() async {
    await FirebaseFirestore.instance
        .collection("comments")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) async {
        if (result["postdoc"] == widget.postDocument) {
          UserModel usuarioPost = await getPostUser(result["useruid"]);

          setState(() {
            comentarios.add(Comentario(
                canDelete: result["useruid"] == usuario.uid,
                nombreUsuario: usuarioPost.username,
                fotoPerfil: usuarioPost.profileimage,
                id: result["id"],
                comentario: result["comentario"],
                comments: widget.comments));
          });
        }
      });
      print(estado);
      setState(() {
        estado = "listo";
      });
      print(estado);
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            children: [
              Container(
                height: 60,
                width: screenWidth,
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                    Text(
                      "COMENTARIOS",
                      style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: estado == "listo"
                      ? comentarios.length != 0
                          ? ListView.builder(
                              itemCount: comentarios.length,
                              itemBuilder: (context, index) {
                                return comentarioElement(
                                    canDelete: comentarios[index].canDelete,
                                    comentario: comentarios[index].comentario,
                                    fotoPerfil: comentarios[index].fotoPerfil,
                                    comments: comentarios[index].comments,
                                    nombreUsuario:
                                        comentarios[index].nombreUsuario,
                                    id: comentarios[index].id);
                              })
                          : Center(
                              child: Text(
                                "No hay comentarios",
                                style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20),
                              ),
                            )
                      : Center(
                          child: CircularProgressIndicator(),
                        )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                child: Container(
                  height: 60,
                  width: screenWidth,
                  decoration: BoxDecoration(
                      color: ColorsPalette().colorSecundario,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: comentario,
                          textInputAction: TextInputAction.done,
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 18),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Escribe un comentario",
                            hintStyle: GoogleFonts.montserrat(
                                color: ColorsPalette().colorTextoSecundario,
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          ),
                        ),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 25,
                          ),
                          onPressed: () async {
                            addComentToDB();
                          }),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }

  Future<void> addComentToDB() async {
    final identificador = nanoid(10);
    final commentsRef = FirebaseFirestore.instance.collection("comments");
    if (comentario.text.length != 0) {
      await commentsRef.add({
        "useruid": usuario.uid,
        "postdoc": widget.postDocument,
        "comentario": comentario.text,
        "id": identificador,
      });
    }
    final postsRef = FirebaseFirestore.instance.collection("posts");
    postsRef.doc(widget.postDocument).update({"comments": widget.comments + 1});
    setState(() {
      widget.comments = widget.comments + 1;
      comentarios.add(
        Comentario(
          canDelete: true,
          comentario: comentario.text,
          fotoPerfil: usuario.profileimage,
          comments: widget.comments,
          postDoc: widget.postDocument,
          nombreUsuario: usuario.username,
          id: identificador,
        ),
      );
      comentario.clear();
    });
  }

  Column comentarioElement(
      {String comentario,
      String fotoPerfil,
      String nombreUsuario,
      bool canDelete,
      String postDoc,
      int comments,
      String id}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          constraints: BoxConstraints(minHeight: 70),
          child: ListTile(
            tileColor: Colors.black,
            leading: CircleAvatar(
              backgroundImage: fotoPerfil != null || fotoPerfil != ""
                  ? NetworkImage(fotoPerfil)
                  : AssetImage("assets/images/noimage.jpg"),
              radius: 25,
            ),
            title: Text(
              nombreUsuario,
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 17),
            ),
            trailing: canDelete
                ? GestureDetector(
                    onTap: () async {
                      deleteComment(id);
                    },
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  )
                : Icon(Icons.ac_unit, color: Colors.transparent),
            subtitle: Text(
              comentario,
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 14),
            ),
          ),
        ),
        Divider(
          color: ColorsPalette().colorSecundario,
        )
      ],
    );
  }

  getCurrentUser(String uid) async {
    UserModel currentUser =
        await context.read<AuthenticationService>().getUserFromDB(uid: uid);
    setState(() {
      usuario = currentUser;
    });
  }

  getPostUser(String uid) async {
    UserModel currentUser =
        await context.read<AuthenticationService>().getUserFromDB(uid: uid);

    return currentUser;
  }

  Future<void> deleteComment(String postId) async {
    String docToDelete;
    final postsRef = FirebaseFirestore.instance.collection("posts");
    await FirebaseFirestore.instance
        .collection("comments")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) async {
        if (result["id"] == postId) {
          postsRef
              .doc(widget.postDocument)
              .update({"comments": widget.comments - 1});
          setState(() {
            comentarios.removeWhere((comentario) => comentario.id == postId);
            docToDelete = result.id;
            widget.comments = widget.comments - 1;
          });
        }
      });
    });
    FirebaseFirestore.instance.collection("comments").doc(docToDelete).delete();
  }
}

class Comentario {
  String comentario;
  String fotoPerfil;
  String nombreUsuario;
  bool canDelete;
  String postDoc;
  int comments;
  String id;

  Comentario(
      {this.comentario,
      this.fotoPerfil,
      this.nombreUsuario,
      this.canDelete,
      this.comments,
      this.postDoc,
      this.id});
}
