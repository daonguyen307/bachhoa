import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:doan_tn/models/product_item.dart';
import 'package:doan_tn/provider/cart_provider.dart';

class CheckOut extends StatelessWidget {
  CheckOut({super.key});

  // Tạo TextEditingController để theo dõi giá trị địa chỉ
  final TextEditingController _addressController = TextEditingController();

  Future<void> saveOrderToFirestore(
      BuildContext context, List<Product> cart, String address) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Bạn chưa đăng nhập!")),
      );
      return;
    }

    if (address.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vui lòng nhập địa chỉ giao hàng!")),
      );
      return;
    }

    try {
      // Lấy UID của người dùng hiện tại
      final String userId = currentUser.uid;

      // Chuyển đổi danh sách giỏ hàng thành danh sách map
      List<Map<String, dynamic>> orderItems = cart.map((item) {
        return {
          'title': item.title,
          'category': item.category,
          'price': item.price,
          'quantity': item.quantity,
          'image': item.image,
        };
      }).toList();

      // Lưu thông tin đơn hàng vào Firestore
      await firestore.collection('orders').add({
        'userId': userId, // ID của người dùng
        'orderItems': orderItems,
        'totalPrice': cart.fold(
            0.0, (sum, item) => sum + (item.price * item.quantity)),
        'orderDate': FieldValue.serverTimestamp(), // Thời gian tạo đơn hàng
        'shippingAddress': address, // Địa chỉ giao hàng
      });

      // Hiển thị thông báo thành công
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Đơn hàng đã được lưu thành công!")),
      );

      // Xoá giỏ hàng sau khi hoàn thành
      // CartProvider.of(context).clearCart();
    } catch (e) {
      print("Error saving order: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Có lỗi xảy ra khi lưu đơn hàng!")),
      );
    }
  }

  Future<void> saveAddressToFirestore(BuildContext context, String address) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Bạn chưa đăng nhập!")),
      );
      return;
    }

    if (address.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vui lòng nhập địa chỉ giao hàng!")),
      );
      return;
    }

    try {
      final String userId = currentUser.uid;

      // Lưu địa chỉ vào Firestore
      await firestore.collection('users').doc(userId).set({
        'address': address,
      }, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Địa chỉ đã được lưu!")),
      );
    } catch (e) {
      print("Error saving address: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Có lỗi xảy ra khi lưu địa chỉ!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = CartProvider.of(context);
    final cartItems = provider.cart;

    return Container(
      height: 300,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _addressController, // Gắn controller vào TextField
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 15,
              ),
              filled: true,
              fillColor: Colors.orange.shade100,
              hintText: "Địa chỉ giao hàng",
              hintStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
              suffixIcon: TextButton(
                onPressed: () async {
                  // Gọi hàm lưu địa chỉ
                  await saveAddressToFirestore(context, _addressController.text);
                },
                child: const Text(
                  "Save",
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Subtotal",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              Text(
                NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                    .format(provider.totalPrice()),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                    .format(provider.totalPrice()),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              await saveOrderToFirestore(
                context,
                cartItems,
                _addressController.text, // Truyền địa chỉ vào khi lưu đơn hàng
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade100,
              minimumSize: const Size(double.infinity, 55),
            ),
            child: const Text(
              "Check out",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
