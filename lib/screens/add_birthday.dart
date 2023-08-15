import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:me_reminder/services/birthday_data.dart';
import 'package:me_reminder/models/birthday.dart';
import 'package:me_reminder/screens/home.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:uuid/uuid.dart';

class AddBirthdayScreen extends StatefulWidget {
  const AddBirthdayScreen({super.key});

  @override
  State<AddBirthdayScreen> createState() => _AddBirthdayScreenState();
}

class _AddBirthdayScreenState extends State<AddBirthdayScreen> {
  var _enteredName;
  var _selectedDate = DateTime.now();
  var _uid;

  @override
  void initState() { 
    _uid = const Uuid().v4();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SizedBox(
            child: Stack(
              children: [
                Image.asset("lib/assets/images/blob1.png"),
                Padding(
                  padding: const EdgeInsets.only(top: 60, left: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Add Birthday",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 150,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 65,
                                width: 65,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primaryContainer,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: RandomAvatar(_uid, trBackground: true),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    _uid = const Uuid().v4();
                                  });
                                },
                                icon: const Icon(Icons.replay_outlined),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            width: 180,
                            child: TextFormField(
                              onChanged: (value){_enteredName = value;},
                              style: Theme.of(context).textTheme.titleMedium,
                              decoration:
                                  const InputDecoration(hintText: "Name",),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset("lib/assets/images/add_birthday.png"),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            height: 200,
            width: 300,
            child: CupertinoDatePicker(
              onDateTimeChanged: (date) {_selectedDate = date;},
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              maximumYear: DateTime.now().year,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Cancel",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 100,
                  height: 40,
                  child: FilledButton(
                    onPressed: () {
                      BirthdayDB().putData(Birthday(name: _enteredName, date: _selectedDate, uid: _uid));
                      Navigator.popUntil(context, (route) => false);
                      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const HomeScreen())).then((value) => setState((){}));
                    },
                    child: Text(
                      "Add",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
