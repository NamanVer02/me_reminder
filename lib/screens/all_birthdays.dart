import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:me_reminder/services/birthday_data.dart';
import 'package:me_reminder/widgets/birthdays_month.dart';


class AllBirthdaysScreen extends StatelessWidget {
  const AllBirthdaysScreen({super.key, required this.db});

  final BirthdayDB db;

  @override
  Widget build(BuildContext context) {
    final monthList = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
    
    db.sortList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("All Birthdays"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for(var month in monthList)
                if(db.birthdayData.where((element) => DateFormat('MMMM').format(element.date) == month).toList().isNotEmpty)
                  BirthdayMonth(month: month, db: db),
            ],
          ),
        ),
      ), 
    );
  }
}
