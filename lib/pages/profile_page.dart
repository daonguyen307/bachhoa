import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Biến lưu thông tin người dùng
  String fullName = "Loading...";
  String email = "Loading...";

  @override
  void initState() {
    super.initState();
    fetchUserData(); // Lấy thông tin khi màn hình được khởi tạo
  }

  // Hàm lấy dữ liệu từ Firestore
  Future<void> fetchUserData() async {
    try {
      // Lấy user hiện tại từ Firebase Auth
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        // Truy vấn dữ liệu trong Firestore (collection: users, document: UID)
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            // Gán dữ liệu từ Firestore vào các biến
            fullName = userDoc['fullName'] ?? "No Name";
            email = userDoc['email'] ?? "No Email";
          });
        }
      }
    } catch (e) {
      print("Error fetching user data: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error loading user data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("My Profile"),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            // Avatar
            CircleAvatar(
              radius: 50,
              backgroundImage: const AssetImage(
                  "assets/images/avatar.jpg"), // Thay bằng ảnh avatar nếu có
              backgroundColor: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            // Thông tin người dùng
            Center(
              child: Column(
                children: [
                  Text(
                    fullName, // Hiển thị tên người dùng
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    email, // Hiển thị email
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Nút chỉnh sửa hồ sơ
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Edit Profile Clicked')),
                );
              },
              icon: const Icon(Icons.edit),
              label: const Text("Edit Profile"),
            ),
            const SizedBox(height: 16),
            // Nút đăng xuất
            OutlinedButton.icon(
              onPressed: () async {
                await FirebaseAuth.instance.signOut(); // Đăng xuất
                Navigator.pop(context); // Quay lại màn hình trước
              },
              icon: const Icon(Icons.logout),
              label: const Text("Logout"),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
