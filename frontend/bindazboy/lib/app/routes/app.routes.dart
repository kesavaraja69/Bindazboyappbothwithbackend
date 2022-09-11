import 'package:bindazboy/meta/views/authentication/login.view.dart';
import 'package:bindazboy/meta/views/authentication/signup.view.dart';
import 'package:bindazboy/meta/views/blogdetails/blogdetails.view.dart';
import 'package:bindazboy/meta/views/bookmark/bookmark.view.dart';
import 'package:bindazboy/meta/views/catergory/catergory.view.dart';
import 'package:bindazboy/meta/views/deciderview/decider.view.dart';
import 'package:bindazboy/meta/views/forgotpassword/changepassword.view.dart';
import 'package:bindazboy/meta/views/forgotpassword/updatepassword.view.dart';
import 'package:bindazboy/meta/views/forgotpassword/verifyotp.view.dart';
import 'package:bindazboy/meta/views/home/home.view.dart';
import 'package:bindazboy/meta/views/searchpage/search.view.dart';
import 'package:bindazboy/meta/views/splashview/splash.view.dart';

import 'package:flutter/cupertino.dart';

import '../../meta/views/home/components/audio/audiobookdetailsdata.dart';

class AppRoutes {
  static const String NointernetRoute = "/nointernet";
  static const String LoginRoute = "/login";
  static const String SignUpRoute = "/signup";
  static const String ServerRoute = "/server";
  static const String HomeRoute = "/home";
  static const String AudioBookDetailRoute = "/audiobookdetail";
  static const String SearchRoute = "/search";
  static const String SplashRoute = "/splash";
  static const String DeciderRoute = "/decider";
  static const String BookmarkRoute = "/bookmark";
  static const String CatergoryRoute = "/catergory";
  static const String BlogDetailRoute = "/details";
  static const String ForgotPasswordRoute = "/forgotpassword";
  static const String VerifyOTPRoute = "/verifyOtp";
  static const String UpdatePasswordRoute = "/updatepassword";

  static Map<String, Widget Function(BuildContext)> routes = {
    LoginRoute: (context) => LoginView(),
    SearchRoute: (context) => SearchBlogview(),
    SplashRoute: (context) => SplashView(),
    SignUpRoute: (context) => SignupView(),
    BookmarkRoute: (context) => BookmarkView(),
    CatergoryRoute: (context) => CatergoryView(),
    HomeRoute: (context) => HomeView(),
    DeciderRoute: (context) => DeciderView(),
    BlogDetailRoute: (context) => Blogdetailsview(
        blogDetailArguments:
            ModalRoute.of(context)!.settings.arguments as dynamic),
    ForgotPasswordRoute: (context) => ChangePasswordView(),
    VerifyOTPRoute: (context) => verifyOtpView(
        otpVerfiyArguments:
            ModalRoute.of(context)!.settings.arguments as dynamic),
    UpdatePasswordRoute: (context) => UpdatePasswordView(
        updatePasswordArguments:
            ModalRoute.of(context)!.settings.arguments as dynamic),
    AudioBookDetailRoute: (context) => AudiobookDetailsdata(
        audiobookDetailArguments:
            ModalRoute.of(context)!.settings.arguments as dynamic),
  };
}
