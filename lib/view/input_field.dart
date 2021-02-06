import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injaz_task/ui/theme.dart';

//import '../theme.dart';
//import 'package:task_management/ui/theme.dart';

class InputField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String hint;
  final Widget widget;

  const InputField(
      {@required this.title,
      this.controller,
      @required this.hint,
      this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: titleTextStle,
            ),
            SizedBox(
              height: 8.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 14.0),
              height: 52,
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.0,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(12.0)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      maxLines: null,
                      autofocus: false,
                      cursorColor:Colors.grey[600],
                        //  Get.isDarkMode ? Colors.grey[100] : Colors.grey[600],
                      readOnly: widget == null ? false : true,
                      controller: controller,
                      style: subTitleTextStle,
                      decoration: InputDecoration(
                        hintText: hint,
                        hintStyle: subTitleTextStle,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: context.theme.backgroundColor,
                            width: 0,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: context.theme.backgroundColor,
                            width: 0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  widget == null ? Container() : widget,
                ],
              ),
            )
          ],
        ));
  }
}
