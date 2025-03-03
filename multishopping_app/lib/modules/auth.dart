import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import './http_exception.dart';

class Auth with ChangeNotifier {
  String _token = '';
  String _userId = '';

  bool get isAuth {
    return token != '';
  }

  String get token {
    if (_token.toString().isNotEmpty) {
      print('$_token.toString()');
      return _token;
    }
    print("null");
    return '';
  }

  String get userId {
    return _userId;
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
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
      if (urlSegment == 'signupNewUser') {
        Uri url2 = Uri.parse(
            'https://shoppingapp-e1541-default-rtdb.firebaseio.com/userFavorites/$_userId.json?');
        await http.post(url2,
            body: json.encode({
              'default': false,
            }));
      }
      notifyListeners();
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

  Future<void> logout() async {
    _token = '';
    _userId = '';
    notifyListeners();
  }
}
