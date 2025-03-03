import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './http_exception.dart';
part 'auth.g.dart';

String _token = '';
String _emailId = '';
String _userId = '';

class Auth extends Notifier<State> {
  Future<bool> get isAuth async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token') ?? '';
    _userId = prefs.getString('userid') ?? '';
    _emailId = prefs.getString('emailid') ?? '';

    return token != '';
  }

  String get token {
    if (_token.toString().isNotEmpty) {
      return _token;
    }

    return '';
  }

  String get userId {
    return _userId;
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final url = Uri.parse(
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/$urlSegment?key=AIzaSyDij4_Q4Hr_tXy8h3-th3ZL7R8dXwliFfA');
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _emailId = email;
      prefs.setString('token', responseData['idToken']);
      prefs.setString('userid', responseData['localId']);
      prefs.setString('emailid', email);

      if (urlSegment == 'signupNewUser') {
        Uri url2 = Uri.parse(
            'https://shoppingapp-e1541-default-rtdb.firebaseio.com/userFavorites/$_userId.json?');
        await http.post(url2,
            body: json.encode({
              'default': false,
            }));
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signupNewUser');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'verifyPassword');
  }

  Future<void> changePassword(String newPassword) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    
    print('Token : $_token');
    if (_token.isEmpty) {
      
      throw Exception('User not authenticated');
      
    }
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:update?key=AIzaSyDij4_Q4Hr_tXy8h3-th3ZL7R8dXwliFfA');
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'idToken': _token,
            'password': newPassword,
            'returnSecureToken': true,
          },
        ),
      );

      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw Exception(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      prefs.setString('token', _token);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = '';
    _userId = '';
    _emailId = '';
    prefs.setString('token', '');
    prefs.setString('userid', '');
    prefs.setString('emailid', '');
  }

  @override
  build() {
    throw UnimplementedError();
  }
}

final authNotifierProvider = NotifierProvider<Auth, State>(() {
  return Auth();
});

@riverpod
String User(ref) {
  return _userId;
}
