import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:hive/hive.dart';

class UpcomingBirthdayItem extends StatefulWidget {
  const UpcomingBirthdayItem({super.key, required this.name, required this.uid, required this.date});

  final name;
  final uid;
  final DateTime date;

  @override
  State<UpcomingBirthdayItem> createState() => _UpcomingBirthdayItemState();
}

class _UpcomingBirthdayItemState extends State<UpcomingBirthdayItem> {
  int _calculateDifference(){
    var from = DateTime(DateTime.now().year, widget.date.month, widget.date.day);
    var difference = DateTime.now().difference(from).inDays;
    return difference;
  }
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 65,
        width: 55,
        decoration: BoxDecoration(
          color: Colors.amberAccent,
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
      trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
    );
  }
}
