import 'dart:convert';
import 'dart:io';

import 'package:customer_app/models/usermodel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NetworkRequest {
  final String BASE_URL = 'http://34.65.224.147';
  User user;
  static final NetworkRequest _instance = NetworkRequest._privateConstructor();

  factory NetworkRequest() => _instance;

  NetworkRequest._privateConstructor() {
    getUserData();
  }

  Future<User> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userString = prefs.getString('user');
    if(userString == null){
      return null;
    }
    user = User.fromJson(jsonDecode(userString));
    print(user.toJson().toString());
    return user;
  }

  setUserData(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userString = jsonEncode(user.toJson());
    return prefs.setString('user', userString);
  }

  Future<CustomResponse> getRequest(url) async {
    String token = user?.token;
    var response;
    Map<String, String> headers;
    if (token == null) {
      headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
    } else {
      headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
    }
    try {
      response = await http.get(BASE_URL + url, headers: headers);
    } on SocketException catch (e) {
      return CustomResponse(500, 'Something Wrong', {});
    }
    var body = json.decode(response.body);
    return CustomResponse(200, body['message'], body);
  }

  Future<CustomResponse> postRequest(url, data) async {
    String token = user?.token;
    var response;
    Map<String, String> headers;
    if (token == null) {
      headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
    } else {
      headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
    }
    try {
      response = await http.post(BASE_URL + url,
          headers: headers, body: json.encode(data));
      print(response);
    } on SocketException catch (e) {
      return CustomResponse(500, 'Something Wrong', {});
    }
    var body = json.decode(response.body);
    return CustomResponse(200, body['message'], body);
  }
}

class CustomResponse {
  int statusCode;
  String message;
  Map data;

  CustomResponse(this.statusCode, this.message, this.data);
}
