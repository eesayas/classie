import 'package:socket_io_client/socket_io_client.dart' as IO;

IO.Socket socket =
    IO.io("https://kumonedmontonheritage.classie.ca", <String, dynamic>{
  'transports': ['websocket'],
  'autoConnect': false,
});

void newCheckIn(cb) {
  socket.on("NEW_CHECK_IN", (_) {
    cb();
  });
}

void sendCheckIn() {
  socket.emit("STUDENT_CHECKED_IN");
}

void newCheckOut(cb) {
  socket.on("NEW_CHECK_OUT", (_) {
    cb();
  });
}

void sendCheckOut() {
  socket.emit("STUDENT_CHECKED_OUT");
}

void overTimeCheck(cb) {
  socket.on("OVERTIME", (_) {
    cb();
  });
}
