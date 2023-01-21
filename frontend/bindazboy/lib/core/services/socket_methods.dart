import 'package:bindazboy/core/services/sockect_client.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket;
  void adduserIsOnline(String useremail) {
    _socketClient!.emit(
      'addonlineuser',
      {
        'user': useremail,
      },
    );
  }
}
