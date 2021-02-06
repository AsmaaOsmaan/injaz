class Validator{

 /*String   ValidateMail(String value){

   if (value.isEmpty) return 'Email is requierd';
   else{
     return null;
   }

  }*/
 String   Validatephone(String value){

   if (value.isEmpty) return 'phone is requierd';
   if (value.length < 11||value.length>11) {
     return 'please enter valid phone number';
   } else {
     return null;
   }

 }
 String pwdValidator(String value) {
   if (value.isEmpty) return 'Password is requierd';
   if (value.length < 6) {
     return 'Password must be longer than 6 characters';
   } else {
     return null;
   }
 }
 String   ValidateAdrees(String value){

   if (value.isEmpty) return 'Adrees is requierd';
   else {
     return null;
   }

 }
 String   ValidateType(String value){

   if (value.isEmpty) return 'type is requierd';
   else {
     return null;
   }

 }
 String   ValidateUser(String value){

   if (value.isEmpty) return 'UserName is requierd';
   if (value.length < 3) {
     return 'userName  must be longer than 3 characters';
   }
   else {
     return null;
   }

 }
 String ValidateMail(String value) {
   Pattern pattern =
       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
   RegExp regex = new RegExp(pattern);
   if(value.isEmpty)
     return 'Email is requierd';
   if (!regex.hasMatch(value.trim()))
     return 'Enter Valid Email';
   else {
     return null;
   }

   ///not work///////////

/////////////////////////////////////////




 }

}