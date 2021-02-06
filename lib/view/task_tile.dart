import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
//import 'package:get/get_connect/http/src/request/request.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:injaz_task/models/requst_model.dart';
import 'package:injaz_task/ui/theme.dart';
//import 'package:todomaster/models/task.dart';

//import '../size_config.dart';
//import '../theme.dart';
//import 'package:task_management/models/task.dart';
//import 'package:task_management/ui/size_config.dart';
//import 'package:task_management/ui/theme.dart';

class TaskTile extends StatelessWidget {
  final Request request;
  TaskTile(this.request);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      EdgeInsets.symmetric(horizontal: 20),
      width:MediaQuery.of(context).size.width,
      // SizeConfig.screenWidth,
      margin: EdgeInsets.only(bottom: 12),
      child: Container(
        padding: EdgeInsets.all(16),
        //  width: SizeConfig.screenWidth * 0.78,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: primaryClr
          //_getBGClr(task.color),
        ),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  request.title,
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      FlutterIcons.clock_faw5,
                      color: Colors.grey[200],
                      size: 15,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${request.startTime} - ${request.endTime}",
                      style: GoogleFonts.lato(
                        textStyle:
                        TextStyle(fontSize: 13, color: Colors.grey[100]),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Text(
                  request.request,
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(fontSize: 12, color: Colors.grey[100]),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            width: 0.5,
            color: Colors.grey[200].withOpacity(0.7),
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
                request.Status,
             // task.isCompleted == 1 ? "COMPLETED" : "TODO",

              style: GoogleFonts.lato(
                textStyle: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  _getBGClr(int no) {
    switch (no) {
      case 0:
        return purpleClr;
      case 1:
        return pinkClr;
      case 2:
        return yellowClr;
      default:
        return purpleClr;
    }
  }
}
