import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:order_booking/db/entities/task/task.dart';
import 'package:order_booking/model/configuration/configurations_model.dart';

import '../../../../db/entities/merchandise/merchandise.dart';
import '../../../../db/models/merchandise_images/merchandise_image.dart';
import '../../../repository.dart';

class MerchandisingViewModel extends GetxController {
  final Repository _repository;

  Rx<List<MerchandiseImage>> beforeImages = Rx<List<MerchandiseImage>>([]);
  Rx<List<MerchandiseImage>> afterImages = Rx<List<MerchandiseImage>>([]);
  Rx<Merchandise> merchandiseData = Merchandise().obs;
  List<MerchandiseImage> listImages = [];
  Rx<List<MerchandiseImage>> imagesLiveData = Rx<List<MerchandiseImage>>([]);

  RxBool isLoading = false.obs;
  RxBool enableAfterMerchandiseButton = false.obs;
  RxBool enableNextButton = false.obs;
  RxBool isSaved = false.obs;
  RxBool lessImages = false.obs;
  int imagesCount = 0;

  MerchandisingViewModel(this._repository);

  // MerchandisingViewModel(this._repository);

  Future<void> saveImages(String? imagePath, int type) async {
    imagesCount++;
    MerchandiseImage item = MerchandiseImage();
    item.id = imagesCount;
    //item.setBase64Image(base64Image);
    item.path = imagePath;
    item.type = type;

    listImages.add(item);

    debugPrint("imagePath:: $imagePath");
    setEnableNextButton(type);
  }

  Future<void> removeMerchandiseImage(MerchandiseImage image) async {
    listImages.remove(image);
    setImageLiveData();
  }

  void setLoading(bool value) {
    isLoading.value = value;
    isLoading.refresh();
  }

  Rx<Merchandise> loadMerchandise(int outletId) {
    /*
    try {
      _repository.findMerchandise(outletId).then((merchandise) {
        listImages.clear();
        if (merchandise.merchandiseImages != null) {
          listImages.addAll(merchandise.merchandiseImages!);
        }
        imagesCount = listImages.length;
        merchandiseData.value = merchandise;
        if (imagesCount > 1) {
          setEnableNextButton(1);
        }
      });
    } catch (e) {
      showToastMessage(e.toString());
    }

    return merchandiseData;
  */
    return Merchandise().obs;
  }

  void setEnableNextButton(int type) {
    enableAfterMerchandiseButton.value = false;
    enableAfterMerchandiseButton.refresh();
    if (listImages.length > 1 && type == 1) {
      enableNextButton.value = true;
      enableNextButton.refresh();
    }
    setImageLiveData();
  }

  void setImageLiveData() {
    imagesLiveData.value = listImages;
    imagesLiveData.refresh();
  }

  void populateMerchandise(
      bool beforeMerchandise, List<MerchandiseImage> merchandiseImages) {
    if (beforeMerchandise) {
      beforeImages.value = merchandiseImages;
      beforeImages.refresh();
    } else {
      afterImages.value = merchandiseImages;
      afterImages.refresh();
    }
  }

  bool validateImageCount() {
    int type0Count = getImageCountByType(0);
    int type1Count = getImageCountByType(1);

    if (type1Count < 1 || type0Count < 1) {
      setLessImages(true);
      return false;
    }
    return true;
  }

  int getImageCountByType(int type) {
    int count = 0;
    for (MerchandiseImage img in listImages) {
      if (img.type == type) {
        count++;
      }
    }
    return count;
  }

  void setLessImages(bool value) {
    lessImages.value = value;
    lessImages.refresh();
  }

  void insertMerchandiseIntoDB(int outletId) {
    if (listImages.length >= 2) {
      saveMerchandise(outletId, imagesLiveData.value);
    } else {
      setLessImages(true);
    }
  }

  void saveMerchandise(int outletId, List<MerchandiseImage> merchandiseImages) {
    Merchandise merchandise = Merchandise();
    merchandise.outletId = outletId;
    merchandise.merchandiseImages = merchandiseImages;

    _repository.insertIntoDB(merchandise).whenComplete(() {
      setIsSaved(true);
    }).onError((error, stackTrace) {
      setIsSaved(true);
    });
  }

  void setIsSaved(bool value) {
    isSaved.value = value;
    isSaved.refresh();
  }

  ConfigurationModel getConfiguration() => _repository.getConfiguration();

  Future<List<Task>?> getTasksByOutletId(int outletId) =>
      _repository.getTasksByOutlet(outletId);
}
