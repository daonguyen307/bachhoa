import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_tn/pages/bottom_nav_bar.dart';
import 'package:doan_tn/pages/auth/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:doan_tn/components/home/td_textfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

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
        backgroundColor: Colors.white,
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
                    "Create Account",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  TdTextField(
                    label: 'Full Name',
                    icon: const Icon(Icons.person),
                    controller: _nameController,
                  ),
                  const SizedBox(height: 15),
                  TdTextField(
                    label: 'Email',
                    icon: const Icon(Icons.email_outlined),
                    controller: _emailController,
                  ),
                  const SizedBox(height: 15),
                  TdTextField(
                    label: 'Password',
                    secureText: true,
                    icon: const Icon(Icons.password),
                    controller: _passwordController,
                  ),
                  const SizedBox(height: 15),
                  TdTextField(
                    label: 'Confirm Password',
                    secureText: true,
                    icon: const Icon(Icons.lock),
                    controller: _confirmPasswordController,
                  ),
                  const SizedBox(height: 40),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            // Tạo tài khoản bằng email và password
                            UserCredential userCredential = await FirebaseAuth
                                .instance
                                .createUserWithEmailAndPassword(
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim(),
                            );

                            // Lấy UID của người dùng mới
                            String uid = userCredential.user!.uid;

                            // Lưu thông tin người dùng vào Firestore
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(uid)
                                .set({
                              'fullName': _nameController.text.trim(),
                              'email': _emailController.text.trim(),
                              'password': _passwordController.text,
                              'createdAt': FieldValue
                                  .serverTimestamp(), // Lưu thời gian tạo
                            });

                            // Điều hướng đến trang chính (BottomNavBar)
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const BottomNavBar(),
                              ),
                            );
                          } catch (e) {
                            // Hiển thị lỗi nếu có
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: $e')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal.shade100,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            )),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('SIGN UP',style: TextStyle(color: Colors.black),),
                            SizedBox(width: 5),
                            Icon(Icons.arrow_forward, size: 24.0, color: Colors.black,),
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
                "Already have an account ?",
                style: TextStyle(
                    fontFamily: 'SFUIDisplay',
                    color: Colors.black,
                    fontSize: 15),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const SignIn()));
                },
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    fontFamily: 'SFUIDisplay',
                    color: Colors.teal.shade100,
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

