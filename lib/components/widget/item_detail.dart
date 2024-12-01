import 'package:doan_tn/models/product_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemDetail extends StatelessWidget {
  final Product product;
  const ItemDetail({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.title,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 25,
          ),
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(product.price),
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      width: 55,
                      height: 25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 14,
                            color: Colors.yellow,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            product.review.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          )
                        ],
                      ),
                    ),
                   const SizedBox(width: 5),
                   Text(
                    product.seller,
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 15,
                    ),
                   )
                  ],
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
