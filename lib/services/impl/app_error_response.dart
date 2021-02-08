class ErrorResponse {
  String error;
  String errorDescription;
  int code;
  Object metaData;

  ErrorResponse(this.error, this.errorDescription, this.code, {this.metaData});

  ErrorResponse.error(this.error)
      : code = 0,
        errorDescription = "";

  ErrorResponse.code(this.code)
      : error = "",
        errorDescription = "";

  ErrorResponse.fromJsonMap(Map<String, dynamic> map)
      : error = map["error"],
        errorDescription = (map["error_description"] ?? map["message"]) ?? "",
        code = (map["error_code"] ?? (map["status"] ?? map["code"])) ?? 0;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = error;
    data['error_description'] = errorDescription;
    data['error_code'] = code;
    return data;
  }

  @override
  String toString() {
    return "Detail: $error, descrption: $errorDescription, code: $code";
  }
}
