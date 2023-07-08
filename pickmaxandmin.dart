import 'package:hive/hive.dart';

void main() async{
  print("hii");
  Hive.init('searchHistory');
  Box box = await Hive.openBox('Box');
  Map history = box.toMap();
  print(history);
}
