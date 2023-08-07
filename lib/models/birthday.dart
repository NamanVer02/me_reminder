import 'package:hive/hive.dart';

part 'birthday.g.dart';

@HiveType(typeId: 0)
class Birthday extends HiveObject{
  Birthday({required this.name, required this.date, required this.uid});

  @HiveField(0)
  var name;

  @HiveField(1)
  DateTime date;

  @HiveField(2)
  var uid;
}