import 'package:get/get.dart';
import 'package:order_booking/status_repository.dart';
import 'package:order_booking/ui/route/outlet/outlet_list/outlet_list_repository.dart';
import 'package:order_booking/utils/utils.dart';

import '../../db/entities/order_status/order_status.dart';
import '../../db/entities/outlet/outlet.dart';
import '../../model/master_model/master_model.dart';
import '../../model/upload_status_model/upload_status_model.dart';

class UploadOrdersViewModel extends GetxController {
  final StatusRepository _repository;

  final List<UploadStatusModel> _dataList = [];

  final RxList<UploadStatusModel> _orderStatusLiveData = RxList();

  int uploadedCount=0;
  int pendingCount=0;
  int partiallyUploaded=0;
  RxBool isLoading=false.obs;

  UploadOrdersViewModel(this._repository);

  void getAllOrders() async {
    setLoading(true);
    await _repository.getAllOrders().then(
          (items) => refreshOrderList(items),
        );
  }

  void refreshOrderList(List<UploadStatusModel> statusModels){
    uploadedCount=0;
    pendingCount=0;
    partiallyUploaded=0;
    for (UploadStatusModel statusModel in statusModels){
      if (statusModel.synced==1){
        if(statusModel.requestStatus==3){
          uploadedCount++;
        }else{
          partiallyUploaded++;
          pendingCount++;
        }
      }else {
        pendingCount++;
      }
    }
    setLoading(false);
    _orderStatusLiveData(statusModels);
  }

  RxList<UploadStatusModel> getOrders(){
    return _orderStatusLiveData;
  }

  int getPendingCount() {
    return pendingCount;
  }

  int getUploadedCount() {
    return uploadedCount;
  }

  int getTotalCount(){
    return uploadedCount+pendingCount;
  }

  void setLoading(bool value) {
    isLoading(value);
  }


}
