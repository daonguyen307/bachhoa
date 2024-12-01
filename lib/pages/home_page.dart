import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:doan_tn/components/widget/product_card.dart';
import 'package:doan_tn/components/home/carousel_slider.dart';
import 'package:doan_tn/components/home/search_bar_text.dart';
import 'package:doan_tn/models/product_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  String _selectedCategory = 'Gợi ý';
  String _searchQuery = '';

  final List<String> categories = [
    'Gợi ý',
    'Thực phẩm',
    'Đồ uống',
    'Mỹ phẩm',
  ];

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  // Lấy danh sách sản phẩm từ Firestore
  Future<void> getProducts() async {
    db
        .collection('Product')
        .withConverter(
          fromFirestore: (snapshot, _) =>
              Product.fromMap(snapshot.data() ?? {}),
          toFirestore: (model, _) => model.toMap(),
        )
        .snapshots()
        .listen((event) {
      setState(() {
        _products = event.docs.map((e) => e.data()).toList();
        _filterProducts(); // Lọc sản phẩm ngay khi dữ liệu thay đổi
      });
    }).onError((e) {
      print('Error: $e');
    });
  }

  // Lọc sản phẩm theo danh mục
  // void _filterProducts() {
  //   setState(() {
  //     if (_selectedCategory == 'Gợi ý') {
  //       _filteredProducts = _products;
  //     } else {
  //       _filteredProducts = _products
  //           .where((product) =>
  //               product.category.toLowerCase() ==
  //               _selectedCategory.toLowerCase())
  //           .toList();
  //     }
  //   });
  // }

  void _filterProducts() {
  setState(() {
    _filteredProducts = _products.where((product) {
      final matchesCategory = _selectedCategory == 'Gợi ý' ||
          product.category.toLowerCase() == _selectedCategory.toLowerCase();
      final matchesSearch = product.title.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch; // Lọc theo cả danh mục và tìm kiếm
    }).toList();
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "SUPERMARKET",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SearchBarText(
                onSearchChanged: (value) {
                  setState(() {
                    _searchQuery = value; // Cập nhật giá trị tìm kiếm
                    _filterProducts(); // Gọi hàm lọc sản phẩm
                  });
                },
              ),
              const SizedBox(height: 10),
              CarouselSlider(
                currentSlide: 0,
                onChange: (value) {},
              ),
              const SizedBox(height: 10),
              // Nút danh mục
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCategory = category;
                          _filterProducts(); // Cập nhật danh sách hiển thị
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                          color: _selectedCategory == category
                              ? Colors.cyan.shade100
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            category,
                            style: TextStyle(
                              color: _selectedCategory == category
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              // Danh sách sản phẩm
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(10),
                itemCount: _filteredProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final product = _filteredProducts[index];
                  return ProductCard(product: product);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
