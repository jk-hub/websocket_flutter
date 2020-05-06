import 'dart:convert';
import 'dart:io';

class SocketUtil {
  //
  Socket _socket;
  static const String SERVER_IP = "192.168.0.105";
  static const int SERVER_PORT = 8080;

  Future<bool> sendMessage(String message, Function connectListener,
      Function messageListener) async {
    try {
      _socket = await Socket.connect(SERVER_IP, SERVER_PORT);
      connectListener(true);
      _socket.listen((List<int> event) {
        messageListener(utf8.decode(event));
      });

      _socket.add(utf8.encode(message));
      _socket.close();
    } catch (e) {
      connectListener(false);
      return false;
    }
    return true;
  }

  void closeSocket() {
    _socket.close();
    _socket = null;
  }

  void cleanUp() {
    if (null != _socket) {
      _socket.destroy();
    }
  }
}
