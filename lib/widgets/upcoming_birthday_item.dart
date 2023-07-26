import 'package:flutter/material.dart';

class UpcomingBirthdayItem extends StatelessWidget {
  const UpcomingBirthdayItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 65,
        width: 55,
        decoration: BoxDecoration(
            color: Colors.amberAccent, borderRadius: BorderRadius.circular(12)),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Lia Chen",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("27", style: Theme.of(context).textTheme.titleLarge,),
              const SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("August", style: Theme.of(context).textTheme.titleSmall,),
                  Text("3 days remaining", style: Theme.of(context).textTheme.titleSmall,),
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