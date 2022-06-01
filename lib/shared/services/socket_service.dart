import 'package:socket_io_client/socket_io_client.dart';

class SocketService{
  Socket init(){
    Socket socket = io("https://chillo.stupd.dev/socket.io", <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();
    return socket;
  }
}