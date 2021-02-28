class CallContext {
  String message;
  bool isError = false;
  String errorMessage;
  CallContext({this.message, this.errorMessage});

  setError(String msg) {
    print(msg);
    this.message = msg;
    this.errorMessage = msg;
    isError = true;
  }

  setSuccess(String msg) {
    print(msg);
    this.message = msg;
    isError = false;
  }
}
