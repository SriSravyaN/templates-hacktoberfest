import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'addstudentinfo.dart';

class StudentTextFields extends StatefulWidget {
  final int index;
  StudentTextFields(this.index);
  @override
  _StudentTextFieldsState createState() => _StudentTextFieldsState();
}

class _StudentTextFieldsState extends State<StudentTextFields> {
  double constAreaM = 0.0;

  List nameList=[], perList=[], branchList=[];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
    //   _nameController.text = ConstructionInfoState.floorIdList[widget.index]
    //       ?? '';
    // });

    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 16.0),
          padding: EdgeInsets.only(
              left: 4.0, right: 4.0),
          child: TextFormField(
            keyboardType: TextInputType.name,
            textAlign: TextAlign.left,
            onSaved: (value) => StudentInfoState.nameList[widget.index] = value,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Enter Student Name!';
              }
              return null;
            },
            decoration: InputDecoration(
                labelText: "Student Name",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)))
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                padding: EdgeInsets.only(
                    left: 4.0, right: 4.0),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  textAlign: TextAlign.left,
                  onSaved: (value) => StudentInfoState.perList[widget.index] = value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Student Percentage!';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Percentage",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)))
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                padding: EdgeInsets.only(
                    left: 4.0, right: 4.0),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  textAlign: TextAlign.left,
                  onSaved: (value) => StudentInfoState.branchList[widget.index] = value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Student Branch!';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Branch",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)))
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}