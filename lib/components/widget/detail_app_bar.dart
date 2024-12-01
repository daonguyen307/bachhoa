import 'package:doan_tn/provider/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:doan_tn/models/product_item.dart';


class DetailAppBar extends StatelessWidget {
  final Product product;
  const DetailAppBar({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          IconButton(
            style: IconButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.all(15)),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          const Spacer(),
          IconButton(
            style: IconButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.all(15)),
            onPressed: () {},
            icon: const Icon(Icons.share_outlined),
          ),
          const SizedBox(width: 5),
          IconButton(
            style: IconButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.all(15)),
            onPressed: () {
              provider.toggleFavorite(product);
            },
            icon: Icon(
              provider.isExit(product) 
                ? Icons.favorite 
                : Icons.favorite_border,
              color: Colors.black,
              size: 25,
            ),
          ),
        ],
      ),
    );
  }
}
