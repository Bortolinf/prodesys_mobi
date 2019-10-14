import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prodesys_mobi/src/domain/singleton.dart';


enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated, NewUser, Registering, Unregistred }

class UserRepository with ChangeNotifier {
  FirebaseAuth _auth;
  FirebaseUser _user;
  Status _status = Status.Uninitialized;
  Map<String, dynamic> userData = Map();


  UserRepository.instance()
      : _auth = FirebaseAuth.instance
       {
    //_auth = FirebaseAuth.instance;
    _auth.onAuthStateChanged.listen(_onAuthStateChanged);
  }

  Status get status => _status;
  FirebaseUser get user => _user;

  Future<bool> signIn(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email.toString().trim(), password: password);
    //  await loadCurrentUser();
     return true;
    } catch (e) {
      print("erro ao logar: $e");
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  // criei para utilizar quando for criar novo usuario
  Future newUser() async {
   // _auth.signOut();
    _status = Status.NewUser;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }


 void recoverPass(String email){
    _auth.sendPasswordResetEmail(email: email);
  }

 // criei para registrar um novo usuario
 Future<bool> signUp(Map<String, dynamic> userData, String password) async {
    try {
      _status = Status.Registering;
      notifyListeners();
      await _auth.createUserWithEmailAndPassword(
        email: userData["email"].toString().trim(), password: password).then((authResult) async{
        _user = authResult.user;
           await _saveUserData(userData);
        }
        );
      return true;
    } catch (e) {
      _status = Status.Unregistred;
      notifyListeners();
      return false;
    }
  }


  Future<Null> _saveUserData(Map<String, dynamic> userdata) async{
    this.userData = userdata;
    await Firestore.instance.collection("users").document(_user.uid).setData(userData);
  }
 




  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      appData.uid = _user.uid;
      await loadCurrentUser();
      _status = Status.Authenticated;
    }
    notifyListeners();
  }


  Future<Null> loadCurrentUser() async {
    if (_user == null)
     _user = await _auth.currentUser();
    if (_user != null) {
        DocumentSnapshot docUser = 
        await Firestore.instance.collection("users").document(_user.uid).get();
        userData = docUser.data;
        appData.cnpjEmp = userData["cnpjEmp"]; 
        appData.wtlUsrName = userData["name"]; 
        appData.wtlUser = _user;
    }
    notifyListeners();
  }



} // fim de tudo