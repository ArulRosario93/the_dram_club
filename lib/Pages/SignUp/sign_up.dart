import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_dram_club/Auth_services/auth_services.dart';
import 'package:the_dram_club/Pages/Home/home.dart';
import 'package:the_dram_club/Pages/SignIn/sign_in.dart';
import 'package:the_dram_club/Utils/get_info.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailAdress = TextEditingController();
    final TextEditingController password = TextEditingController();
    final TextEditingController confirmPassword = TextEditingController();

    void showsnackbar(String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: Text(
            message,
            style: GoogleFonts.montserrat(),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }

    bool handleCheckvalidEmail(String email) {
      if (RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email)) {
        return true;
      }

      return false;
    }

    Future<bool> handleUserExits(String email) {
      return AuthServices().userExist(email);
    }

    void handleSignUnEmailandPass() async {
      if (password.text.isEmpty ||
          emailAdress.text.isEmpty ||
          confirmPassword.text.isEmpty) {
        showsnackbar("Please fill all the fields");
        return;
      }

      if (!handleCheckvalidEmail(emailAdress.text)) {
        showsnackbar("Please enter a valid email address");
        return;
      }

      if (await handleUserExits(emailAdress.text)) {
        String res = await AuthServices().userAuthentication(emailAdress.text);
        showsnackbar("User already exists. Try Signing in with $res");
        return;
      }

      if (password.text != confirmPassword.text) {
        showsnackbar("Password does not match");
        return;
      }

      if (password.text.length < 8) {
        showsnackbar("Password must be atleast 8 characters long");
        return;
      }

      String res = await AuthServices()
          .signUpWithEmailAndPassword(emailAdress.text.trim(), password.text);
      if (res == "SUCCESS") {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sign in failed: $res'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }

    void handleNavigatetoSignIn() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const SignIn()));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          // color: Colors.black12
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
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Let's Get Started",
              style: GoogleFonts.montserrat(
                  fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Text(
              "Create your own account",
              style: GoogleFonts.montserrat(
                  fontSize: 18, fontWeight: FontWeight.w500),
            ),
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
              controller: password,
              hintText: "Password",
              autoFocus: false,
            ),
            const SizedBox(height: 10),
            GetInfo(
              maxLines: false,
              controller: confirmPassword,
              hintText: "Confirm Password",
              autoFocus: false,
            ),
            const SizedBox(height: 10),
            Text("Agree to privacy policy and terms",
                style: GoogleFonts.montserrat(
                    fontSize: 12, fontWeight: FontWeight.w500)),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: handleSignUnEmailandPass,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 75, 62, 252),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Text(
                  "Get Started",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
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
                      foregroundColor: Colors.white,
                      backgroundImage: NetworkImage(
                          "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/768px-Google_%22G%22_logo.svg.png"),
                      radius: 15,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Sign Up with Google",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: const Color.fromARGB(255, 75, 62, 252)),
                    ),
                  ],
                )),
            Expanded(
              child: Container(),
            ),
            Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? ",
                        style: GoogleFonts.montserrat(
                            fontSize: 12, fontWeight: FontWeight.w500)),
                    TextButton(
                      onPressed: handleNavigatetoSignIn,
                      child: Text("Sign In",
                          style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromARGB(255, 75, 62, 252))),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
