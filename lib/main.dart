import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:me_reminder/models/birthday.dart';
import 'package:me_reminder/screens/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:me_reminder/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Hive.initFlutter();
  Hive.registerAdapter(BirthdayAdapter());
  var box = await Hive.openBox("birthdays");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme:
        ColorScheme.fromSeed(seedColor: const Color.fromRGBO(227, 108, 11, 1))
            .copyWith(
                primary: const Color.fromRGBO(227, 108, 11, 1),
                primaryContainer: const Color.fromARGB(150, 227, 108, 11)),
    listTileTheme: const ListTileThemeData().copyWith(minLeadingWidth: 20),
    textTheme: GoogleFonts.nunitoTextTheme().copyWith(
      titleLarge: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: const TextStyle(
        fontSize: 15,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshot) {
          if(snapshot.hasData){
            return const HomeScreen();
          }
          else{
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
