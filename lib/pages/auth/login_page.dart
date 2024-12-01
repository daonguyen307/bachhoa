import 'package:doan_tn/components/home/td_button.dart';
import 'package:doan_tn/pages/home_page.dart';
import 'package:doan_tn/pages/auth/sign_in.dart';
import 'package:doan_tn/pages/auth/sign_up.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage("assets/images/background.jpg"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.7), BlendMode.darken),
            ),
          ),
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.fromLTRB(5, 120, 5, 20)),
              Image.asset(
                "assets/images/logo.png",
                height: 175,
              ),
              const SizedBox(height: 100),
              TdButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const SignUp()));
                },
                text: "SIGN UP",
              ),
              const SizedBox(height: 45),
              TdButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const SignIn()));
                },
                text: "SIGN IN",
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 30, right: 20),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const HomePage()));
                    },
                    child: const Text(
                      "Skip",
                      style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 26,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
            ],
          )
        ),
    );
  }
}
