import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerHeader(
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://avatars.githubusercontent.com/u/82778097?v=4"),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  FirebaseAuth.instance.currentUser!.email.toString().substring(0,8),
                  style: Theme.of(context).textTheme.titleMedium,
                )
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.add_circle_outline, color: Colors.black,),
            title: Text(
              "Add New",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontSize: 18
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.view_compact, color: Colors.black,),
            title: Text(
              "View All",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontSize: 18
              ),
            ),
          ),
        ],
      ),
    );
  }
}
