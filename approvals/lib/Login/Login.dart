import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Screen/approval_screen.dart';
import 'CreateAcc.dart';
import 'Forgotpass.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordVisible = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isEmailEntered = false;
  bool checkLoginPress = false;
  bool checkPassPress = false;

  Future<bool> checkUserExist(String enteredEmail) async {
    try {
      final apiUrl = 'https://devsyscm.inos.vn:12089/idocNet.Test.MobileGateForEcore.V10.WA/Ecore/Inos_CheckUserExist';

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'GwUserCode': 'idocNet.idN.MobileGate.Sv',
          'GwPassword': 'idocNet.idN.MobileGate.Sv',
          'NetworkID': '4221896000',
          'OrgID': '4221896000',
          'NetworkId': '4221896000',
          'OrgId': '4221896000',
        },
        body: {
          'UserCode': enteredEmail,
        },
      );
      print(json.decode(response.body)['Success']);
      if (response.statusCode == 200 && json.decode(response.body)['Success'] == true) {
        //if(json.decode(response.body)['Success'] == true)
        setState(() {
          isEmailEntered = true;
        });
        print(isEmailEntered);
        return true;
      } else {
        print('API request failed with status code: ${response.statusCode}');
        print(isEmailEntered);
        return false;
      }
    } catch (e) {
      print(isEmailEntered);
      print('Error during API request: $e');
      return false;
    }
  }

  Future<void> requestToken(String enteredEmail, String enteredPassword) async {
    try {
      final apiUrl = 'https://devsyscm.inos.vn:12089/idocNet.Test.MobileGateForEcore.V10.WA/Ecore/Inos_RequestToken';

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'GwUserCode': 'idocNet.idN.MobileGate.Sv',
          'GwPassword': 'idocNet.idN.MobileGate.Sv',
        },
        body: {
          'usercode': enteredEmail,
          'password': enteredPassword,
        },
      );

      if (response.statusCode == 200) {
        //setState(() {
          isEmailEntered = true;
        //});
        Map<String, dynamic> jsonResponse = json.decode(response.body);

        String accessToken = jsonResponse['Data']['AccessToken'];
        String refreshToken = jsonResponse['Data']['RefreshToken'];
        int expiresIn = jsonResponse['Data']['expires_in'];

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ApprovalScreen(
              accessToken: accessToken,
              refreshToken: refreshToken,
              expiresIn: expiresIn,
            ),
          ),
        );
      } else {
        print('API request failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during API request: $e');
    }
  }

  void login() async {
    String enteredEmail = emailController.text.trim();
    String enteredPassword = passwordController.text.trim();

    if (!isEmailEntered) {
       await checkUserExist(enteredEmail);
    } else {
      await requestToken(enteredEmail, enteredPassword);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.menu_book_outlined,
                size: 64,
                color: Colors.green,
              ),
              SizedBox(height: 16),
              Text(
                'Log In',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email,
                      color: Colors.green),
                ),
              ),
              if (checkLoginPress && !isEmailEntered)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Tên đăng nhập sai/tài khoản chưa tồn tại!',
                      style: TextStyle(color: Colors.red, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              if (isEmailEntered)
                SizedBox(height: 16),
              if (isEmailEntered)
                TextField(
                  controller: passwordController,
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock,
                        color: Colors.green),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                ),
              if (checkPassPress && isEmailEntered)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Mật khẩu sai !', style: TextStyle(color: Colors.red, fontStyle: FontStyle.italic)),
                  ],
                ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgotPasswordScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  // Add logic to handle login
                  if(isEmailEntered){
                    checkPassPress =true;
                  }
                  login();
                  setState(() {
                    checkLoginPress =true;
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green, // Set the background color to green
                ),
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),

              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateAccountScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "I haven't already an account",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'CustomFont',
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
