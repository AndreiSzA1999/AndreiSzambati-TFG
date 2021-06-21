import 'package:aszcars_tfg_andrei/models/posts.dart';
import 'package:aszcars_tfg_andrei/models/user.dart';
import 'package:aszcars_tfg_andrei/services/authentication_service.dart';
import 'package:aszcars_tfg_andrei/widgets/mensaje.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MessagesPage extends StatefulWidget {
  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  List<Mensaje> mensajes = [];
  String estado;
  FirebaseAuth auth;
  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;
    estado = "buscando";
    getMessages();
  }

  void getMessages() {
    FirebaseFirestore.instance
        .collection("messages")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) async {
        if (result["to"] == auth.currentUser.uid) {
          UserModel usuario = await getCurrentUser(result["from"]);
          PostModel post = await getPost(result["postid"]);
          UserModel userPost = await getCurrentUser(post.uid);
          setState(() {
            mensajes.add(Mensaje(
              nombreRemitente: usuario.username,
              nombreCreadorPost: userPost.username,
              cochePost: post.usercar,
              descripcion: post.descripcion,
              comments: post.comments,
              imgUrl: post.imageLink,
              likes: post.likes,
              fotoPerfil: userPost.profileimage,
              uidUnico: result["unicuid"],
            ));
          });
        }
      });

      setState(() {
        print("Terminado");
        estado = "terminado";
      });
    });
  }

  Future<UserModel> getCurrentUser(String uid) async {
    UserModel currentUser =
        await context.read<AuthenticationService>().getUserFromDB(uid: uid);
    return currentUser;
  }

  Future<PostModel> getPost(String uid) async {
    final postsRef = FirebaseFirestore.instance.collection("posts");
    final DocumentSnapshot doc = await postsRef.doc(uid).get();
    PostModel currentPost = PostModel.fromMap(doc.data());
    return currentPost;
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
                  IconButton(
                      icon: Icon(
                        Ionicons.ios_arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  Text(
                    "MENSAJES",
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                  SizedBox(
                    width: 30.0,
                  )
                ],
              ),
            ),
            estado == "terminado"
                ? Expanded(
                    child: mensajes.length != 0
                        ? ListView.builder(
                            physics: AlwaysScrollableScrollPhysics(
                                parent: BouncingScrollPhysics()),
                            itemCount: mensajes.length,
                            itemBuilder: (context, index) {
                              return Dismissible(
                                key: UniqueKey(),
                                onDismissed: (direction) async {
                                  String postToRemove;
                                  await FirebaseFirestore.instance
                                      .collection("messages")
                                      .get()
                                      .then((querySnapshot) {
                                    querySnapshot.docs.forEach((result) async {
                                      if (result["unicuid"] ==
                                          mensajes[index].uidUnico) {
                                        setState(() {
                                          print("post encontrado");
                                          postToRemove = result.id;
                                        });
                                      }
                                    });
                                  });
                                  print(postToRemove);
                                  print("Eliminando post");
                                  FirebaseFirestore.instance
                                      .collection("messages")
                                      .doc(postToRemove)
                                      .delete();
                                  setState(() {
                                    mensajes.removeAt(index);
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text("Mensaje Eliminado")));
                                },
                                child: mensajes[index],
                              );
                            })
                        : Center(
                            child: Text(
                              "No hay mensajes",
                              style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 15),
                            ),
                          ),
                  )
                : Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
