import 'package:flutter/material.dart';
import 'addstudentdetails.dart';

class StudentInfo extends StatefulWidget {

  @override
  StudentInfoState createState() => StudentInfoState();
}

class StudentInfoState extends State<StudentInfo> {
  static List nameList = [null];
  static List perList = [null];
  static List branchList = [null];

  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  void _submit(BuildContext context) {
    _formKey.currentState!.save();
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    setState(() {
      isLoading = true;

      print("name"+nameList.toString());
      print("branch"+branchList.toString());
      print("per"+perList.toString());
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => OwnerInfo(floorId: floorIdList, constYear: constYear,
      //     constTypeId: constTypeid, usableTypeId: usableTypeId, constAreaF: constAreaF, constAreaM: constAreaM, surveyNo: widget.surveyNo, zoneNo: widget.zoneNo,
      //     wardNo: widget.wardNo, plotNo: widget.plotNo, propertyOld: widget.propertyOld, propertyNew: widget.propertyNew,
      //     address: widget.address, propertyType: widget.propertyType, totalAreaF: widget.totalAreaF, totalAreaM: widget.totalAreaM, rentStatus: widget.rentStatus,
      //     rentAreaF: widget.rentAreaF, rentAreaM: widget.rentAreaM)));

      // isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Builder(
            builder: (context) => Form(
                key: _formKey,
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Scrollbar(
                          isAlwaysShown: true,
                          thickness: 5.0,
                          radius: const Radius.circular(4.0),
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                ..._getFriends(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.all(8.0),
                        margin: EdgeInsets.only(right: 12.0, bottom: 4.0),
                        child: (isLoading) ? CircularProgressIndicator() :
                        ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                      side: const BorderSide(color: Colors.blueAccent)
                                  )
                              )
                          ),
                          onPressed: () {
                            _submit(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: const Text(
                              "Save",
                              style: TextStyle(
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ]))));
  }

  List<Widget> _getFriends() {
    List<Widget> friendsTextFieldsList = [];
    for (int i = 0; i < nameList.length; i++) {
      friendsTextFieldsList.add(
        Column(
          children: [
            StudentTextFields(i),
            Container(height: 1.0, margin: EdgeInsets.all(10.0), color: Colors.black12,),
            Container(
              child: _addRemoveButton(i == nameList.length - 1, i),
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(right: 10.0),
            ),
          ],
        ),
      );
    }
    return friendsTextFieldsList;
  }

  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          nameList.insert(0, nameList[index]);
          perList.insert(0, perList[index]);
          branchList.insert(0, perList[index]);
        } else {
          nameList.removeAt(index);
          perList.removeAt(index);
          branchList.removeAt(index);
        }
        setState(() {});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.blueAccent : Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }
}