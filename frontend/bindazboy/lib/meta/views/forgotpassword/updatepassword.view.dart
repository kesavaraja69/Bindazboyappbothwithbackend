import 'package:bindazboy/app/constant/colors.dart';
import 'package:bindazboy/core/notifiers/forgotpassword.notifier.dart';
import 'package:bindazboy/meta/utils/updatepasswod_arguments.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdatePasswordView extends StatefulWidget {
  final UpdatePasswordArguments updatePasswordArguments;

  const UpdatePasswordView({required this.updatePasswordArguments});

  @override
  _UpdatePasswordViewState createState() => _UpdatePasswordViewState();
}

class _UpdatePasswordViewState extends State<UpdatePasswordView> {
  bool _isPasswordVisible = true;
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordController1 = TextEditingController();

  @override
  void initState() {
    passwordController = TextEditingController();
    passwordController1 = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final forgotPasswordNotifer =
        Provider.of<ForgotPasswordNotifer>(context, listen: false);
    return Scaffold(
      backgroundColor: BConstantColors.backgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Update Password",
                  style: TextStyle(
                      color: Colors.brown[900],
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 40,
                ),
                TextField(
                  obscureText: _isPasswordVisible,
                  controller: passwordController1,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.brown[800],
                    ),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        icon: _isPasswordVisible
                            // ignore: dead_code
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility)),
                    hintText: "Enter Password",
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.brown[900]),
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.black45)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  obscureText: _isPasswordVisible,
                  controller: passwordController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.brown[800],
                    ),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        icon: _isPasswordVisible
                            // ignore: dead_code
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility)),
                    hintText: "Enter Password",
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.brown[900]),
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.black45)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    var updatepassword1 = passwordController1.text;
                    var updatepassword2 = passwordController.text;
                    if (updatepassword1.isNotEmpty &&
                        updatepassword2.isNotEmpty &&
                        updatepassword1 == updatepassword2) {
                      await forgotPasswordNotifer.updatePassword(
                          context: context,
                          updateforgotPassword: updatepassword1,
                          useremail: widget.updatePasswordArguments.useremail);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Password is not matched"),
                        ),
                      );
                    }
                  },
                  child: Text(
                    "Update",
                    style: TextStyle(color: Colors.yellow),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: Size(88, 36),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
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
