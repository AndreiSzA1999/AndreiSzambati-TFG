class UserModel {
  String email;
  String uid;
  String username;
  DateTime timestamp;
  int followers;
  int following;
  String descripcion;
  String backimage;
  String profileimage;

  UserModel(
      {this.email,
      this.uid,
      this.username,
      this.timestamp,
      this.followers,
      this.following,
      this.descripcion,
      this.backimage,
      this.profileimage});

  Map toMap(UserModel user) {
    var data = Map<String, dynamic>();

    data["uid"] = user.uid;
    data["username"] = user.username;
    data["email"] = user.email;
    data["timestamp"] = user.timestamp;
    data["followers"] = user.followers;
    data["following"] = user.following;
    data["descripcion"] = user.descripcion;
    data["backimage"] = user.profileimage;
    data["profileimage"] = user.profileimage;
    return data;
  }

  UserModel.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData["uid"];
    this.username = mapData["username"];
    this.email = mapData["email"];
    //this.timestamp = mapData["timestamp"];
    this.followers = mapData["followers"];
    this.following = mapData["following"];
    this.descripcion = mapData["descripcion"];
    this.backimage = mapData["backimage"];
    this.profileimage = mapData["profileimage"];
  }
}
