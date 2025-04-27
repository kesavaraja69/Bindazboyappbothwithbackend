import 'package:bindazboy/core/notifiers/cache.notifier.dart';
import 'package:bindazboy/meta/views/authentication/login.view.dart';
import 'package:bindazboy/meta/views/home/home.view.dart';
import 'package:bindazboy/meta/views/splashview/splash.view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeciderView extends StatelessWidget {
  const DeciderView({super.key});

  @override
  Widget build(BuildContext context) {
    CacheNotifier cacheNotifier() =>
        Provider.of<CacheNotifier>(context, listen: false);
    return FutureBuilder(
      future: cacheNotifier().readCache(key: "jwtdata"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SplashView();
        }
        if (!snapshot.hasData) {
          return LoginView();
        } else {
          return HomeView();
        }
      },
    );
  }
}
