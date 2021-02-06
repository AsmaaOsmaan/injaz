import 'package:cloud_firestore/cloud_firestore.dart';

class Store{
  final Firestore _firestore=Firestore.instance;
  LoadProfileData(String id){
    return _firestore.collection('User').document(id).snapshots();

  }







 /* Future<DocumentSnapshot>getData(String id) async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection("LiveGames")
        .where("DocumentID", isEqualTo: id)
        .getDocuments();
    return qn;
  }*/













}