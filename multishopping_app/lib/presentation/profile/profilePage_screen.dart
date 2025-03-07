import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:multishopping_app/presentation/profile/store/language/language_store.dart';
import 'package:multishopping_app/utils/locale/app_localization.dart';
import 'package:multishopping_app/presentation/login/store/auth.dart';
import 'package:multishopping_app/core/domain/modules/http_exception.dart';
import 'package:multishopping_app/presentation/tabView_screen.dart';
import 'package:multishopping_app/presentation/profile/store/theme/theme_store.dart';

import 'package:shared_preferences/shared_preferences.dart';

enum MenuItem {
  logout,
}

class ProfilePageScreen extends ConsumerStatefulWidget {
  const ProfilePageScreen({super.key});

  @override
  ConsumerState<ProfilePageScreen> createState() => _ProfilePageScreenState();
}

class _ProfilePageScreenState extends ConsumerState<ProfilePageScreen> {
  final ThemeStore _themeStore = GetIt.instance<ThemeStore>();
  final LanguageStore _languageStore = GetIt.instance<LanguageStore>();
  String? email;

  Future<void> setEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('emailid');
  }

  final Map<String, String> _authData = {
    'password': '',
  };
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _reEnterPasswordController =
      TextEditingController();

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _updatePassword() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState?.save();
    String newPassword = _passwordController.text;
    String reEnterNewPassword = _reEnterPasswordController.text;

    if (newPassword.isNotEmpty && reEnterNewPassword.isNotEmpty) {
      try {
        FutureBuilder(
          future: ref.read(authNotifierProvider.notifier).changePassword(
                _authData['password'] as String,
              ),
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.done
                ? Container()
                : CircularProgressIndicator();
          },
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Password updated successfully!"),
          ),
        );

        _passwordController.clear();
        _reEnterPasswordController.clear();
      } on HttpException catch (error) {
        var errorMessage = error.message;
        _showErrorDialog(errorMessage);
      } catch (error) {
        const errorMessage =
            'Could not authenticate you. Please try again later.';
        _showErrorDialog(errorMessage);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please enter a new password and Conform Password!"),
        ),
      );
    }
  }

  Widget _buildThemeButton() {
    return Observer(
      builder: (context) {
        return IconButton(
          onPressed: () {
            _themeStore.changeBrightnessToDark(!_themeStore.darkMode);
          },
          icon: Icon(
            _themeStore.darkMode ? Icons.brightness_5 : Icons.brightness_3,
          ),
        );
      },
    );
  }

  Widget _buildLanguageButton() {
    return IconButton(
      onPressed: () {
        _buildLanguageDialog();
      },
      icon: Icon(
        Icons.language,
      ),
    );
  }

  _buildLanguageDialog() {
    _showDialog<String>(
      context: context,
      child: AlertDialog(
        // borderRadius: 5.0,
        // enableFullWidth: true,
        title: Text(
          AppLocalizations.of(context).translate('home_tv_choose_language'),
        ),
        // headerColor: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        // closeButtonColor: Colors.white,
        // enableCloseButton: true,
        // enableBackButton: false,
        // onCloseButtonClicked: () {
        //   Navigator.of(context).pop();
        // },
        actions: _languageStore.supportedLanguages
            // children: _languageStore.supportedLanguages
            .map(
              (object) => ListTile(
                dense: true,
                contentPadding: EdgeInsets.all(0.0),
                title: Text(
                  object.language,
                  style: TextStyle(
                    color: _languageStore.locale == object.locale
                        ? Theme.of(context).primaryColor
                        : _themeStore.darkMode
                            ? Colors.white
                            : Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  // change user language based on selected locale
                  _languageStore.changeLanguage(object.locale);
                },
              ),
            )
            .toList(),
      ),
    );
  }

  _showDialog<T>({required BuildContext context, required Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T? value) {
      // The value passed to Navigator.pop() or null.
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBarView = AppBar(
      title: Text(
        AppLocalizations.of(context).translate("profile_title"),
      ),
      actions: [
        _buildLanguageButton(),
        _buildThemeButton(),
        PopupMenuButton(
          icon: Icon(Icons.more_vert),
          onSelected: (selectedvalue) {
            setState(() {
              if (selectedvalue == MenuItem.logout) {
                setState(() {
                  ref.read(authNotifierProvider.notifier).logout();
                  Navigator.popAndPushNamed(context, TabViewScreen.routeName);
                });
              }
            });
          },
          itemBuilder: (_) => [
            PopupMenuItem(
              value: MenuItem.logout,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Logout",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.logout)
                  ]),
            ),
          ],
        ),
      ],
    );
    return Scaffold(
      appBar: appBarView,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Email Id",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
                FutureBuilder(
                  future: setEmail(),
                  builder: (context, snapshot) {
                    return Text('$email',
                        style: TextStyle(
                          fontSize: 16,
                        ));
                  },
                ),
                SizedBox(height: 20),
                Text("New Password",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Enter new password",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['password'] = value.toString();
                  },
                ),
                SizedBox(height: 20),
                Text("Conform New Password",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _reEnterPasswordController,
                  decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      border: OutlineInputBorder()),
                  obscureText: true,
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return 'Passwords do not match!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _updatePassword,
                    child: Text("Update Password"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
