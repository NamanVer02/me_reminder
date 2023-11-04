import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:me_reminder/screens/home.dart';
import 'package:me_reminder/services/birthday_data.dart';
import 'package:me_reminder/widgets/birthdays_month.dart';

class AllBirthdaysScreen extends StatefulWidget {
  const AllBirthdaysScreen({super.key, required this.db});

  final BirthdayDB db;

  @override
  State<AllBirthdaysScreen> createState() => _AllBirthdaysScreenState();
}

class _AllBirthdaysScreenState extends State<AllBirthdaysScreen> {
  @override
  Widget build(BuildContext context) {
    final monthList = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];

    widget.db.sortList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.popUntil(context, (route) => false);
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (ctx) => const HomeScreen()))
                .then((value) => setState(() {}));
          },
        ),
        title: const Text("All Birthdays"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for (var month in monthList)
                if (widget.db.birthdayData
                    .where((element) =>
                        DateFormat('MMMM').format(element.date) == month)
                    .toList()
                    .isNotEmpty)
                  BirthdayMonth(month: month, db: widget.db),
            ],
          ),
        ),
      ),
    );
  }
}
