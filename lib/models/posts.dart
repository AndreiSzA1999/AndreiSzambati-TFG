class PostModel {
  String username;
  int likes;
  int comments;
  String descripcion;
  String imageLink;
  String usercar;
  String profileImage;
  DateTime timestamp;

  PostModel(
      {this.username,
      this.likes,
      this.comments,
      this.descripcion,
      this.imageLink,
      this.usercar,
      this.profileImage,
      this.timestamp});

  Map toMap(PostModel post) {
    var data = Map<String, dynamic>();

    data["username"] = post.username;
    data["likes"] = post.likes;
    data["comments"] = post.comments;
    data["descripcion"] = post.descripcion;
    data["imageLink"] = post.imageLink;
    data["usercar"] = post.usercar;
    data["profileImage"] = post.profileImage;
    data["timestamp"] = post.timestamp;
    return data;
  }

  PostModel.fromMap(Map<String, dynamic> mapData) {
    this.username = mapData["username"];
    this.likes = mapData["likes"];
    this.comments = mapData["comments"];
    this.profileImage = mapData["profileImage"];
    this.descripcion = mapData["descripcion"];
    this.imageLink = mapData["imageLink"];
    this.usercar = mapData["usercar"];
  }
}
