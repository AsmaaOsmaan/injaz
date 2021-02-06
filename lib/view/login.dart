import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:injaz_task/authentcation/dialogBox.dart';
import 'package:injaz_task/authentcation/validator.dart';
import 'package:injaz_task/models/user_model.dart';
import 'package:injaz_task/providers/user_provider.dart';
import 'package:injaz_task/services/auth.dart';
import 'package:injaz_task/ui/theme.dart';
import 'package:injaz_task/view/home.dart';
import 'package:injaz_task/view/register.dart';
import 'package:injaz_task/view/test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  static String id = 'Login';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _loading=false;
  bool KeepMeLogedIn=false;
  final auth = Auth();
  final valid = Validator();
  DialogBox dialog = new DialogBox();
  TextEditingController _EmailController = TextEditingController();
  TextEditingController _PassWordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: primaryClr,
      body: (!_loading)?Column(
        children: <Widget>[
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Login'.toUpperCase(),
                  //     'login'.toUpperCase(),
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'to'.toUpperCase(),
                  //   'to'.toUpperCase(),

                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'your accont'.toUpperCase(),
                  // 'your account'.toUpperCase(),

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
                                controller: _EmailController,
                                validator: valid.ValidateMail,
                                decoration: InputDecoration(
                                    hintText: 'Enter your Email')),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                                obscureText: true,
                                controller: _PassWordController,
                                validator: valid.pwdValidator,
                                decoration: InputDecoration(
                                  hintText:  'Enter your passWord',)),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                Theme(
                                  data:ThemeData(unselectedWidgetColor: primaryClr),
                                  child: Checkbox(
                                    checkColor: Colors.white,
                                    activeColor: primaryClr,

                                    value: KeepMeLogedIn,
                                    onChanged: (value) {
                                      setState(() {
                                        KeepMeLogedIn = value;
                                      });
                                    },
                                  ),
                                ),
                                Text(
                                  'Remember me',
                                  // 'Remember me',
                                  style: TextStyle(color: primaryClr),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                GestureDetector(
                                  // color: Colors.red,




                                  onTap: ()async {

                                    if(KeepMeLogedIn==true){
                                      keepUserLoggedIn();
                                    }

                                    /* final authuser =
                                    Provider.of<ProviderUser>(
                                        context,listen: false);*/
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                      setState(() {
                                        _loading=true;
                                      });
                                      try{
                                        final uuser=   await    auth.SignIn(_EmailController.text.trim(), _PassWordController.text).then((uuser) async{
                                          print("asmaaaaaaaaaaaaaaaaaaaaaaaa");
                                          print(uuser.user.email);
                                          DocumentSnapshot userDoc =
                                          await Firestore.instance
                                              .collection('User')
                                              .document(uuser.user.uid)
                                              .get();
                                          saveUserData(uuser.user.uid);

                                          Provider.of<ProviderUser>(context,listen: false).userData = User.fromDoc(userDoc);
                                          /*  Navigator.of(context).push(
                                     MaterialPageRoute<void>(
                                         builder: (_) => home()),
                                   );*/
                       final auth=Provider.of<ProviderUser>(context,listen: false);
                       //if(auth.userData.Type=='Company'){

                         Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Home()), (Route<dynamic> route) => false);

                     //  }*/
                      /* else{

                         Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => test()), (Route<dynamic> route) => false);
                       }*/
                                     //     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Home()), (Route<dynamic> route) => false);
                                          print("Emaillllllllllllllllllllllllllllllllll");
                                          print( Provider.of<ProviderUser>(context,listen: false).userData.Email);

                                          setState(() {
                                            _loading=false;
                                          });
                                          _EmailController.text='';
                                          _PassWordController.text='';
                                        });
                                      }
                                      catch(e){
                                        dialog.information(context, 'sorry', e.message);
                                        // dialog.information(context, AppLocal.of(context).getTranslated('sorry'), AppLocal.of(context).getTranslated('message'));
                                        print(e.message);
                                        setState(() {
                                          _loading=false;
                                        });
                                      }

                                    }
                                  },
                                  /* child: Text(AppLocal.of(context).getTranslated('Login'),
                                    style: TextStyle(color: Colors.white),),*/
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
                                      'Login',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize:20.0,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                  ),

                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Regisster(),
                                        ),
                                      );
                                    },
                                    child: Text('create account',style: TextStyle(fontSize: 15),)




                                )
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
    return Center(
      child: SpinKitWave(
        color: Colors.white,
        size: 30,
      ),

    );
  }
  void keepUserLoggedIn() async{

    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    sharedPreferences.setBool('KkeepMeLoggedIn', KeepMeLogedIn);


  }
  void saveUserData(String userId) async{

    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();

    sharedPreferences.setString('userId', userId);

  }
}
