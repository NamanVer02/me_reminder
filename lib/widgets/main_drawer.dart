import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:me_reminder/screens/add_birthday.dart';
import 'package:random_avatar/random_avatar.dart';

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
                CircleAvatar(
                  child: RandomAvatar(
                      FirebaseAuth.instance.currentUser!.uid.toString()),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  FirebaseAuth.instance.currentUser!.displayName.toString(),
                  style: Theme.of(context).textTheme.titleMedium,
                )
              ],
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.add_circle_outline,
              color: Colors.black,
            ),
            title: Text(
              "Add Birthday",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontSize: 18),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => const AddBirthdayScreen()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.view_compact,
              color: Colors.black,
            ),
            title: Text(
              "View All",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontSize: 18),
            ),
          ),
          const Expanded(child: SizedBox()),
          ListTile(
            leading: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            title: Text(
              "Delete Account",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.red, fontSize: 18),
            ),
            onTap: () {
              FirebaseAuth.instance.currentUser!.delete();
            },
          ),
        ],
      ),
    );
  }
}
