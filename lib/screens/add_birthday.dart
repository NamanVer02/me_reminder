import 'package:awesome_notifications/awesome_notifications.dart';
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
  var _selectedTime = const Duration();
  var _uid;
  bool customTime = false;
  bool validName = false;

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

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
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
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
                            child: Form(
                              child: TextFormField(
                                validator: (text) {
                                  if (text == null || text.trim().isEmpty) {
                                    validName = false;
                                    return "Please enter a valid name";
                                  } else {
                                    validName = true;
                                  }
                                },
                                autovalidateMode: AutovalidateMode.always,
                                onChanged: (value) {
                                  _enteredName = value;
                                },
                                style: Theme.of(context).textTheme.titleMedium,
                                decoration: const InputDecoration(
                                  hintText: "Name",
                                ),
                              ),
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
            height: 20,
          ),
          SizedBox(
            height: 150,
            width: 300,
            child: CupertinoDatePicker(
              onDateTimeChanged: (date) {
                _selectedDate = date;
              },
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              maximumYear: DateTime.now().year,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 100,
            width: MediaQuery.of(context).size.width * 0.9,
            child: ListTile(
              leading: IconButton(
                onPressed: () {
                  setState(() {
                    customTime = !customTime;
                  });
                },
                icon: (customTime)
                    ? Icon(
                        Icons.check_box,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    : Icon(
                        Icons.check_box_outline_blank,
                        color: Theme.of(context).colorScheme.primary,
                      ),
              ),
              title: Text(
                "Custom Time",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.normal),
              ),
              trailing: CupertinoButton(
                child: const Text("Set Time"),
                onPressed: () => _showDialog(
                  CupertinoTimerPicker(
                    mode: CupertinoTimerPickerMode.hm,
                    initialTimerDuration: _selectedTime,
                    onTimerDurationChanged: (Duration newDuration) {
                      setState(() => _selectedTime = newDuration);
                    },
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
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
                      if (validName) {
                        BirthdayDB().putData(
                          Birthday(
                              name: _enteredName,
                              date: _selectedDate,
                              uid: _uid),
                        );

                        AwesomeNotifications().createNotification(
                          content: NotificationContent(
                            id: 0,
                            channelKey: "birthdayNotif",
                            title: "It is $_enteredName's Birthday today 🥳",
                          ),
                          schedule: NotificationCalendar(
                            repeats: true,
                            day: _selectedDate.day,
                            month: _selectedDate.month,
                            hour: (customTime)
                                ? _selectedTime.inHours.toInt()
                                : 0,
                            minute: (customTime)
                                ? _selectedTime.inMinutes.toInt() % 60
                                : 0,
                            second: 0,
                          ),
                        );
                        Navigator.popUntil(context, (route) => false);
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (ctx) => const HomeScreen()))
                            .then((value) => setState(() {}));
                      }
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
