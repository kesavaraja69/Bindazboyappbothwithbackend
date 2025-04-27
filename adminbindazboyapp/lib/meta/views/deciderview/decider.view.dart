import 'dart:async';
import 'dart:io';
import 'package:adminbindazboyapp/core/notifiers/cache.notifier.dart';
import 'package:adminbindazboyapp/meta/views/authentication/login.view.dart';
import 'package:adminbindazboyapp/meta/views/home/home.view.dart';
import 'package:adminbindazboyapp/meta/views/splashView/splash.view.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeciderView extends StatelessWidget {
  const DeciderView({super.key});

  @override
  Widget build(BuildContext context) {
    CacheNotifer cacheNotifier() =>
        Provider.of<CacheNotifer>(context, listen: false);
    return FutureBuilder(
      future: cacheNotifier().readCache(key: "jwtdata"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SplashView();
        }
        if (!snapshot.hasData) {
          return LoginView();
        } else {
          return HomeblogView();
        }
      },
    );
  }
}

class ConnectionCheckerView extends StatefulWidget {
  const ConnectionCheckerView({super.key});

  @override
  _ConnectionCheckerViewState createState() => _ConnectionCheckerViewState();
}

class _ConnectionCheckerViewState extends State<ConnectionCheckerView> {
  Map _source = {ConnectivityResult.none: false};
  final MyConnectivity _connectivity = MyConnectivity.instance;
  @override
  void initState() {
    super.initState();
    _connectivity.initConnection();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.mobile:
        return DeciderView();
      default:
        return NoInternetView();
    }
  }

  @override
  void dispose() {
    _connectivity.disposeStream();
    super.dispose();
  }
}

class MyConnectivity {
  MyConnectivity._();
  static final _instance = MyConnectivity._();
  static MyConnectivity get instance => _instance;
  final _connectivity = Connectivity();
  final _controller = StreamController.broadcast();
  Stream get myStream => _controller.stream;

  void initConnection() async {
    List<ConnectivityResult> result = await _connectivity.checkConnectivity();
    _checkInternetConnection(result.first);
    _connectivity.onConnectivityChanged.listen((result) {
      _checkInternetConnection(result.first);
    });
  }

  void _checkInternetConnection(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('example.com');
      isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isOnline = false;
    }
    _controller.sink.add({result: isOnline});
  }

  void disposeStream() => _controller.close();
}

class NoInternetView extends StatelessWidget {
  const NoInternetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Icon(Icons.signal_cellular_connected_no_internet_4_bar, size: 62),
            SizedBox(height: 20),
            Text(
              "No internet connection",
              style: TextStyle(color: Colors.lightGreenAccent, fontSize: 26),
            ),
            SizedBox(height: 30),
            Text(
              "Bindazboy",
              style: TextStyle(color: Colors.lightGreenAccent, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
