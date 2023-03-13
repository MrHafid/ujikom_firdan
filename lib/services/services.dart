import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

String API = 'https://mr-hafid-default-rtdb.firebaseio.com/';
Position? position_data;

getApiMethod({String? apis}) async {
  try {
    final response = await http.get(
      Uri.parse(API + apis!),
    );
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return data;
    } else {
      return data;
    }
  } catch (e) {
    print(e);
  }
}
