import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:the_dram_club/Pages/SignUp/sign_up.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    void handleNavigatetoSignUp() {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SignUp(),
          ));
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
              decoration: const BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Color.fromARGB(255, 0, 255, 221), Colors.blue, Colors.purple]),
              ),
              child: Column(
      children: [
        // Container(),
        Flexible(
            flex: 6,
            child: Container(
              alignment: Alignment.center,
              child: Lottie.asset("assets/Lottie/workingLottie.json",
                  fit: BoxFit.fitWidth,
                  height: double.infinity,
                  repeat: false),
            )),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Let's Get Started",
                textAlign: TextAlign.left,
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                    color: Colors.white),
              ),
              Text(
                "Explore the world of Dram Club with us!",
                textAlign: TextAlign.left,
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: Colors.white),
              ),
              Text(
                "The Dram Club is a community",
                textAlign: TextAlign.left,
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: Colors.white),
              ),
            ],
          ),
        ),
        Flexible(flex: 1, child: Container()),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          margin: const EdgeInsets.all(40),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: InkWell(
            onTap: handleNavigatetoSignUp,
            child: Text(
              "Get Started",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                  color: const Color.fromARGB(255, 75, 62, 252),
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ),
        )
      ],
              ),
            ),
    );
  }
}
