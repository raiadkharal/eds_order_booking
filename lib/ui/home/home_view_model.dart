import 'package:get/get.dart';
import 'package:order_booking/ui/home/home_repository.dart';

import '../../db/models/work_status/work_status.dart';
import '../../utils/PreferenceUtil.dart';
import '../../utils/util.dart';
import '../repository.dart';

class HomeViewModel extends GetxController {
  final HomeRepository _homeRepository;
  final PreferenceUtil _preferenceUtil;
  final Repository _repository;

  RxString lastSyncDate = "".obs;


  HomeViewModel(this._homeRepository, this._preferenceUtil, this._repository);

  void start(){
    _preferenceUtil.setRequestCounter(1);
    _homeRepository.getToken();
  }

  void download() {
    _homeRepository.fetchTodayData(true);
  }


  void checkDayEnd() {
    int lastSyncDate = _preferenceUtil.getWorkSyncData().syncDate;
    if (lastSyncDate != 0) {
      if (!Util.isDateToday(lastSyncDate)) {
        setStartDay(false);
      } else {
        setStartDay(true);
      }
    } else {
      setStartDay(false);
    }
  }


  void saveWorkSyncData(WorkStatus status) =>
      _preferenceUtil.saveWorkSyncData(status);

  void setSyncDate(String date) => lastSyncDate.value = date;

  WorkStatus getWorkSyncData() => _preferenceUtil.getWorkSyncData();

  void setStartDay(bool value) => _homeRepository.setStartDay(value);

  RxBool startDay() => _homeRepository.onDayStarted();

  // bool isDayStarted() => _homeRepository.isDayStarted();
  bool isDayStarted() =>true;

  RxBool isLoading() => _homeRepository.isLoading();
  RxBool getTargetVsAchievement() => _homeRepository.getTargetVsAchievement();

  void endDay() {}

}
