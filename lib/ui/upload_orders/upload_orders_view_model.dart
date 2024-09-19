import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
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

  RxInt uploadedCount=0.obs;
  RxInt pendingCount=0.obs;
  RxInt partiallyUploaded=0.obs;
  RxBool isLoading=false.obs;

  UploadOrdersViewModel(this._repository);

  void getAllOrders() async {
    setLoading(true);
    await _repository.getAllOrders().then(
          (items) => refreshOrderList(items),
        );
  }

  void refreshOrderList(List<UploadStatusModel> statusModels){
    uploadedCount(0);
    pendingCount(0);
    partiallyUploaded(0);
    for (UploadStatusModel statusModel in statusModels){
      if (statusModel.synced==1){
        if(statusModel.requestStatus==3){
          uploadedCount(uploadedCount.value+1);
        }else{
          partiallyUploaded(partiallyUploaded.value+1);
          pendingCount(pendingCount.value+1);
        }
      }else {
        pendingCount(pendingCount.value+1);
      }
    }
    setLoading(false);
    _orderStatusLiveData(statusModels);
  }

  RxList<UploadStatusModel> getOrders(){
    return _orderStatusLiveData;
  }

  RxInt getPendingCount() {
    return pendingCount;
  }

  RxInt getUploadedCount() {
    return uploadedCount;
  }

  RxInt getTotalCount(){
    RxInt totalCount = 0.obs;
    totalCount(uploadedCount.value+pendingCount.value);
    return totalCount;
  }

  void setLoading(bool value) {
    isLoading(value);
  }


}
