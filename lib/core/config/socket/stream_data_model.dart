// ignore_for_file: public_member_api_docs, sort_constructors_first
enum StreamType { support, announce, message, notification }

class StreamDataModel {
  final StreamType streamType;
  final dynamic data;
  StreamDataModel({
    required this.streamType,
    required this.data,
  });

  StreamDataModel copyWith({
    StreamType? streamType,
    dynamic data,
  }) {
    return StreamDataModel(
      streamType: streamType ?? this.streamType,
      data: data ?? this.data,
    );
  }
}
