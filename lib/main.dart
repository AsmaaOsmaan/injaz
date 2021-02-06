import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injaz_task/providers/user_provider.dart';
import 'package:injaz_task/view/home.dart';
import 'package:injaz_task/view/login.dart';
import 'package:injaz_task/view/register.dart';
import 'package:provider/provider.dart';
//import 'package:resresturant/dateBicker.dart';
//import 'package:resresturant/providers/lang_provider.dart';
//import 'package:resresturant/providers/user_provider.dart';
//import 'package:resresturant/screens/add_post_screen.dart';
//import 'package:resresturant/screens/home.dart';
//import 'package:resresturant/screens/login.dart';
//import 'package:resresturant/screens/profile.dart';
//import 'package:resresturant/screens/register.dart';
//import 'package:resresturant/screens/home_silver.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'lang/app_local.dart';
import 'models/user_model.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  // SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
  // sharedPreferences.setString('lang', 'ar');

  await GetStorage.init();

  runApp(MyApp());}

class MyApp extends StatefulWidget {



  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isUserLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return   FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return GetMaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text('loading'),
                ),
              ),
            );
          } else  {
            isUserLoggedIn = snapshot.data.getBool('KkeepMeLoggedIn') ?? false;
            // getUserData(context);
            return MultiProvider(
              providers: [

                ChangeNotifierProvider<ProviderUser>(
                  create: (context) => ProviderUser(),
                ),

              ],
              child: MaterialApp(


                debugShowCheckedModeBanner: false,
                initialRoute: isUserLoggedIn ? Regisster.id : Regisster.id,
                routes: {
                  Regisster.id:(context)=>Regisster(),

                  Home.id:(context)=>Home(),

                },
                title: 'Flutter Demo',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                // home: Regisster(),
              ),
            );
          }
        },
      );

  }
}
