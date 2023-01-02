import 'package:bindazboy/app/constant/colors.dart';
import 'package:bindazboy/app/routes/app.routes.dart';
import 'package:bindazboy/core/notifiers/authentication.notifier.dart';
import 'package:bindazboy/meta/utils/showsnackbar.utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupView extends StatefulWidget {
  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  bool _isPasswordVisible = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authenticationNotifer =
        Provider.of<AuthenticationNotifer>(context, listen: false);
    return Scaffold(
      backgroundColor: BConstantColors.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Container(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 140,
                ),
                Text(
                  "SignUp",
                  style: TextStyle(
                      color: BConstantColors.appbartitleColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 40,
                ),
                labeltext("Name"),
                const SizedBox(
                  height: 6,
                ),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "Enter Name",
                    labelStyle: TextStyle(color: BConstantColors.black),
                    //fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                        borderSide:
                            BorderSide(color: BConstantColors.lightgrey)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                        borderSide:
                            BorderSide(color: BConstantColors.fullblack)),
                  ),
                  style: TextStyle(
                      color: BConstantColors.appbartitleColor,
                      fontSize: 19,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 12,
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
                      color: BConstantColors.authenticationIconColor,
                    ),
                    hintText: "Enter Email",
                    labelStyle: TextStyle(color: BConstantColors.black),
                    //fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                        borderSide:
                            BorderSide(color: BConstantColors.lightgrey)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                        borderSide:
                            BorderSide(color: BConstantColors.fullblack)),
                  ),
                  style: TextStyle(
                      color: BConstantColors.appbartitleColor,
                      fontSize: 19,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 12,
                ),
                labeltext("Create Password"),
                const SizedBox(
                  height: 6,
                ),
                TextField(
                  obscureText: _isPasswordVisible,
                  controller: passwordController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock,
                      color: BConstantColors.authenticationIconColor,
                    ),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        icon: _isPasswordVisible
                            // ignore: dead_code
                            ? Icon(
                                Icons.visibility_off,
                                color: BConstantColors.authenticationIconColor,
                              )
                            : Icon(
                                Icons.visibility,
                                color: BConstantColors.authenticationIconColor,
                              )),
                    hintText: "Enter Password",

                    labelStyle: TextStyle(color: BConstantColors.black),
                    //fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                        borderSide:
                            BorderSide(color: BConstantColors.lightgrey)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                        borderSide:
                            BorderSide(color: BConstantColors.fullblack)),
                  ),
                  style: TextStyle(
                      color: BConstantColors.appbartitleColor,
                      fontSize: 19,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: () async {
                    var username = nameController.text;
                    var useremail = emailController.text;
                    var userpassword = passwordController.text;

                    if (username.isNotEmpty &&
                        useremail.isNotEmpty &&
                        userpassword.isNotEmpty) {
                      await authenticationNotifer.createNewAccount(
                          context: context,
                          username: username,
                          useremail: useremail,
                          userpassword: userpassword);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Fill the values")));
                    }
                  },
                  child: Text(
                    "SignUp",
                    style: TextStyle(
                        color: BConstantColors.authenticationTxtColor,
                        fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: BConstantColors.authenticationBtnColor,
                    minimumSize: Size(95, 39),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.LoginRoute);
                  },
                  child: Text(
                    "Old member? Login",
                    style: TextStyle(
                        color: BConstantColors.appbartitleColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
