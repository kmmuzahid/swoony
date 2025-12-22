import 'dart:async';

// ignore: library_prefixes
import 'package:swoony/core/config/api/api_end_point.dart';
import 'package:swoony/core/config/socket/stream_data_model.dart';
import 'package:swoony/core/utils/log/app_log.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'notification_model.dart';
import 'socket_message_model.dart';

class SocketService {
  SocketService._();

  late IO.Socket socket;
  StreamController<StreamDataModel> streamController =
      StreamController<StreamDataModel>.broadcast();
  // Singleton pattern
  static final SocketService instance = SocketService._();

  // Connect to the Socket.IO server
  void connect({required String id}) {
    socket = IO.io(
      ApiEndPoint.instance.domain,
      IO.OptionBuilder().setTransports(['websocket']).build(),
    );
    streamController = StreamController<StreamDataModel>.broadcast();
    // Handle connection
    socket.on('connect', (_) {
      AppLogger.info(
        'Connected to Socket.IO server id = $id ${ApiEndPoint.instance.domain}',
        tag: 'Socket',
      );
    });

    //notification
    socket.on('notification::$id', (data) {
      AppLogger.apiDebug('Notification Event: $data', tag: 'Socket');
      AppLogger.info('Notification Event: $data', tag: 'Socket');
      if (data != null) {
        streamController.add(
          StreamDataModel(
            streamType: StreamType.notification,
            data: NotificationModel.fromMap(data),
          ),
        );
      }
    });

    //message only
    socket.on('message::$id', (data) {
      AppLogger.apiDebug('Received message: $data', tag: 'Socket');
      if (data != null) {
        streamController.add(
          StreamDataModel(streamType: StreamType.message, data: SocketMessageModel.fromJson(data)),
        );
      }
      AppLogger.apiDebug('Received message: $data', tag: 'Socket');
    });

    // Handle disconnection
    socket.on('disconnect', (_) {
      AppLogger.debug('Disconnected from Socket.IO server');
    });

    // Handle errors
    socket.on('connect_error', (error) {
      AppLogger.error('Connection Error: $error', tag: 'socket');
    });

    // Connect to the server
    socket.connect();

    Future.delayed(const Duration(milliseconds: 500)).then((_) {
      register(id: id);
    });
  }

  void register({required String id}) async {
    socket.emit('register', id);
  }

  // Emit a message to the server
  void sendMessage(dynamic message) {
    if (message != null) {
      streamController.add(
        StreamDataModel(streamType: StreamType.message, data: SocketMessageModel.fromJson(message)),
      );
    }
    AppLogger.debug('Sent message: $message', tag: 'socket');
  }

  // Disconnect from the server
  void disconnect() {
    try {
      socket.disconnect();
      socket.dispose();
      streamController.close();
      AppLogger.debug(
        'Disconnected from server, has listeners ${streamController.hasListener} ${streamController.isClosed}',
        tag: 'socket',
      );
    } catch (_) {}
  }
}
