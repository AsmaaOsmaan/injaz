class Request{
 String id;
  String title;
  String Status;
  String request;
 String date;
 String startTime;
 String endTime;
 double latitude;
 double longitude;
 String RequestOwner;
 Request({
   this.id,
   this.title,
   this.Status,
   this.request,
   this.date,
   this.startTime,
   this.endTime,
   this.longitude,
   this.latitude,
   this.RequestOwner
 });

 Request.fromJson(Map<String, dynamic> json) {
   id = json['id'];
   title = json['title'];
   date = json['date'];
   startTime = json['startTime'];
   endTime = json['endTime'];
   latitude = json['latitude'];
   longitude = json['longitude'];
   RequestOwner=json['RequestOwner'];
 }

 Map<String, dynamic> toJson() {
   final Map<String, dynamic> data = new Map<String, dynamic>();
   data['id'] = this.id;
   data['title'] = this.title;
   data['date'] = this.date;
   data['startTime'] = this.startTime;
   data['endTime'] = this.endTime;
   data['longitude'] = this.longitude;
   data['latitude'] = this.latitude;
   data['RequestOwner'] = this.RequestOwner;
   return data;
 }

}