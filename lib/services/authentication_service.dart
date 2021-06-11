import 'package:aszcars_tfg_andrei/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  UserModel userModel = UserModel();
  final userRef = FirebaseFirestore.instance.collection("users");

  AuthenticationService(this._firebaseAuth);

  // managing the user state via stream.
  // stream provides an immediate event of
  // the user's current authentication state,
  // and then provides subsequent events whenever
  // the authentication state changes.
  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  //1
  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      return "Signed In";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "No se ha encontrado usuario.";
      } else if (e.code == 'wrong-password') {
        return "Contraseña incorrecta.";
      } else {
        return "Ups! Algo ha ido mal.";
      }
    }
  }

  //2
  // ignore: missing_return
  Future<String> signUp({String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Signed Up";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return "La contraseña es demasiado debil.";
      } else if (e.code == 'email-already-in-use') {
        return "Ya existe una cuenta con este email.";
      } else {
        return "Ups! Algo ha fallado.";
      }
    } catch (e) {
      print(e);
    }
  }

  //3
  Future<void> addUserToDB(
      {String uid, String username, String email, DateTime timestamp}) async {
    userModel = UserModel(
        uid: uid,
        username: username,
        email: email,
        timestamp: timestamp,
        followers: 0,
        following: 0,
        descripcion: "Añade una descripción",
        backimage: "",
        profileimage: "");

    await userRef.doc(uid).set(userModel.toMap(userModel));
  }

  //4
  Future<UserModel> getUserFromDB({String uid}) async {
    final DocumentSnapshot doc = await userRef.doc(uid).get();
    return UserModel.fromMap(doc.data());
  }

  //5
  Future<String> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return "Singed out";
    } on FirebaseAuthException catch (e) {
      return e.toString();
    }
  }
}
