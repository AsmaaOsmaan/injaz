


import 'package:firebase_auth/firebase_auth.dart';

class Auth{
  final auth=FirebaseAuth.instance;
  Future<AuthResult> SignUp(String Email,String Password)async{
     final authResult =await auth.createUserWithEmailAndPassword(email: Email, password: Password);
return authResult;

  }
  Future<AuthResult> SignIn(String Email,String Password)async{
    final authResult =await auth.signInWithEmailAndPassword(email: Email, password: Password);
    return authResult;

  }
  Future<void>SignOut()async{
    await auth.signOut();
  }
}