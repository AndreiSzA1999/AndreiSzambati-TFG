import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  int likes;
  int comments;
  String descripcion;
  String imageLink;
  String usercar;
  Timestamp timestamp;
  String uid;
  String document;

  PostModel(
      {this.likes,
      this.comments,
      this.descripcion,
      this.imageLink,
      this.usercar,
      this.timestamp,
      this.uid,
      this.document});

  Map toMap(PostModel post) {
    var data = Map<String, dynamic>();
    data["uid"] = post.uid;
    data["likes"] = post.likes;
    data["comments"] = post.comments;
    data["descripcion"] = post.descripcion;
    data["imageLink"] = post.imageLink;
    data["usercar"] = post.usercar;

    data["timestamp"] = post.timestamp;
    return data;
  }

  PostModel.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData["uid"];
    this.likes = mapData["likes"];
    this.comments = mapData["comments"];
    this.descripcion = mapData["descripcion"];
    this.imageLink = mapData["imageLink"];
    this.usercar = mapData["usercar"];
  }
}
