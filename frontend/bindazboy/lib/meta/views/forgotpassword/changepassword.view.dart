import 'package:bindazboy/app/constant/colors.dart';
import 'package:bindazboy/core/notifiers/forgotpassword.notifier.dart';
import 'package:bindazboy/meta/utils/showsnackbar.utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangePasswordView extends StatefulWidget {
  @override
  _ChangePasswordViewState createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    emailController = TextEditingController();
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
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Forgot Password",
                  style: TextStyle(
                      color: Colors.brown[900],
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 40,
                ),
                labeltext("Email"),
                const SizedBox(
                  height: 6,
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.brown[800],
                    ),
                    hintText: "Enter Email",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.black45)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                  style: TextStyle(
                      color: BConstantColors.appbartitleColor,
                      fontSize: 19,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () async {
                    var useremail = emailController.text;
                    if (useremail.isNotEmpty) {
                      await forgotPasswordNotifer.forgotPassword(
                          context: context, useremail: useremail);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Fill the Value"),
                        ),
                      );
                    }
                  },
                  child: Text(
                    "continue",
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
