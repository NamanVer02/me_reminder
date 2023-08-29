import 'package:hive/hive.dart';
import 'package:me_reminder/models/birthday.dart';

class BirthdayDB {
  List<Birthday> birthdayData = [];
  final Box birthdayBox = Hive.box("birthdays");

  void updateList() {
    birthdayData = List<Birthday>.from(birthdayBox.values);
  }

  void putData(Birthday birthday) {
    birthdayData.add(birthday);
    birthdayBox.add(birthday);
  }

  void clearBox() {
    birthdayBox.clear();
    birthdayData.clear();
  }

  void sortList() {
    for(int i = 0; i < birthdayData.length; i++){
      for(int j = 0; j < birthdayData.length-1; j++){
        if(birthdayData[j].date.month > birthdayData[j+1].date.month){
          var temp = birthdayData[j];
          birthdayData[j] = birthdayData[j+1];
          birthdayData[j+1] = temp;
        }
        else if(birthdayData[j].date.month == birthdayData[j+1].date.month){
          if(birthdayData[j].date.day > birthdayData[j+1].date.day){
            var temp = birthdayData[j];
            birthdayData[j] = birthdayData[j+1];
            birthdayData[j+1] = temp;
          }
        }
      }
    }
  }

  void deleteBirthday(var uid)async{
    for(var birthday in birthdayData){
      if(birthday.uid == uid){
        birthdayData.remove(birthday);
        await birthdayBox.delete(birthday.key);
        break;
      }
    }
  }
}
