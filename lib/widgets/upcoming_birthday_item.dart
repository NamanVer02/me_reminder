import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:me_reminder/screens/home.dart';
import 'package:me_reminder/services/birthday_data.dart';
import 'package:random_avatar/random_avatar.dart';

class UpcomingBirthdayItem extends StatefulWidget {
  const UpcomingBirthdayItem(
      {super.key,
      required this.name,
      required this.uid,
      required this.date,
      required this.db});

  final name;
  final uid;
  final DateTime date;
  final BirthdayDB db;

  @override
  State<UpcomingBirthdayItem> createState() => _UpcomingBirthdayItemState();
}

class _UpcomingBirthdayItemState extends State<UpcomingBirthdayItem> {
  int _calculateDifference() {
    var from =
        DateTime(DateTime.now().year, widget.date.month, widget.date.day);
    if (from.compareTo(DateTime.now()) < 0) {
      from =
          DateTime(DateTime.now().year + 1, widget.date.month, widget.date.day);
    }
    var difference = from.difference(DateTime.now()).inDays;
    return difference + 1;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 65,
        width: 55,
        decoration: BoxDecoration(
          //color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: RandomAvatar(widget.uid, trBackground: true),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.name,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.date.day.toString(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('MMMM').format(widget.date),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    "${_calculateDifference()} days remaining",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              )
            ],
          )
        ],
      ),
      trailing: IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text(
                  "Are you sure you want to delete this birthday ?",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 25),
                ),
                content: SizedBox(
                  child: Image.asset(
                    "lib/assets/images/delete.gif",
                    fit: BoxFit.cover,
                  ),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "No, take me back",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      )),
                  FilledButton(
                    onPressed: () {
                      widget.db.deleteBirthday(widget.uid);
                      Navigator.popUntil(context, (route) => false);
                      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const HomeScreen())).then((value) => setState((){}));
                    },
                    child: Text(
                      "Yes",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          },
          icon: const Icon(
            Icons.delete_forever,
            color: Colors.redAccent,
          )),
    );
  }
}
