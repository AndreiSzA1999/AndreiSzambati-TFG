import 'package:aszcars_tfg_andrei/widgets/mensaje.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class MessagesPage extends StatefulWidget {
  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  List<Mensaje> mensajes = [
    Mensaje(),
    Mensaje(),
    Mensaje(),
    Mensaje(),
    Mensaje(),
  ];

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
            Expanded(
              child: mensajes.length != 0
                  ? ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics()),
                      itemCount: mensajes.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: UniqueKey(),
                          onDismissed: (direction) {
                            setState(() {
                              mensajes.removeAt(index);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Mensaje Eliminado")));
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
            ),
          ],
        ),
      ),
    );
  }
}
