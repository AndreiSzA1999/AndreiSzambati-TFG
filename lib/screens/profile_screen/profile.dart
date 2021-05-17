import 'package:aszcars_tfg_andrei/widgets/post.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool posts;
  bool saved;

  @override
  void initState() {
    super.initState();
    posts = true;
    saved = false;
  }

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

  List<String> images = [
    "https://images.unsplash.com/photo-1494905998402-395d579af36f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80",
    "https://images.unsplash.com/photo-1549288830-f4746d294441?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80",
    "https://images.unsplash.com/photo-1503736334956-4c8f8e92946d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1267&q=80",
    "https://images.unsplash.com/photo-1514867644123-6385d58d3cd4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80",
    "https://images.unsplash.com/photo-1594950164100-dc9142cbfb24?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=700&q=80",
    "https://images.unsplash.com/photo-1441148345475-03a2e82f9719?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80",
    "https://images.unsplash.com/photo-1517994112540-009c47ea476b?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1381&q=80",
    "https://images.unsplash.com/photo-1471479917193-f00955256257?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2048&q=80",
    "https://images.unsplash.com/photo-1556155304-28f97c2c4c62?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80",
    "https://images.unsplash.com/photo-1522037576655-7a93ce0f4d10?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80"
  ];

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              Container(
                height: screenHeight,
                width: screenWidth,
                color: Colors.transparent,
              ),
              Container(
                height: screenHeight * 0.20,
                width: screenWidth,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://images.unsplash.com/photo-1462396881884-de2c07cb95ed?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80"),
                        fit: BoxFit.cover)),
              ),
              Positioned(
                  top: screenHeight * 0.15,
                  child: Container(
                    height: screenHeight * 0.70,
                    width: screenWidth,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30)),
                  )),
              Positioned(
                  left: screenWidth * 0.33,
                  right: screenWidth * 0.33,
                  top: screenHeight * 0.07,
                  child: Container(
                    height: screenWidth * 0.34,
                    width: screenWidth * 0.34,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://images.unsplash.com/photo-1499996860823-5214fcc65f8f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=702&q=80"),
                            fit: BoxFit.cover),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                  )),
              Positioned(
                  top: screenHeight * 0.25,
                  right: 0,
                  left: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Andrei Szambati",
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w500))
                    ],
                  )),
              Positioned(
                  top: screenHeight * 0.3,
                  right: 0,
                  left: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("232",
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400)),
                      SizedBox(width: 10),
                      Text("Followers",
                          style: GoogleFonts.montserrat(
                              color: Colors.grey.shade600,
                              fontSize: 15,
                              fontWeight: FontWeight.w300)),
                      SizedBox(width: 30),
                      Text("342",
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400)),
                      SizedBox(width: 10),
                      Text("Following",
                          style: GoogleFonts.montserrat(
                              color: Colors.grey.shade600,
                              fontSize: 15,
                              fontWeight: FontWeight.w300))
                    ],
                  )),
              Positioned(
                top: screenHeight * 0.35,
                child: Container(
                  width: screenWidth,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "Lorem ipsum dolor sit amet consectetur adipiscing elit, placerat ad sociosqu tortor vulputate nascetur, tincidunt posuere inceptos imperdiet euismod proin",
                      style: GoogleFonts.montserrat(
                          color: Colors.white, fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: screenHeight * 0.46,
                right: 10,
                left: 10,
                child: Container(
                  height: 50,
                  width: screenWidth,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            saved = false;
                            posts = true;
                          });
                        },
                        child: AnimatedContainer(
                            width: screenWidth * 0.47,
                            height: 48,
                            decoration: BoxDecoration(
                                color:
                                    posts ? Colors.white : Colors.grey.shade900,
                                borderRadius: BorderRadius.circular(20)),
                            duration: Duration(milliseconds: 300),
                            child: Center(
                                child: Text("Posts",
                                    style: GoogleFonts.montserrat(
                                        color:
                                            posts ? Colors.black : Colors.white,
                                        fontWeight: FontWeight.w500)))),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            saved = true;
                            posts = false;
                          });
                        },
                        child: AnimatedContainer(
                          width: screenWidth * 0.47,
                          height: 48,
                          duration: Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                              color:
                                  saved ? Colors.white : Colors.grey.shade900,
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                              child: Text("Guardados",
                                  style: GoogleFonts.montserrat(
                                      color:
                                          saved ? Colors.black : Colors.white,
                                      fontWeight: FontWeight.w500))),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                  top: screenHeight * 0.53,
                  child: Container(
                      height: screenHeight * 0.4,
                      width: screenWidth,
                      color: Colors.black,
                      child: posts
                          ? ListView.builder(
                              itemCount: postsList.length,
                              itemBuilder: (context, index) {
                                return postsList[index];
                              })
                          : Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: GridView.builder(
                                  itemCount: images.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 0,
                                          mainAxisSpacing: 0),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image:
                                                    NetworkImage(images[index]),
                                                fit: BoxFit.cover)),
                                      ),
                                    );
                                  }),
                            )))
            ],
          )),
    );
  }
}
