import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:the_dram_club/Pages/Channel/channel.dart';
import 'package:the_dram_club/Pages/Home/home.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const Dram());
}

class Dram extends StatelessWidget {
  const Dram({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      
      home: Channel(),
    );
  }
}
