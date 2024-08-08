import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:order_booking/db/entities/asset/asset.dart';
import 'package:order_booking/db/entities/outlet/outlet.dart';
import 'package:order_booking/db/models/asset_status/asset_status.dart';
import 'package:order_booking/utils/utils.dart';

import '../../../../../status_repository.dart';

class AssetVerificationViewModel extends GetxController {
  final StatusRepository _statusRepository;

  RxList<AssetStatus> assetStatuses = RxList();
  RxList<Asset> assetList = RxList();
  Outlet outlet = Outlet();

  RxBool isLoading = false.obs;

  AssetVerificationViewModel(this._statusRepository);

  void loadOutlet(int outletId) {
    _statusRepository.findOutletById(outletId).then(
          (value) => outlet = value,
        );
  }

  void getLookUpData() {
    _statusRepository.getLookUpData().then(
      (lookUp) {
        if (lookUp != null) {
          assetStatuses(lookUp.assetStatus);
        }
      },
    );
  }

  void loadAssets(int outletId) {
    _statusRepository.getAssets(outletId).then(
          (value) => assetList(value),
        );
  }

  Future<void> verifyAsset(String barcode, LatLng? currentLatLng) async {
    List<Asset>? assets = assetList;
    bool isExist = false;
    for (Asset asset in assets) {
      if (asset.serialNumber == barcode) {
        asset.verified = true;
        asset.latitude = (currentLatLng?.latitude);
        asset.longitude = (currentLatLng?.longitude);
        isExist = true;
        break;
      }
    }
    if (!isExist) {
      showToastMessage("Barcode ($barcode) not exist");
    }
    // assetList(assets);
    // assetList.refresh();
    _statusRepository.updateAssets(assets);
  }

  void setAssetScanned(bool scanned) {
    _statusRepository.setAssetScanned(scanned);
  }

  void setLoading(bool value) {
    isLoading(value);
    isLoading.refresh();
  }

}
