import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:order_booking/db/entities/outlet/outlet.dart';
import 'package:order_booking/db/entities/task/task.dart';
import 'package:order_booking/model/configuration/configurations_model.dart';
import 'package:order_booking/status_repository.dart';

import '../../../../db/entities/asset/asset.dart';
import '../../../../db/entities/merchandise/merchandise.dart';
import '../../../../db/models/merchandise_images/merchandise_image.dart';
import '../../../../utils/utils.dart';
import '../../../repository.dart';

class MerchandisingViewModel extends GetxController {
  final Repository _repository;
  final StatusRepository _statusRepository;

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
  Rx<Outlet> outlet = Outlet().obs;
  List<Asset> _mAssets=[];

  int imagesCount = 0;

  MerchandisingViewModel(this._repository, this._statusRepository);

  // MerchandisingViewModel(this._repository);

  Future<void> loadOutlet(int outletId) async {
    _statusRepository.findOutletById(outletId).then(
      (value) {
        outlet(value);
        _repository.setAssetsScannedInLastMonth(value.isAssetsScennedInTheLastMonth??false);
        _repository.setEnforcedAssetScan(!(value.isAssetsScennedInTheLastMonth??false));
      },
    );
  }

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
    try {
      setLoading(true);
      _repository.findMerchandise(outletId).then((merchandise) {
        listImages.clear();
        setLoading(false);
        if (merchandise != null) {
          if (merchandise.merchandiseImages != null) {
            listImages.addAll(merchandise.merchandiseImages!);
          }
          imagesCount = listImages.length;
          merchandiseData.value = merchandise;
        }
        if (imagesCount > 1) {
          setEnableNextButton(1);
        }
      });
    } catch (e) {
      setLoading(false);
      showToastMessage(e.toString());
    }

    return merchandiseData;
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

  void insertMerchandiseIntoDB(int outletId,String remarks,int? statusId) {
    if (listImages.length >= 2) {
      setLoading(true);
      saveMerchandise(outletId,remarks,imagesLiveData.value,statusId);
    } else {
      setLessImages(true);
    }
  }

  void saveMerchandise(int outletId, String remarks,List<MerchandiseImage> merchandiseImages,int? statusId) {
    Merchandise merchandise = Merchandise();
    merchandise.outletId = outletId;
    merchandise.merchandiseImages = merchandiseImages;
    merchandise.remarks=remarks;
    merchandise.assetList=_mAssets;

    _repository.insertIntoDB(merchandise).whenComplete(() {
      setLoading(false);
      setIsSaved(true);
    }).onError((error, stackTrace) {
      setLoading(false);
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

  RxList<Asset> getAssets(int outletId) {
    final RxList<Asset> assets = RxList();
    _statusRepository.getAssets(outletId).then(
      (assetList) {
        _mAssets=assetList;
        assets(assetList);
        assets.refresh();
      },
    );

    return assets;
  }

  void setAssetsScannedInLastMonth(bool value) {
    _repository.setAssetsScannedInLastMonth(value);
  }

  bool getEnforceAssetScan() {
    return _repository.getEnforceAssetScan();
  }

  bool getAssetsScanned() {
    return _repository.getAssetsScanned();
  }

  int getAssetsVerifiedCount() {
    return _repository.getAssetsVerifiedCount();
  }

  bool isTestUser() {
    return _repository.isTestUser();
  }

  void updateOutlet(Outlet outlet) {
    _statusRepository.updateOutlet(outlet);
  }
}
