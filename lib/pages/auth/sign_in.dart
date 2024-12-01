import 'package:doan_tn/pages/bottom_nav_bar.dart';
import 'package:doan_tn/pages/forgot_password.dart';
import 'package:doan_tn/pages/auth/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _passwordAddressController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance; // Đối tượng FirebaseAuth

  // Hàm đăng nhập
  Future<void> _signIn() async {
    try {
      // Lấy thông tin tài khoản và mật khẩu từ các trường nhập liệu
      String email = _emailAddressController.text.trim();
      String password = _passwordAddressController.text.trim();

      // Đăng nhập với Firebase
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Kiểm tra đăng nhập thành công và chuyển sang trang BottomNavBar
      if (userCredential.user != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const BottomNavBar()),
        );
      }
    } catch (e) {
      // Hiển thị thông báo lỗi nếu có
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Đăng nhập không thành công'),
      ));
    }
  }

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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 110, 20, 110),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Login',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Please sign in to continue',
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _emailAddressController,
                  style: const TextStyle(
                      color: Colors.black, fontFamily: 'SFUIDisplay'),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
                    labelStyle: TextStyle(fontSize: 12),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _passwordAddressController,
                  obscureText: true,
                  style: const TextStyle(
                      color: Colors.black, fontFamily: 'SFUIDisplay'),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ForgotPassword()));
                      },
                      child: Text(
                        'FORGOT',
                        style: TextStyle(color: Colors.teal.shade100),
                      ),
                    ),
                    labelStyle: const TextStyle(fontSize: 12),
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                        onPressed: _signIn, // Gọi hàm đăng nhập
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal.shade100,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0))),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Login'),
                            SizedBox(width: 5),
                            Icon(Icons.arrow_forward, size: 24.0)
                          ],
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Don't have an account ?",
                style: TextStyle(
                    fontFamily: "SFUIDisplay",
                    color: Colors.black,
                    fontSize: 15),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SignUp()));
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                        fontFamily: "SFUIDisplay",
                        color: Colors.teal.shade100,
                        fontSize: 15),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
