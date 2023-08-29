import 'package:flutter/material.dart';

class BirthdayTile extends StatelessWidget {
  const BirthdayTile({super.key, required this.name, required this.day, required this.month});

  final String name;
  final String day;
  final String month;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary.withOpacity(0.8),
          ],
        ),
      ),
      height: MediaQuery.of(context).size.width * 0.25,
      width: MediaQuery.of(context).size.width * 0.25,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(name, style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.background), overflow: TextOverflow.ellipsis,),
            Text(day, style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.background),),
            Text(month, style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.background),)
          ],
        ),
      ),
    );
  }
}
