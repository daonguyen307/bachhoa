import 'package:flutter/material.dart';

class SearchBarText extends StatelessWidget {
  final ValueChanged<String> onSearchChanged;
  const SearchBarText({super.key, required this.onSearchChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.cyan.shade100,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 25, 
        vertical: 5
      ),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            color: Colors.black,
            size: 30,
          ),
          const SizedBox(width: 10),
          Flexible(
            flex: 4,
            child: TextField(
              onChanged: onSearchChanged, // Gửi giá trị mỗi khi thay đổi
              decoration: const InputDecoration(
                hintText: "Tìm kiếm sản phẩm",
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            height: 25,
            width: 1.5,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
