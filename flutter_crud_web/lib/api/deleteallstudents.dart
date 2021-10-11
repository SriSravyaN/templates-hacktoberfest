import 'dart:convert';
import 'package:flutter_crud_web/constants/constants.dart';
import 'package:http/http.dart' as http;

class DeleteAllStudentsApi {
  Future<Object> deleteStudents() async {

    String url = StudentConstants().baseUrl +"/deleteAll";
    Object responseData;

    final response = await http.delete(Uri.parse(url),
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept",
          "Content-Type": "application/json"
        },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      responseData = json.decode(response.body);
    } else {
      throw Exception('Failed to load data!');
    }
    return responseData;
  }
}