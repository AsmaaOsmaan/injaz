import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injaz_task/models/requst_model.dart';

class RequestController{
  final Firestore _firestore=Firestore.instance;
  AddRequest({Request request}){
    //_firestore.collection('Requests').add
    DocumentReference documentReference =  Firestore.instance
        .collection("Requests")
        .document();
    documentReference.setData({
      'request':request.request,
      'date':request.date,
      'endTime':request.endTime,
      'id':documentReference.documentID,
      'startTime':request.startTime,
      'Status':'published',
      'title':request.title,
      'latitude':request.latitude,
      'longitude':request.longitude,
      'RequestOwner':request.RequestOwner
    });
  }
  Stream<QuerySnapshot> getRequests(String id){
    //final auth = Provider.of<ProviderUser>(context, listen: false);

    return _firestore.collection('Requests').where('RequestOwner' ,isEqualTo: id).snapshots();

  }
  Stream<QuerySnapshot> getAllRequests(){
    //final auth = Provider.of<ProviderUser>(context, listen: false);

    return _firestore.collection('Requests').snapshots();

  }
  deleteRequest(documentID){
    _firestore.collection('Requests').document(documentID).delete();
  }
  EditequestStatus(data,documentID){
    _firestore.collection('Requests').document(documentID).updateData(data);
  }


}