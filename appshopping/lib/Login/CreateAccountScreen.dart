import 'package:appshopping/Login/ForgotPasswordScreen.dart';
import 'package:appshopping/Login/LoginScreen.dart';
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

    if (accountName.isEmpty || accountEmail.isEmpty || password.isEmpty) {
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
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.jpg"), // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                color: Colors.white.withOpacity(0.7), // Adjust opacity as needed
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
                      color: Colors.blueAccent,
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
                        prefixIcon: Icon(Icons.person, color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: accountEmailController,
                      decoration: InputDecoration(
                        labelText: 'Account Email',
                        prefixIcon: Icon(Icons.email, color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: passwordController,
                      obscureText: !_showPassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock, color: Colors.black),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _showPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.black,
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
                              builder: (context) =>
                                  ForgotPasswordScreen(accountsData: accountsData),
                            ),
                          );
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'CustomFont',
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        addAccountToData(accountsData);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        primary: Colors.blueAccent, // Đặt màu nền của nút
                        minimumSize:
                            Size(200.0, 50.0), // Đặt kích thước tối thiểu của nút
                      ),
                      child: Center(
                        child: Text('Create Account',style: TextStyle(color: Colors.white),),
                      ),
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
            ],
          ),
        ),
      ),
    );
  }
}
