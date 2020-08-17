import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'serviceutils.dart';

class SocketConnectionItem {
  IO.Socket socket;
  static List event = [
    'connect',
    'connect_error',
    'connect_timeout',
    'connecting',
    'disconnect',
    'error',
    'reconnect',
    'reconnect_attempt',
    'reconnect_failed',
    'reconnect_error',
    'reconnecting',
    'ping',
    'pong'
  ];
  getSocketConnectionItem() {
    socket = IO.io(ServiceUtils.url + ServiceUtils.port, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });
  }
}
