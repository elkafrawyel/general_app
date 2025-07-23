sealed class ApiResult<T> {
  const ApiResult();

  bool isStart() => this is ApiStart;
  bool isSuccess() => this is ApiSuccess;

  bool isLoading() => this is ApiLoading;

  bool isEmpty() => this is ApiEmpty;

  bool isFailure() => this is ApiFailure;

  T getData() {
    return (this as ApiSuccess).data as T;
  }

  String getError() {
    return (this as ApiFailure).message;
  }

  dynamic getFailureData() {
    return (this as ApiFailure).data;
  }
}

class ApiStart<T> extends ApiResult<T> {
  const ApiStart();
}

class ApiLoading<T> extends ApiResult<T> {
  const ApiLoading();
}

class ApiEmpty<T> extends ApiResult<T> {
  final String message;

  const ApiEmpty(this.message);
}

class ApiSuccess<T> extends ApiResult<T> {
  final T data;

  const ApiSuccess(this.data);
}

class ApiFailure<T> extends ApiResult<T> {
  final String message;
  final dynamic data;

  const ApiFailure(this.message, {this.data});
}
