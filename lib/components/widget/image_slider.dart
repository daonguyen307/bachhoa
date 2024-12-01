//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatelessWidget {
  final Function(int) onChange;
  final String image;
  const ImageSlider({super.key, required this.onChange, required this.image});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: PageView.builder(
        onPageChanged: onChange,
        itemBuilder: (context, index) {
          return Hero(
            tag: image,
            child: Image.network(image)
          );
        },
      ),
    );
  }
}
