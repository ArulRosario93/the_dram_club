import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:the_dram_club/Controller/authentication.dart';
import 'package:the_dram_club/Pages/Channel/ChannelChat/ChatController/ChatControllerParent/chat_controller_parent.dart';
import 'package:the_dram_club/Pages/Channel/ChannelChat/ChatController/chat_controller.dart';
import 'package:the_dram_club/Pages/Channel/channel.dart';
import 'package:the_dram_club/Pages/GetStarted/get_started.dart';
import 'package:the_dram_club/Pages/Home/home.dart';
import 'firebase_options.dart';

void main() async {
  await dotenv.load(
    fileName: ".env",
  );
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
      home: Authentication(),
    );
  }
}
