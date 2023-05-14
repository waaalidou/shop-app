// ignore_for_file: avoid_print, unused_field

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Authentication with ChangeNotifier {
  late String _token;
  late DateTime _expireDate;
  late String _userId;

  Future<void> _authenticate(
      String email, String password, String segmentUrl) async {
        const webApiKey = 'AIzaSyDi_sBArQsDVR1OqH2TP3K9JuLuGofqSGg';
         final url = Uri.parse(
      'https://identitytoolkit.googleapis.com/v1/accounts:$segmentUrl?key=$webApiKey',
    );
    late http.Response response;
    try {
       response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
    } catch (e) {
      rethrow;
    } 
    final responseData = json.decode(response.body);
    // firebase will throw an error only if the status code is 200 
    // in this case of authen yes we do have an erro but the status is 400 no error will be thrown
    // but the body has an error item luckily we can check it if it exists that means something wrong 
    // occured
    if(responseData['error'] != null) {
      throw HttpException(responseData['error']['message']);
    }
    print(response.body);
  }

  Future<void> signUp(String email, String password) async { 
    return _authenticate(email, password, 'signUp');
  }

  Future<void> signIn(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }
}
