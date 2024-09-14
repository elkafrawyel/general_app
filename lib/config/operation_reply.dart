///represents what the API replies when performing operations on server.
///fill the type if you intend to return the reply with data
class OperationReply<ReturnType> {
  OperationStatus status;
  String message;
  ReturnType? result;

  OperationReply(this.status,
      {this.message = "Some thing went wrong", this.result});

  load() => status = OperationStatus.loading;

  success() => status = OperationStatus.success;

  bool isLoading() {
    return status == OperationStatus.loading;
  }

  bool isSuccess() {
    return status == OperationStatus.success;
  }

  bool isEmpty() {
    return status == OperationStatus.empty;
  }

  bool isError() {
    return status == OperationStatus.failed;
  }

  ///casts the object to another type ONLY IF it holds no data
  as<NewType>() {
    assert(result == null);
    return OperationReply<NewType>(
      status,
      message: message,
    );
  }

  factory OperationReply.init({
    String message = "Some thing went wrong",
    result,
  }) {
    return OperationReply(
      OperationStatus.init,
      message: message,
      result: result,
    );
  }

  factory OperationReply.loading({
    String message = "Some thing went wrong",
    result,
  }) {
    return OperationReply(
      OperationStatus.loading,
      message: message,
      result: result,
    );
  }

  factory OperationReply.failed({
    String message = "Some thing went wrong",
    result,
  }) {
    return OperationReply(
      OperationStatus.failed,
      message: message,
      result: result,
    );
  }

  factory OperationReply.connectionDown({
    String message = "Some thing went wrong",
    result,
  }) {
    return OperationReply(
      OperationStatus.disConnected,
      message: message,
      result: result,
    );
  }

  factory OperationReply.success({
    String message = "Some thing went wrong",
    result,
  }) {
    return OperationReply(
      OperationStatus.success,
      message: message,
      result: result,
    );
  }

  factory OperationReply.empty({
    String message = "Some thing went wrong",
    result,
  }) {
    return OperationReply(
      OperationStatus.empty,
      message: message,
      result: result,
    );
  }

  factory OperationReply.fromReply(
    OperationReply reply, {
    OperationStatus? status,
    String? message,
    result,
  }) {
    return OperationReply(
      status ?? reply.status,
      message: message ?? reply.message,
      result: result ?? reply.result,
    );
  }
}

enum OperationStatus {
  init,
  loading,
  success,
  empty,
  failed,
  disConnected,
}
