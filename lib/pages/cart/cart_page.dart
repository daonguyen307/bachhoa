// import 'package:doan_tn/pages/bottom_nav_bar.dart';
import 'package:doan_tn/pages/cart/check_out.dart';
import 'package:doan_tn/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final provider = CartProvider.of(context);
    final finalList = provider.cart;
    productQuantity(IconData icon, int index) {
      return GestureDetector(onTap: () {
        setState(() {
          icon == Icons.add
              ? provider.incrementQtn(index)
              : provider.decrementQtn(index);
        });
      },
      child: Icon(icon, size: 20),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("My Cart"),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        //iconTheme: const IconThemeData(color: Colors.black),
      ),

      body: SafeArea(
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(8),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       IconButton(
            //         style: IconButton.styleFrom(
            //           backgroundColor: Colors.blueGrey.shade50,
            //           padding: const EdgeInsets.all(15),
            //         ),
            //         onPressed: () {
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) => const BottomNavBar()),
            //           );
            //         },
            //         icon: const Icon(Icons.arrow_back_ios),
            //       ),
            //       const Text(
            //         "My Cart",
            //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            //       ),
            //       Container(),
            //     ],
            //   ),
            // ),
            Expanded(
              child: ListView.builder(
                  itemCount: finalList.length,
                  itemBuilder: (context, index) {
                    final cartItems = finalList[index];
                    return Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              children: [
                                Container(
                                  height: 100,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  padding: const EdgeInsets.all(0),
                                  child: Image.network(cartItems.image),
                                ),
                                const SizedBox(width: 5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cartItems.title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      cartItems.category,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.black),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      NumberFormat.currency(
                                              locale: 'vi_VN', symbol: '₫')
                                          .format(cartItems.price),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 35,
                          right: 35,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  finalList.removeAt(index);
                                  setState(() {});
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 22,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Row(
                                  children: [
                                    const SizedBox(width: 10),
                                    productQuantity(Icons.add, index),
                                    const SizedBox(width: 10),
                                    Text(
                                      cartItems.quantity.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    productQuantity(Icons.remove, index),
                                    const SizedBox(width: 10),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
            ),
            CheckOut(),
          ],
        ),
      ),
    );
  }
}
