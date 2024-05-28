
import '../../../utils/enums.dart';

class ApiResponse<T> {
  RequestStatus? status;
  T? data;
  String? message;

  ApiResponse(this.status, this.data, this.message);

  ApiResponse.loading() : status = RequestStatus.LOADING;

  ApiResponse.success(this.data) : status = RequestStatus.SUCCESS;

  ApiResponse.error(this.message) : status = RequestStatus.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}
