import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:me_reminder/widgets/main_card.dart';
import 'package:me_reminder/widgets/main_drawer.dart';
import 'package:me_reminder/widgets/upcoming_birthday_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final DateTime today = DateTime.now();
    final DateFormat formatter = DateFormat('d MMMM, y');

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
            icon: const Icon(Icons.exit_to_app)),
        ],
      ),
      drawer: const MainDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              formatter.format(today),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 180,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) =>
                    MainCard(name: "Mike Williams".toUpperCase()),
                separatorBuilder: (context, index) => const SizedBox(
                  width: 10,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Upcoming Birthdays",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: SizedBox(
                height: 400,
                child: ListView.separated(
                  itemCount: 10,
                  itemBuilder: (context, index) => UpcomingBirthdayItem(temp: index.toString()),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
