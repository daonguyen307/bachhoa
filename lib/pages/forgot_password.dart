//import 'package:doan_tn/pages/home_page.dart';
import 'package:doan_tn/pages/auth/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:doan_tn/components/home/td_textfield.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _emailController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            leading: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 110, 20, 110),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Forgot Password",
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 30),
                    TdTextField(
                      label: 'Email',
                      icon: const Icon(Icons.email_outlined),
                      controller: _emailController,
                    ),
                    const SizedBox(height: 40),
                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            FirebaseAuth.instance
                                .sendPasswordResetEmail(
                                    email: _emailController.text,)
                                .then((value) => {
                                      Navigator.of(context).pop(),
                                    });
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              )),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Reset'),
                              SizedBox(width: 5),
                              Icon(Icons.arrow_forward, size: 24.0)
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
        ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Know Password ?",
              style: TextStyle(
                  fontFamily: 'SFUIDisplay', color: Colors.black, fontSize: 15),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => const SignIn()));
              },
              child: const Text(
                'Sign In',
                style: TextStyle(
                  fontFamily: 'SFUIDisplay',
                  color: Colors.green,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
  }
}
