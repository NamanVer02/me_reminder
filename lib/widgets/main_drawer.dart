import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:me_reminder/services/birthday_data.dart';
import 'package:me_reminder/screens/add_birthday.dart';
import 'package:me_reminder/screens/all_birthdays.dart';
import 'package:random_avatar/random_avatar.dart';

class MainDrawer extends StatelessWidget {
  MainDrawer({super.key, required this.db});

  final BirthdayDB db;
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("lib/assets/images/drawer_banner.jpg"), fit: BoxFit.cover),
            ),
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
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w500),
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
                  builder: (ctx) => const AddBirthdayScreen(),
                ),
              );
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
            onTap: (){
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => AllBirthdaysScreen(db: db,)));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.delete_outline_outlined,
              color: Colors.black,
            ),
            title: Text(
              "Delete All Birthdays",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontSize: 18),
            ),
            onTap: (){
              showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text(
                  "Are you sure you want to delete all birthdays ?",
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
                      db.clearBox();
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
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
