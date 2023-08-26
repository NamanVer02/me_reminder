import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:me_reminder/services/birthday_data.dart';
import 'package:me_reminder/models/birthday.dart';
import 'package:me_reminder/widgets/main_card.dart';
import 'package:me_reminder/widgets/main_drawer.dart';
import 'package:me_reminder/widgets/upcoming_birthday_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DateTime today = DateTime.now();
  final DateFormat formatter = DateFormat('d MMMM, y');
  final BirthdayDB db = BirthdayDB();
  final List<Birthday> todayBirthday = [];
  final List<Birthday> upcomingBirthday = [];

  void initLists() {
    db.sortList();
    for (var item in db.birthdayData) {
      if (item.date.day == DateTime.now().day &&
          item.date.month == DateTime.now().month) {
        todayBirthday.add(item);
      }

      int calculateDifference() {
        var from =
            DateTime(DateTime.now().year, item.date.month, item.date.day);
        if (from.compareTo(DateTime.now()) < 0) {
          from =
              DateTime(DateTime.now().year + 1, item.date.month, item.date.day);
        }
        var difference = from.difference(DateTime.now()).inDays;
        return difference;
      }

      if (calculateDifference() < 30) {
        upcomingBirthday.add(item);
      }
    }
  }

  @override
  void initState() {
    db.updateList();
    initLists();

    AwesomeNotifications().isNotificationAllowed().then((permission) {
      if (!permission) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      drawer: MainDrawer(
        db: db,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 30),
            child: Text(
              formatter.format(today),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: SizedBox(
              height: 180,
              child: ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: todayBirthday.length,
                itemBuilder: (context, index) => MainCard(
                  name: todayBirthday[index].name.toString().toUpperCase(),
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  width: 10,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 30,
            ),
            child: Text(
              "Upcoming Birthdays",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: ListView.separated(
                  itemCount: upcomingBirthday.length,
                  itemBuilder: (context, index) => UpcomingBirthdayItem(
                    name: upcomingBirthday[index].name,
                    date: upcomingBirthday[index].date,
                    uid: upcomingBirthday[index].uid,
                    db: db,
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
