import 'package:hive/hive.dart';
import 'package:me_reminder/models/birthday.dart';

class BirthdayDB{
  List birthdayData = [];
  final Box birthdayBox = Hive.box("birthdays");

  void updateList(){
    birthdayData = birthdayBox.values.toList();
  }

  void putData(Birthday birthday){
    birthdayData.add(birthday);
    birthdayBox.add(birthday);
    updateList();
  }

  void clearBox(){
    birthdayBox.clear();
  }
}