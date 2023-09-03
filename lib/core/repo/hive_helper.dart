import 'package:hive/hive.dart';

import '../models/news_model/hive_bookMark_model.dart';

class HiveHelper {
  static final bookMarks = Hive.box<HiveBookMarkModel>('bookMarks');
}
