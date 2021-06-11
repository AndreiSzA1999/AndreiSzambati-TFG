import 'package:aszcars_tfg_andrei/widgets/post.dart';
import 'package:flutter/material.dart';

class PostDetailedPage extends StatelessWidget {
  PostDetailedPage(this.post);
  final Post post;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("POST"),
            centerTitle: true,
            backgroundColor: Colors.black,
          ),
          backgroundColor: Color(0xff262a34),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: screenWidth * 0.02,
                  ),
                  post,
                ],
              ),
            ],
          )),
    );
  }
}
