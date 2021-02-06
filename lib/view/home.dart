import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:injaz_task/controller/equest_controller.dart';
import 'package:injaz_task/models/requst_model.dart';
import 'package:injaz_task/providers/user_provider.dart';
import 'package:injaz_task/ui/theme.dart';
import 'package:injaz_task/ui/widgets/button.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:injaz_task/view/task_tile.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

//import 'package:date_format/date_format.dart';

import 'add_request.dart';
import 'location_screen.dart';

class Home extends StatefulWidget {
  static String id = 'Login';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime _selectedDate = DateTime.parse(DateTime.now().toString());
  RequestController requestController = RequestController();

  int num = 0;
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<ProviderUser>(context, listen: false);

    return Scaffold(
        appBar: _appBar(),
        body: (auth.userData.Type == 'Customer')
            ? Column(
                children: [
                  _addTaskBar(),
                  _dateBar(),
                  SizedBox(
                    height: 12,
                  ),
                  _showTasks(),
                ],
              )
            : Column(
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  _showTasks(),
                ],
              ));
  }

  _appBar() {
    final auth = Provider.of<ProviderUser>(context, listen: false);

    return AppBar(

      centerTitle: true,
      title: (auth.userData.Type=='Company')?Text('Requests',style: TextStyle(color: Colors.black),):Container(),
        elevation: 0, backgroundColor: Colors.white12, actions: [
      CircleAvatar(
        radius: 16,
        backgroundImage: AssetImage("images/girl.jpg"),
      ),
      SizedBox(
        width: 20,
      ),
    ]);
  }


  _addTaskBar() {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: subHeadingTextStyle,
              ),
              Text(
                "Today",
                style: headingTextStyle,
              ),
            ],
          ),
          MyButton(
            label: "+ Add Request",
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddRequest()),
              );
              //  Get.to(AddRequest());
              // _taskController.getTasks();
            },
          ),
        ],
      ),
    );
  }

  _showTasks() {
    final auth = Provider.of<ProviderUser>(context, listen: false);

    return Expanded(
        child: StreamBuilder<QuerySnapshot>(
            stream: (auth.userData.Type=='Company')?requestController.getAllRequests():requestController.getRequests(auth.userData.DocumentID),
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: Text('Please wait its loading...'));
              } else {
                if (snapshot.hasError)
                  return Center(child: Text('Error: ${snapshot.error}'));
                if (!snapshot.hasData) {
                  return Center(child: Text('np data'));
                } else {
                  num = snapshot.data.documents.length;
                  print(num);
                  List<Request> requests = [];
                  for (var doc in snapshot.data.documents) {
                    var data = doc.data;
                    requests.add(Request(

                        RequestOwner: auth.userData.DocumentID,
                        id: doc.documentID,
                        title: data['title'],
                        date: data['date'],
                        endTime: data['endTime'],
                        request: data['request'],
                        startTime: data['startTime'],
                        latitude: data['latitude'],
                        longitude: data['longitude'],
                        Status: data['Status']));
                  }
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: num,
                      itemBuilder: (context, index) {
                       if (requests[index].date == DateFormat.yMd().format(_selectedDate)) {
                          return //Center(child: Container (child: Text("dooone"),),);
                              AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            child: SlideAnimation(
                              horizontalOffset: 50.0,
                              child: FadeInAnimation(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          //  showBottomSheet(context, task);
                                          print(
                                              'latitude${requests[index].latitude}');
                                          print(
                                              'latitude${requests[index].Status}');
                                        /*  Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Locaction(requests[index])),
                                          );*/


                                          showBottomSheet(context,requests[index]);
                                        },
                                        child: TaskTile(requests[index])),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      });
                }
              }
            }));

    // Obx(()
    /*{
        if (_taskController.taskList.isEmpty) {
          return _noTaskMsg();
        } else
          return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: _taskController.taskList.length,
              itemBuilder: (context, index) {
                Task task = _taskController.taskList[index];
                if (task.repeat == 'Daily') {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      horizontalOffset: 50.0,
                      child: FadeInAnimation(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  showBottomSheet(context, task);
                                },
                                child: TaskTile(task)),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                if (task.date == DateFormat.yMd().format(_selectedDate)) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      horizontalOffset: 50.0,
                      child: FadeInAnimation(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  showBottomSheet(context, task);
                                },
                                child: TaskTile(task)),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              });
      }),
    );*/
  }

  _dateBar() {
    return Container(
      padding: EdgeInsets.only(bottom: 4),
      child: DatePicker(
        DateTime.now(),
        //height: 100.0,
        initialSelectedDate: DateTime.now(),
        selectionColor: context.theme.backgroundColor,
        selectedTextColor: primaryClr,
        dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 10.0,
            color: Colors.grey,
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 10.0,
            color: Colors.grey,
          ),
        ),
        // deactivatedColor: Colors.white,

        onDateChange: (date) {
          // New date selected

          setState(
            () {
              _selectedDate = date;
            },
          );
        },
      ),
    );
  }
  showBottomSheet(BuildContext context, Request request) {
    final auth = Provider.of<ProviderUser>(context, listen: false);

        showModalBottomSheet(
            context: context,
            builder: (BuildContext bc){return Container(
              padding: EdgeInsets.only(top: 4),
              // height: task.isCompleted == 1 ? SizeConfig.screenHeight * 0.24 : SizeConfig.screenHeight * 0.32,
              width: MediaQuery.of(context).size.width,
              color:  Colors.white,
              child: Column(children: [
                Container(
                  height: 6,
                  width: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:  Colors.grey[600] ),
                ),
               //Spacer(),
              SizedBox(height: 50,),
                ( request.Status == 'published'&&auth.userData.Type=='Customer')?  _buildBottomSheetButton(


                    label: "Delete Request",
                    onTap: () {
                      // _taskController.markTaskCompleted(task.id);
                      requestController.deleteRequest(request.id);
                      //  Get.back();
                      Navigator.pop(context);
                    },
                    clr: primaryClr)
                    :


                (  request.Status == 'Under Process'||request.Status == 'Completed'&&auth.userData.Type=='Company')?_buildBottomSheetButton(
                    label: "Request Completed",
                    onTap: () {
                      // _taskController.markTaskCompleted(task.id);
                      requestController.EditequestStatus(({
                        'Status':'Completed'
                      }), request.id);
                      setState(() {

                      });
                      //  Get.back();
                      Navigator.pop(context);
                    },
                    clr: primaryClr):


                _buildBottomSheetButton(
                    label: "request underprocees",
                    onTap: () {
                      // _taskController.markTaskCompleted(task.id);
                      requestController.EditequestStatus(({
                        'Status':'Under Process'
                      }), request.id);
                      setState(() {

                      });
                    //  Get.back();
                      Navigator.pop(context);
                    },
                    clr: primaryClr),
                //////////////////
             /*   (  request.Status == 'Under Process'&&auth.userData.Type=='Company')
                    ?  _buildBottomSheetButton(
                    label: "Request Completed",
                    onTap: () {
                      // _taskController.markTaskCompleted(task.id);
                      requestController.EditequestStatus(({
                        'Status':'Completed'
                      }), request.id);
                      setState(() {

                      });
                      //  Get.back();
                      Navigator.pop(context);
                    },
                    clr: primaryClr)
                    : Container(),*/
                ///////////////////
                _buildBottomSheetButton(
                    label: "Show Location",
                    onTap: () {
                      // _taskController.deleteTask(task);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Locaction(request)),
                      );
                      //    Get.back();


                    },
                    clr: Colors.red[300]),
                SizedBox(
                  height: 20,
                ),
                _buildBottomSheetButton(
                    label: "Close",
                    onTap: () {
                     // Get.back();
                      Navigator.pop(context);
                    },
                    isClose: true),
                SizedBox(
                  height: 20,
                ),
              ]),
            );}


    );
  }

  _buildBottomSheetButton(
      {String label, Function onTap, Color clr, bool isClose = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose ? Colors.grey[600]
                : Colors.grey[300]
               // : clr,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose ? Colors.transparent : clr,
        ),
        child: Center(
            child: Text(
              label,
              style: isClose
                  ? titleTextStle
                  : titleTextStle.copyWith(color: Colors.white),
            )),
      ),
    );
  }


}
