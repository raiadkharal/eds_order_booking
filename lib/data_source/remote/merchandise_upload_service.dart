
import 'package:get/get.dart';
import 'package:order_booking/data_source/remote/api_service.dart';
import 'package:order_booking/db/dao/merchandise_dao.dart';
import 'package:order_booking/model/merchandise_model/merchandise_model.dart';

import '../../db/entities/merchandise/merchandise.dart';
import '../../db/models/merchandise_images/merchandise_image.dart';
import '../../model/merchandise_upload_model/merchandise_upload_model.dart';

class MerchandiseUploadService {
  final String token;
  final int statusId;
  final int outletId;

  MerchandiseUploadService(this.token, this.statusId, this.outletId);

  Future<void> startService() async {
    MerchandiseDao merchandiseDao  = Get.find<MerchandiseDao>();

    Merchandise? merchandise = await merchandiseDao.findMerchandiseByOutletId(outletId);

    if(merchandise!=null&&merchandise.merchandiseImages!=null){
      for(MerchandiseImage merchandiseImage in merchandise.merchandiseImages!){
        List<String>? path = merchandiseImage.path?.split("/");
        if(path!=null&&path.isNotEmpty){
          merchandiseImage.image ="$outletId - ${merchandiseImage.id} - ${path[path.length - 1]}";
        }
      }

    }

    uploadMerchandise(merchandise);
  }

  Future<void> uploadMerchandise(Merchandise? merchandise) async{

    MerchandiseUploadModel merchandiseModel = MerchandiseUploadModel(merchandise: MerchandiseModel.fromJson(merchandise!.toJson()) );
    merchandiseModel.statusId=statusId;

    ApiService apiService = Get.find<ApiService>();
  }
}