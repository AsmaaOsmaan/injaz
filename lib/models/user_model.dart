import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  String DocumentID,UserName,Email,Phone,PassWord,Type,photoUrl;

  User({this.DocumentID, this.UserName, this.Email, this.Phone, this.PassWord,
    this.Type,this.photoUrl});

  factory User.fromDoc(DocumentSnapshot doc) {
    return User(
      DocumentID: doc['DocumentID'],
      UserName: doc['UserName'],
      Email: doc['Email'],
      Phone: doc['Phone'],
      PassWord: doc['PassWord'],
      Type:doc['Type'],

      photoUrl:doc['photoUrl'],
    );
  }

}