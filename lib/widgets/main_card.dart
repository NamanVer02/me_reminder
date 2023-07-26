import 'package:flutter/material.dart';

class MainCard extends StatelessWidget {
  const MainCard({super.key, required this.name});

  final name;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      width: 320,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        clipBehavior: Clip.hardEdge,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromRGBO(156, 113, 198, 1),
              Color.fromRGBO(93, 46, 138, 1)
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Today's Birthday",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                    ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                name,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.white,
                    ),
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ),
    );
  }
}
