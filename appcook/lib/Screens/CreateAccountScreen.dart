import 'package:appcook/Screens/ForgotPasswordScreen.dart';
import 'package:appcook/Screens/LoginScreen.dart';
import 'package:flutter/material.dart';

class CreateAccountScreen extends StatefulWidget {
  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

List<Map<String, String>> accountsData = [
    {
      "Accountname": "A001",
      "Accountemail": "A001",
      "Password": "1",
      "FlagActive": "1"
    },
    {
      "Accountname": "A002",
      "Accountemail": "A002@gmail.com",
      "Password": "1q2w3E",
      "FlagActive": "1"
    },
    {
      "Accountname": "A003",
      "Accountemail": "A003@gmail.com",
      "Password": "1q2w3E",
      "FlagActive": "1"
    }
  ];

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  bool _showPassword = false;

  // Controllers for text fields
  TextEditingController accountNameController = TextEditingController();
  TextEditingController accountEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void addAccountToData(List<Map<String, String>> accountsData) {

    String accountName = accountNameController.text.trim();
    String accountEmail = accountEmailController.text.trim();
    String password = passwordController.text.trim();

    // Validate and extract values from TextFields
    if (accountName.isEmpty || accountEmail.isEmpty || password.isEmpty) {
      // Display an error message if any field is empty
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Vui lòng điền đủ thông tin'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    // check account tồn tại chưa
    bool accountExists = accountsData.any(
      (account) =>
          account['Accountname'] == accountName ||
          account['Accountemail'] == accountEmail,
    );

    if (!accountExists) {
      //ADD
      accountsData.add({
        "Accountname": accountName,
        "Accountemail": accountEmail,
        "Password": password,
        "FlagActive": "1",
      });
      print("accountData $accountsData");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    } else {
      // Display an error message if the account already exists
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Tài khoản tạo đã tồn tại'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              color: Colors.white,
              height: double.infinity,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.account_circle,
                    size: 64,
                    color: Colors.redAccent,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Create an Account',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'CustomFont',
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: accountNameController,
                    decoration: InputDecoration(
                      labelText: 'Account Name',
                      prefixIcon: Icon(Icons.person, color: Colors.redAccent),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: accountEmailController,
                    decoration: InputDecoration(
                      labelText: 'Account Email',
                      prefixIcon: Icon(Icons.email, color: Colors.redAccent),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: passwordController,
                    obscureText: !_showPassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock, color: Colors.redAccent),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _showPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.redAccent,
                        ),
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
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
                          color: Colors.redAccent,
                          fontFamily: 'CustomFont',
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Add logic to handle account creation
                      addAccountToData(accountsData);
                    },
                    child: Text('Create Account'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          // Navigate to LoginScreen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'I have Already have an account',
                          style: TextStyle(
                            color: Colors.redAccent,
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
          ],
        ),
      ),
    );
  }
}
