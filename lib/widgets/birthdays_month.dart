import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:intl/intl.dart';
import 'package:me_reminder/services/birthday_data.dart';
import 'package:me_reminder/models/birthday.dart';
import 'package:me_reminder/widgets/birthday_tile.dart';

class BirthdayMonth extends StatefulWidget {
  const BirthdayMonth({super.key, required this.month, required this.db});

  final String month;
  final BirthdayDB db;

  @override
  State<BirthdayMonth> createState() => _BirthdayMonthState();
}

class _BirthdayMonthState extends State<BirthdayMonth> {
  @override
  Widget build(BuildContext context) {
    final List<Birthday> _monthList = widget.db.birthdayData
        .where((element) => DateFormat('MMMM').format(element.date) == widget.month)
        .toList();

    return Column(
      children: [
        Text(
          widget.month,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 10,
        ),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, mainAxisSpacing: 15, crossAxisSpacing: 15),
          itemCount: _monthList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => FocusedMenuHolder(
            blurBackgroundColor: Colors.black,
            menuWidth: MediaQuery.of(context).size.width * 0.25,
            menuOffset: 10,
            onPressed: () {},
            menuItems: [
              FocusedMenuItem(
                title: const Text("Delete"),
                onPressed: () {
                  setState(() {
                    widget.db.deleteBirthday(_monthList[index].uid);
                    
                  });
                },
                trailingIcon: const Icon(Icons.delete, color: Colors.red, size: Checkbox.width,),
              )
            ],
            child: BirthdayTile(
              name: _monthList[index].name,
              day: _monthList[index].date.day.toString(),
              month: DateFormat('MMMM').format(
                _monthList[index].date,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
