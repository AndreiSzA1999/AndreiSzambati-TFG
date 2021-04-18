import 'package:aszcars_tfg_andrei/widgets/post.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PostsPage extends StatefulWidget {
  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  List<Post> postsList = [
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
    ),
    Post(
      userName: "ManoloFdZ",
      userCar: "Hiunday N30 Performance",
      description:
          "Lorem ipsum dolor sit amet consectetur adipiscing elit, placerat ad sociosqu tortor vulputate nascetur, tincidunt posuere inceptos imperdiet euismod proin",
      imageURL:
          "https://images.unsplash.com/photo-1462396881884-de2c07cb95ed?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80",
      likes: 2320,
      comments: 123,
      saved: false,
      profile:
          "https://images.unsplash.com/photo-1604426633861-11b2faead63c?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=700&q=80",
    ),
    Post(
      userName: "AntonioSv10",
      userCar: "Fiat Punto 2000",
      description:
          "Mattis auctor libero neque aenean quam laoreet, felis accumsan tempor praesent pharetra fusce",
      imageURL:
          "https://images.unsplash.com/photo-1517524008697-84bbe3c3fd98?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=700&q=80",
      likes: 24,
      comments: 10,
      saved: false,
      profile:
          "https://images.unsplash.com/photo-1499996860823-5214fcc65f8f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=702&q=80",
    ),
    Post(
      userName: "Jimero20",
      userCar: "Seat Leon FR",
      description:
          " Etiam consequat vestibulum leo nunc aptent facilisi fermentum lacus, litora nascetur mus iaculis pretium",
      imageURL:
          "https://images.unsplash.com/photo-1565793979206-10951493332d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=700&q=80",
      likes: 200,
      comments: 30,
      saved: true,
      profile:
          "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80",
    ),
    Post(
      userName: "Fernando Alonso",
      userCar: "Renault Megane",
      description:
          "Cras per accumsan feugiat aliquet iaculis proin eget fames consequat semper commodo",
      imageURL:
          "https://images.unsplash.com/photo-1471479917193-f00955256257?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2048&q=80",
      likes: 321,
      comments: 4,
      saved: false,
      profile:
          "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80",
    ),
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
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              width: screenWidth,
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {}),
                  Text(
                    "ASZCARS",
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.notifications,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {}),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics()),
                  itemCount: postsList.length,
                  itemBuilder: (context, index) {
                    return postsList[index];
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
