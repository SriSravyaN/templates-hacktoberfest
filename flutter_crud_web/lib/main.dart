import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_crud_web/addstudentinfo.dart';
import 'package:flutter_crud_web/api/addstudents.dart';
import 'package:flutter_crud_web/api/deleteallstudents.dart';
import 'package:flutter_crud_web/api/deletestudent.dart';
import 'package:flutter_crud_web/constants/constants.dart';
import 'package:flutter_crud_web/model/studentlist.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api/updatestudentapi.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Web CRUD',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Web CRUD'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  ScrollController _scrollController = ScrollController();

  late List<StudentListModel> _list;
  final _formKey = GlobalKey<FormState>();
  late String name, per, branch;

  Future<List<StudentListModel>> getAllStudents() async {

    String link = StudentConstants().baseUrl + "/getAllStudents";

    var res = await http.get(
      Uri.parse(link),
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept",
        "Content-Type": "application/json"
      },
    );
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data["response"] as List;
      _list = rest
          .map<StudentListModel>((json) => StudentListModel.fromJson(json))
          .toList();
    }
    return _list;
  }

  Widget listViewWidget(List<StudentListModel> list) {
    return ListView.builder(
        itemCount: list.length,
        physics: ScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(2.0),
        itemBuilder: (context, position) {
          return GestureDetector(
            child: Column(children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      flex: 1,
                      child: Text('${list[position].rollNo.toString()}'),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text('${list[position].name}'),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text('${list[position].percentage}')
                    ),
                    Expanded(flex: 2, child: Text('${list[position].branch}')),
                    Container(child: InkWell(
                      onTap: () {
                        __deleteItem(context, list[position]);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(Icons.delete, color: Colors.black54,),
                      ),
                    ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(4.0))
                      ), margin: EdgeInsets.only(right: 8.0),),
                    Container(child: InkWell(
                      onTap: () {
                        _updateItem(context, list[position]);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(Icons.edit, color: Colors.black54,),
                      ),
                    ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(4.0))
                      ), margin: EdgeInsets.only(right: 8.0),),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0),
                height: 1.0,
                color: Colors.black12,
              ),
            ]),
            // onTap: () => _onTapItem(context, list[position]),
          );
        });
  }

  __deleteAllItems(BuildContext context) {
    Widget cancelButton = TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('Cancel', style: TextStyle(color: Colors.black87),));
    Widget deleteButton = TextButton(
        onPressed: () {
          DeleteAllStudentsApi().deleteStudents().then((value) => print(value));
          Navigator.pop(context);
          setState(() {});
        },
        child: const Text('Delete All'));

    return showDialog(context: context, builder: (context) =>
        AlertDialog(
          actionsPadding: EdgeInsets.all(8.0),
          title: Text('Delete Student', style: TextStyle(fontWeight: FontWeight.bold),),
          content: Text('Are you sure want to delete All Students?'),
          actions: [
            cancelButton,
            deleteButton
          ],
        ));
  }

  __deleteItem(BuildContext context, StudentListModel model) {
    Widget cancelButton = TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('Cancel', style: TextStyle(color: Colors.black87),));
    Widget deleteButton = TextButton(
        onPressed: () {
         DeleteStudentApi().deleteStudent(model.rollNo.toString()).then((value) => print(value));
         Navigator.pop(context);
         setState(() {});
        },
        child: const Text('Delete'));

    return showDialog(context: context, builder: (context) =>
     AlertDialog(
       actionsPadding: EdgeInsets.all(8.0),
        title: Text('Delete Student', style: TextStyle(fontWeight: FontWeight.bold),),
       content: Text('Are you sure want to delete?'),
       actions: [
         cancelButton,
         deleteButton
       ],
    ));
  }

  _updateItem(BuildContext context, StudentListModel model) {

    var _formKey = GlobalKey<FormState>();
    String? name, percentage, branch;

    Widget cancelButton = TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('Go Back', style: TextStyle(color: Colors.black87),));

    Widget updateButton = TextButton(
        onPressed: () {
          _formKey.currentState!.save();
          final isValid = _formKey.currentState!.validate();
          if (!isValid) {
            return;
          }
          UpdateStudentsApi().updateStudents(model.rollNo.toString(), name.toString(), percentage.toString(), branch.toString()).then((value) => print(value));
          Navigator.pop(context);
          setState(() {});
        },
        child: const Text('Update'));

    return showDialog(context: context, builder: (context) =>
        AlertDialog(
          actionsPadding: EdgeInsets.all(12.0),
          title: Text('Update Student', style: TextStyle(fontWeight: FontWeight.bold),),
          content: SizedBox(
            width: MediaQuery.of(context).size.width/2,
            child: Form(
              key: _formKey, child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                  padding: EdgeInsets.only(
                      left: 4.0, right: 4.0),
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    initialValue: model.name.toString(),
                    textAlign: TextAlign.left,
                    onSaved: (value) => name = value,
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
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.only(top: 16.0),
                        padding: EdgeInsets.only(
                            left: 4.0, right: 4.0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          initialValue: model.percentage.toString(),
                          textAlign: TextAlign.left,
                          onSaved: (value) => percentage = value,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter average percentage!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "Average Percentage",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(4.0)))
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0,),
                    Expanded(
                      flex: 5,
                      child: Container(
                        margin: EdgeInsets.only(top: 16.0),
                        padding: EdgeInsets.only(
                            left: 4.0, right: 4.0),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          initialValue: model.branch.toString(),
                          textAlign: TextAlign.left,
                          onSaved: (value) => branch = value,
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
            ),),
          ),
          actions: [
            cancelButton,
            updateButton
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Container(child: InkWell(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Center(child: Text('Delete All', style: TextStyle(color: Colors.black54))),
            ),
            onTap: () {
              __deleteAllItems(context);
            },
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            color: Colors.white,),
            margin: EdgeInsets.all(8.0),
          ),
          SizedBox(
            width: 8.0,
          )
        ],
      ),
      body: CustomScrollView(controller: _scrollController, slivers: [
      SliverList(
      delegate: SliverChildListDelegate(
      [
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    flex: 1,
                    child: Text('Roll No.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text('Student Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),),
                  ),
                  Expanded(
                      flex: 3,
                      child: Text('Percentage', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),)
                  ),
                  Expanded(flex: 2, child: Text('Branch', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),)),
                  SizedBox(width: 100.0,)
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20.0, right: 20.0),
              height: 1.0,
              color: Colors.black12,
            ),
          FutureBuilder<List<StudentListModel>>(
          future: getAllStudents(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<StudentListModel>? data = snapshot.data;
              return listViewWidget(data!);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return Center(child: CircularProgressIndicator());
          },
          ),
        ],
      ),)]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          // Widget cancelButton = TextButton(
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //     child: const Text('Go Back', style: TextStyle(color: Colors.black87),));
          //
          // Widget addButton = TextButton(
          //     onPressed: () {
          //       _formKey.currentState!.save();
          //       final isValid = _formKey.currentState!.validate();
          //       if (!isValid) {
          //         return;
          //       }
          //       AddStudentApi().addStudent(name, double.parse(per), branch);
          //       Navigator.pop(context);
          //       setState(() {});
          //     },
          //     child: const Text('ADD'));
          //
          showDialog(context: context, builder: (context) => AlertDialog(
            actionsPadding: EdgeInsets.all(12.0),
            title: Text('Add Student', style: TextStyle(fontWeight: FontWeight.bold),),
            content: StudentInfo(),
          ));
          //   content: SizedBox(
          //     width: MediaQuery.of(context).size.width/2,
          //     child: Form(
          //       key: _formKey,
          //       child: Column(
          //         mainAxisSize: MainAxisSize.min,
          //         children: [
          //           Container(
          //             margin: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 16.0),
          //             padding: EdgeInsets.only(
          //                 left: 4.0, right: 4.0),
          //             child: TextFormField(
          //               keyboardType: TextInputType.name,
          //               textAlign: TextAlign.left,
          //               onSaved: (value) => name = value!,
          //               validator: (value) {
          //                 if (value!.isEmpty) {
          //                   return 'Enter Student Name!';
          //                 }
          //                 return null;
          //               },
          //               decoration: InputDecoration(
          //                   labelText: "Student Name",
          //                   border: OutlineInputBorder(
          //                       borderRadius: BorderRadius.all(Radius.circular(4.0)))
          //               ),
          //             ),
          //           ),
          //           Row(
          //             children: [
          //               Expanded(
          //                 flex: 3,
          //                 child: Container(
          //                   margin: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
          //                   padding: EdgeInsets.only(
          //                       left: 4.0, right: 4.0),
          //                   child: TextFormField(
          //                     keyboardType: TextInputType.name,
          //                     textAlign: TextAlign.left,
          //                     onSaved: (value) => per = value!,
          //                     validator: (value) {
          //                       if (value!.isEmpty) {
          //                         return 'Enter Student Percentage!';
          //                       }
          //                       return null;
          //                     },
          //                     decoration: InputDecoration(
          //                         labelText: "Percentage",
          //                         border: OutlineInputBorder(
          //                             borderRadius: BorderRadius.all(Radius.circular(4.0)))
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //               Expanded(
          //                 flex: 5,
          //                 child: Container(
          //                   margin: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
          //                   padding: EdgeInsets.only(
          //                       left: 4.0, right: 4.0),
          //                   child: TextFormField(
          //                     keyboardType: TextInputType.name,
          //                     textAlign: TextAlign.left,
          //                     onSaved: (value) => branch = value!,
          //                     validator: (value) {
          //                       if (value!.isEmpty) {
          //                         return 'Enter Student Branch!';
          //                       }
          //                       return null;
          //                     },
          //                     decoration: InputDecoration(
          //                         labelText: "Branch",
          //                         border: OutlineInputBorder(
          //                             borderRadius: BorderRadius.all(Radius.circular(4.0)))
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          //   actions: [
          //     cancelButton,
          //     addButton
          //   ],
          // ));
        },
        tooltip: 'Add Student',
        child: const Icon(Icons.add),
      ),
    );
  }
}
