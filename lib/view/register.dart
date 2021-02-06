import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:injaz_task/authentcation/dialogBox.dart';
import 'package:injaz_task/authentcation/validator.dart';
import 'package:injaz_task/models/user_model.dart';
import 'package:injaz_task/providers/user_provider.dart';
import 'package:injaz_task/services/auth.dart';
import 'package:injaz_task/ui/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';
import 'login.dart';

class Regisster extends StatefulWidget {
  static String id = 'Regisster';
  @override
  _RegissterState createState() => _RegissterState();
}

class _RegissterState extends State<Regisster> {
  static String id = 'Regisster';
  bool _loading=false;
  final _formKey = GlobalKey<FormState>();
  DialogBox dialog = new DialogBox();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _adressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  final userrefrence = Firestore.instance.collection('User');
  DocumentReference documentReference =  Firestore.instance.collection("User").document();
  final auth = Auth();
  final valid = Validator();
  String _radioValue = 'Company';

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _adressController.dispose();
    _confirmPasswordController.dispose();
    _typeController.dispose();
    _userNameController.dispose();
    _phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryClr,
      body:(!_loading)? Column(
        children: <Widget>[
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('RegisterLabel'.toUpperCase(),
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'to'.toUpperCase(),
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                 'create'.toUpperCase(),
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width,
            // height: 500,
            height: MediaQuery.of(context).size.height * 0.30,
            color: primaryClr,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 100, left: 30, right: 30),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            TextFormField(
                              controller: _userNameController,
                                validator: valid.ValidateUser,
                                decoration:
                                    InputDecoration(hintText:'Name')),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                                validator: valid.ValidateMail,
                                controller: _emailController,
                                decoration:
                                    InputDecoration(hintText: 'Email')),
                           /* SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: valid.Validatephone,
                              controller: _phoneController,
                              keyboardType:  TextInputType.phone,
                              decoration: InputDecoration(hintText: AppLocal.of(context).getTranslated('phone')),
                            ),*/
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(

                                controller: _adressController,
                                validator: valid.ValidateAdrees,
                                decoration:
                                    InputDecoration(hintText:  'Address')),
                           /* SizedBox(
                              height: 30,
                            ),*/
                           /* TextFormField(
                                validator: valid.ValidateType,
                                controller: _typeController,
                                decoration: InputDecoration(hintText: " type")),*/
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              obscureText: true,
                                validator: valid.pwdValidator,
                                controller: _passwordController,
                                decoration:
                                    InputDecoration(hintText: 'passWord')),
                            SizedBox(
                              height: 30,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                new Radio(
                                  activeColor: primaryClr,
                                  value: 'Company',
                                  groupValue: _radioValue,
                                  onChanged: (value){
                                    setState(() {
                                      _radioValue=value;
                                    });
                                  },
                                ),
                                new Text(
                                  'Company',
                                  style: new TextStyle(fontSize: 16.0),
                                ),
                                new Radio(
                                  activeColor: primaryClr,
                                  value: 'Customer',
                                  groupValue: _radioValue,
                                  onChanged: (value){
                                    setState(() {
                                      _radioValue=value;
                                    });
                                  },
                                ),
                                new Text(
                                  'Customer',
                                  style: new TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),


                              ],
                            ),


                            SizedBox(
                              height: 10,
                            ),
                           Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () async {

                                    if (_formKey.currentState.validate()) {

                                      _formKey.currentState.save();
                                      setState(() {
                                        _loading=true;
                                      });
                                      try {
                                  final authResilt=    await auth.SignUp(
                                                _emailController.text.trim(),
                                                _passwordController.text.trim())
                                            .then((authResilt) async {
                                          await userrefrence.document(authResilt.user.uid).setData({
                                            'DocumentID':authResilt.user.uid,
                                            'UserName': _userNameController.text,
                                            'Email': _emailController.text.trim(),
                                            'Phone': _phoneController.text,
                                            'PassWord':
                                                _passwordController.text,
                                            'Type': _radioValue,
                                            'Address':_adressController.text
                                            
                                          }).then((uuser)async {

                                            print(authResilt.user.email);
                                            DocumentSnapshot userDoc =
                                                await Firestore.instance
                                                .collection('User')
                                                .document(authResilt.user.uid)
                                                .get();
                                            saveUserData(authResilt.user.uid);
                                            print(userDoc.data);
                                            Provider.of<ProviderUser>(
                                                context,listen: false)
                                                .userData =
                                                User.fromDoc(userDoc);
                                            _radioValue='femal';
                                           // _typeController.text = '';
                                            _passwordController.text = '';
                                            _emailController.text = '';
                                            _phoneController.text = '';
                                            _emailController.text = '';
                                            _userNameController.text='';
                                            _adressController.text='';
                                          });
                                          print('add');
                                      /*    setState(() {
                                            _loading=false;
                                          });*/
                                        });

                                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                      Home()), (Route<dynamic> route) => false);
                                  setState(() {
                                    _loading=false;
                                  });
                                      } catch (e) {
                                       dialog.information(context, 'sorry', e.message);
                                      //  dialog.information(context, AppLocal.of(context).getTranslated('sorry'), AppLocal.of(context).getTranslated('message'));
                                        print(e.message);
                                        setState(() {
                                          _loading=false;
                                        });
                                      }
                                    }
                                  },
                                /*  child: Text(
                                    AppLocal.of(context).getTranslated('Regiester'),
                                    style: TextStyle(color: Colors.white),
                                  ),*/


                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 60.0),
                                    alignment: Alignment.center,
                                    height: 45.0,
                                    decoration: BoxDecoration(
                                      // color: Theme.of(context).primaryColor,
                                      color: primaryClr,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Text(
                                     'Regiester',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                  ),




                              //    color: Colors.red,
                                  //hoverColor: Colors.blue,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('Already_have_account'),
                                SizedBox(
                                  height: 5,
                                ),
                                GestureDetector(

                                    onTap: (){
                                    //  Provider.of<Language>(context, listen: false).changhlang('en');
                                      Navigator.of(context).push(
                                        MaterialPageRoute<void>(
                                            builder: (_) => Login()),
                                      );
                                    },

                                    child: Text('click me',style: TextStyle(color: primaryClr),)),
                                SizedBox(
                                  height: 50,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )

                    //  Container(child: Text("ttt"))
                  ],
                ),
              ),
            ),
          ),
        ],
      ):Loading(),
    );
  }
  Widget Loading(){
    return  Center(
      child: SpinKitWave(
        color: Colors.white,
        size: 30,
      ),

    );
  }

  void saveUserData(String userId) async{

    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();

    sharedPreferences.setString('userId', userId);

  }



}
