import 'package:adminbindazboyapp/core/notifiers/authentication.notifer.dart';
import 'package:adminbindazboyapp/core/services/socket_client.dart';
import 'package:provider/provider.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket;
  // void adduserIsOnline(String useremail) {
  //   _socketClient!.emit(
  //     'addonlineuser',
  //     {
  //       'user': useremail,
  //     },
  //   );
  // }
  void fetchUserOnline(context) {
    _socketClient!.on('onlineuser', (data) {
      print("socket data $data");
      Provider.of<AuthenticationNotifier>(context, listen: false)
          .readUserdata(data: data);
    });
  }

  void endSocket() {
    _socketClient!.dispose();
  }
}
