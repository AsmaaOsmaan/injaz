import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
//import 'package:get/get_navigation/src/snackbar/snack.dart';
import 'package:injaz_task/controller/equest_controller.dart';
import 'package:injaz_task/models/requst_model.dart';
import 'package:injaz_task/providers/user_provider.dart';
import 'package:injaz_task/ui/theme.dart';
import 'package:injaz_task/ui/widgets/button.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'input_field.dart';

class AddRequest extends StatefulWidget {
  @override
  _AddRequestState createState() => _AddRequestState();
}

class _AddRequestState extends State<AddRequest> {
final RequestController requestController=RequestController();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
   //Position position;
   double latitude;
double longitude;
  String _startTime = "8:30 AM";
  String _endTime = "9:30 AM";
  int _selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    print("add Task date: " + DateFormat.yMd().format(_selectedDate));
    return Scaffold(
      backgroundColor://Colors.white,
      context.theme.backgroundColor,
      appBar: _appBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Request",
                style: headingTextStyle,
              ),
              SizedBox(
                height: 8,
              ),
              InputField(
                title: "Title",
                hint: "Enter title here.",
                controller: _titleController,
              ),
              InputField(
                  title: "Request",
                  hint: "Enter Request here.",
                  controller: _noteController),
              InputField(
                title: "Date",
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  icon: (Icon(
                    FlutterIcons.calendar_ant,
                    color: Colors.grey,
                  )),
                  onPressed: () {
                    //_showDatePicker(context);
                    _getDateFromUser();
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      title: "Start Time",
                      hint: _startTime,
                      widget: IconButton(
                        icon: (Icon(
                          FlutterIcons.clock_faw5,
                          color: Colors.grey,
                        )),
                        onPressed: () {
                          _getTimeFromUser(isStartTime: true);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: InputField(
                      title: "End Time",
                      hint: _endTime,
                      widget: IconButton(
                        icon: (Icon(
                          FlutterIcons.clock_faw5,
                          color: Colors.grey,
                        )),
                        onPressed: () {
                          _getTimeFromUser(isStartTime: false);
                        },
                      ),
                    ),
                  )
                ],
              ),


              SizedBox(
                height: 18.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 // _colorChips(),
                  GestureDetector(
                    onTap: ()async{
                      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                      print(position.latitude);
                      print(position.longitude);
                      latitude=position.latitude;
                      longitude=position.longitude;
                      showFkushbaeforLocation(context);

                    },
                    child: Expanded(
                      child: Row(
                        children: [
                          Text('click here to dedect location',style: titleTextStle,),
                          Icon(Icons.add_location_alt_rounded,size: 30,)
                        ],
                      ),
                    ),
                  ),
                /*  GestureDetector(
                      onTap: ()async{
                        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                       print(position.latitude);
                        print(position.longitude);
                        latitude=position.latitude;
                        longitude=position.longitude;
                        showFkushbaeforLocation(context);

                      },
                      child: Icon(Icons.location_city,size: 20,),),*/
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Center(
                      child: MyButton(
                        label: "Create Request",
                        onTap: () {
                          _validateInputs(context);




                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }



  _getTimeFromUser({@required bool isStartTime}) async {
    var _pickedTime = await _showTimePicker();
    print(_pickedTime.format(context));
    String _formatedTime = _pickedTime.format(context);
    print(_formatedTime);
    if (_pickedTime == null)
      print("time canceld");
    else if (isStartTime)
      setState(() {
        _startTime = _formatedTime;
      });
    else if (!isStartTime) {
      setState(() {
        _endTime = _formatedTime;
      });
      //_compareTime();
    }
  }

  _showTimePicker() async {
    return showTimePicker(
      initialTime: TimeOfDay(hour: 8, minute: 30),
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
    );
  }

  _getDateFromUser() async {
    final DateTime _pickedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (_pickedDate != null) {
      setState(() {
        _selectedDate = _pickedDate;
      });
    }
  }
  _validateInputs(BuildContext context) {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addRequestToDB();
    //  Get.back();
      Navigator.pop(context);
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
    /*  Get.snackbar(
        "Required",
        "All fields are required.",
        snackPosition: SnackPosition.BOTTOM,
      );*/

      Opacity(
       // duration:Duration(seconds: 3) ,
        opacity: 0.5,
        child: Flushbar(
        //  progressIndicatorBackgroundColor: Colors.grey[800],
         // progressIndicatorColor: Colors.grey[800],
          margin: EdgeInsets.all(8),
          borderRadius: 10,
          //showProgressIndicator: true,

          backgroundColor: Colors.white.withOpacity(0.3),
         // title:  "Required",
          titleText: Text(
            "Required",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.black, fontFamily: "ShadowsIntoLightTwo"),
          ),
          messageText: Text(
            "All fields are required.",
            style: TextStyle(fontSize: 18.0, color: Colors.black, fontFamily: "ShadowsIntoLightTwo"),
          ),
          //flushbarStyle: color,
        //  message:  "All fields are required.",
          duration:  Duration(seconds: 3),
        )..show(context),
      );


    } else {
      print("############ SOMETHING BAD HAPPENED #################");
    }
  }

  _addRequestToDB() async {
    final auth = Provider.of<ProviderUser>(context, listen: false);

    await requestController.AddRequest(
      request: Request(

        request: _noteController.text,
        title: _titleController.text,
        date: DateFormat.yMd().format(_selectedDate),
        startTime: _startTime,
        endTime: _endTime,
      latitude: latitude,
      longitude: longitude,
      //  id: request.
      RequestOwner: auth.userData.DocumentID

      ),
    );
  }
_appBar() {
  return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back_ios, size: 30, color: primaryClr),
      ),
      actions: [
        CircleAvatar(
          radius: 16,
          backgroundImage: AssetImage("images/girl.jpg"),
        ),
        SizedBox(
          width: 20,
        ),
      ]);
}
showFkushbaeforLocation(BuildContext context){
 return Flushbar(
   flushbarPosition:FlushbarPosition.TOP,
    //  progressIndicatorBackgroundColor: Colors.grey[800],
    // progressIndicatorColor: Colors.grey[800],
    margin: EdgeInsets.all(8),
    borderRadius: 10,
    //showProgressIndicator: true,

    backgroundColor: Colors.white.withOpacity(0.3),
    // title:  "Required",
   /* titleText: Text(
      "Required",
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.black, fontFamily: "ShadowsIntoLightTwo"),
    ),*/
    messageText: Text(
      "your location detected.",
      style: TextStyle(fontSize: 18.0, color: Colors.black, fontFamily: "ShadowsIntoLightTwo"),
    ),
    //flushbarStyle: color,
    //  message:  "All fields are required.",
    duration:  Duration(seconds: 3),
  )..show(context);
}
}
