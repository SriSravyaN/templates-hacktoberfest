import 'dart:convert';
import 'package:flutter_crud_web/constants/constants.dart';
import 'package:http/http.dart' as http;

class UpdateStudentsApi {
  Future<Object> updateStudents(String rollNo, String name, String per, String branch) async {

    String url = StudentConstants().baseUrl +"/updateStudent";
    Object responseData;

    var body = jsonEncode({
      "rollNo": rollNo,
      "name": name,
      "percentage": per,
      "branch": branch
    });

    final response = await http.put(Uri.parse(url),
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept",
          "Content-Type": "application/json"
        },
        body: body
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      responseData = json.decode(response.body);
    } else {
      throw Exception('Failed to load data!');
    }
    return responseData;
  }
}