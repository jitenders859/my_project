import 'package:upstreet_flutter_code_challenge/services/impl/app_error_response.dart';
import 'package:upstreet_flutter_code_challenge/services/impl/base_respose.dart';

class AppResponse<D extends Object> implements BaseResponse<D, ErrorResponse> {
  final D data;
  ErrorResponse error;
  Object pagination;

  AppResponse({this.data, this.error});

  AppResponse.fromError(this.error) : data = null;
  AppResponse.fromData(this.data) : error = null;

  @override
  String toString() {
    var string = super.toString();
    if (data != null) {
      string += data.toString();
    }
    if (error != null) {
      string += error.toString();
    }
    return string;
  }

  @override
  int get hashCode => (data.hashCode ?? 0 + error.hashCode ?? 0);

  AppResponse copyWith({D data, ErrorResponse error}) {
    return AppResponse<D>(data: data ?? this.data, error: error ?? this.error);
  }
}
