 import 'package:order_booking/db/entities/merchandise/merchandise.dart';
import 'package:order_booking/db/entities/task/task.dart';
import 'package:order_booking/model/configuration/configurations_model.dart';
import 'package:order_booking/utils/PreferenceUtil.dart';

import '../db/dao/merchandise_dao.dart';
import '../db/dao/task_dao.dart';

class Repository {
 final PreferenceUtil _preferenceUtil;
 final MerchandiseDao _merchandiseDao;
 final TaskDao _taskDao;

 Repository(this._preferenceUtil, this._merchandiseDao, this._taskDao);

 Future<void> insertIntoDB(Merchandise merchandise) =>
     _merchandiseDao.insertMerchandise(merchandise);

 ConfigurationModel getConfiguration() => _preferenceUtil.getConfig();

  Future<List<Task>?> getTasksByOutlet(int outletId)=>_taskDao.getTaskByOutletId(outletId);

}