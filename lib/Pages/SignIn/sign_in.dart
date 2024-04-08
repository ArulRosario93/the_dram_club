import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_dram_club/Auth_services/auth_services.dart';
import 'package:the_dram_club/Pages/Home/home.dart';
import 'package:the_dram_club/Utils/get_info.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailAdress = TextEditingController();
    final TextEditingController password = TextEditingController();

    void handleNavigatetoSignUp() {
      Navigator.pop(context);
    }

    void showSnackbar(String text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(text, style: GoogleFonts.montserrat(),),
          duration: const Duration(seconds: 2),
        ),
      );
    }

    void handleSignIn() async {
      if (emailAdress.text.isEmpty || password.text.isEmpty) {
        showSnackbar("Please fill all the fields");
        return;
      }

      // if (await AuthServices().userExist(emailAdress.text) == false) {
      //   showSnackbar("User does not exist");
      //   return;
      // }

      await AuthServices()
          .signInWithEmailAndPassword(emailAdress.text, password.text)
          .then((value) {
        if (value == "SUCCESS") {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Sign in failed: $value"),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      });
    }

    void hangleGSignIn() async {
      String res = await AuthServices().signInWithGoogle();

      if (res == "SUCCESS") {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      } else {
        // snackbar to show the error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sign in failed: $res'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: false,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.white,
                Colors.white70,
                Colors.white54,
                Colors.white24,
              ]),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome Back!",
                style: GoogleFonts.montserrat(
                    fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Text(
                "Login in your account",
                style: GoogleFonts.montserrat(
                    fontSize: 18, fontWeight: FontWeight.w500),
              ),
              // const SizedBox(height: 20),

              const SizedBox(height: 20),
              GetInfo(
                maxLines: false,
                controller: emailAdress,
                autoFocus: true,
                hintText: "Email Address",
              ),
              const SizedBox(height: 10),
              GetInfo(
                maxLines: false,
                autoFocus: false,
                controller: password,
                hintText: "Password",
              ),
              const SizedBox(height: 10),
              Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?",
                          style: GoogleFonts.montserrat(
                              fontSize: 12, fontWeight: FontWeight.w500)),
                      TextButton(
                          onPressed: handleNavigatetoSignUp,
                          child: Text("Sign Up",
                              style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      const Color.fromARGB(255, 75, 62, 252))))
                    ],
                  )),
              GestureDetector(
                onTap: handleSignIn,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 75, 62, 252),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Text(
                    "Sign In",
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: hangleGSignIn,
                child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(
                              "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/768px-Google_%22G%22_logo.svg.png"),
                          radius: 15,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Sign In with Google",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: const Color.fromARGB(255, 75, 62, 252)),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
