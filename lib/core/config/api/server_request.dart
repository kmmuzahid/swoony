// ignore_for_file: public_member_api_docs, sort_constructors_first

enum RequestStatus { requesting, faild, success, init }

class ServerRequest<T> {
  RequestStatus? requestStatus = RequestStatus.init;
  T? data;

  ServerRequest({this.requestStatus, this.data});

  ServerRequest<T> copyWith({RequestStatus? requestStatus, T? data}) {
    return ServerRequest<T>(
      requestStatus: requestStatus ?? this.requestStatus,
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(covariant ServerRequest<T> other) {
    if (identical(this, other)) return true;

    return other.requestStatus == requestStatus && other.data == data;
  }

  @override
  int get hashCode => requestStatus.hashCode ^ data.hashCode;
}
