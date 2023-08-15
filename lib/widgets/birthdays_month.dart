import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:me_reminder/services/birthday_data.dart';
import 'package:me_reminder/models/birthday.dart';
import 'package:me_reminder/widgets/birthday_tile.dart';

class BirthdayMonth extends StatelessWidget {
  const BirthdayMonth({super.key, required this.month, required this.db});

  final String month;
  final BirthdayDB db;

  @override
  Widget build(BuildContext context) {
    final List<Birthday> _monthList = db.birthdayData.where((element) => DateFormat('MMMM').format(element.date) == month).toList();

    return Column(
      children: [
        Text(month, style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w400),),
        const SizedBox(height: 10,),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, mainAxisSpacing: 15, crossAxisSpacing: 15),
          itemCount: _monthList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => BirthdayTile(
            name: _monthList[index].name,
            day: _monthList[index].date.day.toString(),
            month: DateFormat('MMMM').format(
              _monthList[index].date,
            ),
          ),
        ),
        const SizedBox(height: 20,),
      ],
    );
  }
}
