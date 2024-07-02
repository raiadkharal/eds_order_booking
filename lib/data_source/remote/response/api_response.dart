
import '../../../utils/enums.dart';

class ApiResponse<T> {
  RequestStatus? status;
  int? statusCode;
  T? data;
  String? message;

  ApiResponse(this.status, this.data, this.message,this.statusCode);

  ApiResponse.loading() : status = RequestStatus.LOADING;

  ApiResponse.success(this.data) : status = RequestStatus.SUCCESS;

  ApiResponse.error(this.message,this.statusCode) : status = RequestStatus.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}
