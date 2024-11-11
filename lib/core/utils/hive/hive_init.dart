
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:platform_x/core/utils/exceptions/hive/errors.dart';
import 'package:platform_x/core/utils/exceptions/hive/hiveException.dart';

class HiveService {

  late Box<dynamic> taskBox;
  

  Future<void> _initHive() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);

    taskBox = await Hive.openBox("tasks");
  }


  HiveService(){
    if (taskBox == null) {
      _initHive();
    }
  }


  Future<void> addTask(Map<String, dynamic> task) async {
    try {
      if (taskBox == null) {
        await _initHive();
      }
      await taskBox.add(task);
    } catch (e) { 
      throw HiveException(HiveErrors.writeToBoxFailed.message, 1003);
    }
  }



}