class SavedPostModel {
  int likes;
  int comments;
  String descripcion;
  String imageLink;
  String usercar;
  DateTime timestamp;
  String uid;
  String document;
  String userWhoSaved;
  String postDocument;

  SavedPostModel(
      {this.likes,
      this.comments,
      this.descripcion,
      this.imageLink,
      this.usercar,
      this.timestamp,
      this.uid,
      this.document,
      this.userWhoSaved,
      this.postDocument});

  Map toMap(SavedPostModel post) {
    var data = Map<String, dynamic>();
    data["uid"] = post.uid;
    data["likes"] = post.likes;
    data["comments"] = post.comments;
    data["descripcion"] = post.descripcion;
    data["imageLink"] = post.imageLink;
    data["usercar"] = post.usercar;
    data["userwhosaved"] = post.userWhoSaved;
    data["postDocument"] = post.postDocument;
    data["timestamp"] = post.timestamp;
    return data;
  }

  SavedPostModel.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData["uid"];
    this.likes = mapData["likes"];
    this.comments = mapData["comments"];
    this.descripcion = mapData["descripcion"];
    this.imageLink = mapData["imageLink"];
    this.usercar = mapData["usercar"];
    this.userWhoSaved = mapData["userwhosaved"];
    this.postDocument = mapData["postDocument"];
  }
}
