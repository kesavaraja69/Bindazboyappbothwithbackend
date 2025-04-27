import 'package:bindazboy/app/constant/colors.dart';
import 'package:bindazboy/app/routes/app.routes.dart';
import 'package:bindazboy/core/notifiers/authentication.notifier.dart';
import 'package:bindazboy/meta/utils/showsnackbar.utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _isPasswordVisible = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authenticationNotifer = Provider.of<AuthenticationNotifer>(
      context,
      listen: false,
    );
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: BConstantColors.backgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.24),
                    Text(
                      "Login",
                      style: TextStyle(
                        color: BConstantColors.appbartitleColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 40),
                    labeltext("Email"),
                    const SizedBox(height: 6),
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
                          borderSide: BorderSide(
                            color: BConstantColors.lightgrey,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                          borderSide: BorderSide(
                            color: BConstantColors.fullblack,
                          ),
                        ),
                      ),
                      style: TextStyle(
                        color: BConstantColors.appbartitleColor,
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 25),
                    labeltext("Password"),
                    const SizedBox(height: 6),
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
                          icon:
                              _isPasswordVisible
                                  // ignore: dead_code
                                  ? Icon(
                                    Icons.visibility_off,
                                    color:
                                        BConstantColors.authenticationIconColor,
                                  )
                                  : Icon(
                                    Icons.visibility,
                                    color:
                                        BConstantColors.authenticationIconColor,
                                  ),
                        ),
                        hintText: "Enter Password",
                        labelStyle: TextStyle(color: BConstantColors.black),
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                          borderSide: BorderSide(
                            color: BConstantColors.lightgrey,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                          borderSide: BorderSide(
                            color: BConstantColors.fullblack,
                          ),
                        ),
                      ),
                      style: TextStyle(
                        color: BConstantColors.appbartitleColor,
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.of(
                          context,
                        ).pushNamed(AppRoutes.ForgotPasswordRoute);
                      },
                      child: Text(
                        "Forgot Password ?",
                        style: TextStyle(
                          color: BConstantColors.appbartitleColor,
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        var useremail = emailController.text;
                        var userpassword = passwordController.text;

                        if (useremail.isNotEmpty && userpassword.isNotEmpty) {
                          await authenticationNotifer.login(
                            context: context,
                            useremail: useremail,
                            userpassword: userpassword,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Fill the values")),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: BConstantColors.authenticationBtnColor,
                        minimumSize: Size(95, 39),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                        ),
                      ),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: BConstantColors.authenticationTxtColor,
                          fontSize: 19,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRoutes.SignUpRoute);
                      },
                      child: Text(
                        "New member? SignUp",
                        style: TextStyle(
                          color: BConstantColors.appbartitleColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
