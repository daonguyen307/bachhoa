import 'package:doan_tn/components/widget/description.dart';
import 'package:doan_tn/components/widget/detail_app_bar.dart';
import 'package:doan_tn/components/widget/image_slider.dart';
import 'package:doan_tn/components/widget/item_detail.dart';
import 'package:doan_tn/models/product_item.dart';
import 'package:doan_tn/components/widget/add_cart_button.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final Product product;
  const DetailPage({super.key, required this.product});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int currentImage = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AddCartButton(product: widget.product),
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailAppBar(product: widget.product),
            ImageSlider(
              image: widget.product.image,
              onChange: (index) {
                setState(() {
                  currentImage = index;
                });
              },
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => AnimatedContainer(
                  duration: const Duration(microseconds: 300),
                  width: currentImage == index ? 15 : 8,
                  height: 0,
                  margin: const EdgeInsets.only(right: 3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: currentImage == index
                          ? Colors.black
                          : Colors.transparent,
                      border: Border.all(
                        color: Colors.black,
                      )),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade100,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
              ),
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: 100,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ItemDetail(product: widget.product),
                  const SizedBox(height: 20),
                  Description(
                    description: widget.product.description,
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
