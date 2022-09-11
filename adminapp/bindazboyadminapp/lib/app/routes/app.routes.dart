import 'package:bindazboyadminapp/meta/views/addblog/addblog.view.dart';
import 'package:bindazboyadminapp/meta/views/authentication/login.view.dart';
import 'package:bindazboyadminapp/meta/views/authentication/signup.view.dart';
import 'package:bindazboyadminapp/meta/views/deciderview/decider.view.dart';
import 'package:bindazboyadminapp/meta/views/home/components/blogdetail.view.dart';
import 'package:bindazboyadminapp/meta/views/home/home.view.dart';
import 'package:bindazboyadminapp/meta/views/splashView/splash.view.dart';
import 'package:bindazboyadminapp/meta/views/updateblog/updateblog.view.dart';
import 'package:flutter/cupertino.dart';

class AppRoutes {
  static const String HomeRoute = "/home";
  static const String SignupRoute = "/signup";
  static const String DeciderRoute = "/decide";
  static const String LoginRoute = "/login";
  static const String SplashRoute = "/splash";
  static const String AddblogRoute = "/addblog";
  static const String UpdateblogRoute = "/update";
  static const String BlogDetailRoute = "/details";

  static Map<String, Widget Function(BuildContext)> routes = {
    HomeRoute: (context) => HomeblogView(),
    DeciderRoute: (context) => DeciderView(),
    SplashRoute: (context) => SplashView(),
    SignupRoute: (context) => SignupView(),
    LoginRoute: (context) => LoginView(),
    UpdateblogRoute: (context) => UpdateBlog(
        blogDetailArguments:
            ModalRoute.of(context)!.settings.arguments as dynamic),
    AddblogRoute: (context) => AddBlog(),
    BlogDetailRoute: (context) => Blogdetailsview(
        blogDetailArguments:
            ModalRoute.of(context)!.settings.arguments as dynamic),
  };
}
