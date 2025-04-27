import 'package:bindazboy/app/constant/colors.dart';
import 'package:bindazboy/core/notifiers/forgotpassword.notifier.dart';
import 'package:bindazboy/meta/utils/otpverify_arguments.dart';
import 'package:bindazboy/meta/utils/showsnackbar.utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class verifyOtpView extends StatefulWidget {
  final OTPVerfiyArguments otpVerfiyArguments;

  const verifyOtpView({super.key, required this.otpVerfiyArguments});

  @override
  _verifyOtpViewState createState() => _verifyOtpViewState();
}

class _verifyOtpViewState extends State<verifyOtpView> {
  TextEditingController otpVerifyController = TextEditingController();

  @override
  void initState() {
    otpVerifyController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final forgotPasswordNotifer = Provider.of<ForgotPasswordNotifer>(
      context,
      listen: false,
    );

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
                  "Enter Verification Code",
                  style: TextStyle(
                    color: Colors.brown[900],
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 40),
                labeltext("Enter OTP"),
                const SizedBox(height: 6),
                TextField(
                  controller: otpVerifyController,
                  decoration: InputDecoration(
                    hintText: "verification code",
                    labelStyle: TextStyle(color: Colors.brown[900]),
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.black45),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  style: TextStyle(
                    color: BConstantColors.appbartitleColor,
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    var otpVerify = otpVerifyController.text;
                    if (otpVerify.isNotEmpty) {
                      await forgotPasswordNotifer.otpVerification(
                        context: context,
                        useremail: widget.otpVerfiyArguments.useremail,
                        otpcode: otpVerify,
                      );
                    } else {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text("Fill the Value")));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: Size(88, 36),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
                  ),
                  child: Text("verify", style: TextStyle(color: Colors.yellow)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
