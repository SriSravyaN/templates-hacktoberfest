import 'dart:convert';
import 'package:flutter_crud_web/constants/constants.dart';
import 'package:http/http.dart' as http;

class AddStudentApi {
  Future<Object> addStudent(String name, double per, String branch) async {

    String url = StudentConstants().baseUrl +"/addStudent";
    Object responseData;

    var body = jsonEncode({
      "name": name,
      "percentage": per,
      "branch": branch
    });

    final response = await http.post(Uri.parse(url),
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