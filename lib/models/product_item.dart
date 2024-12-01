class Product {
  final String id; // Nếu cần lưu ID Firestore của sản phẩm
  final String title;
  final String description;
  final String image;
  final String review;
  final String seller;
  final double price;
  final String category;
  int _quantity;

  Product({
    this.id = '', // Giá trị mặc định rỗng cho id nếu không cần
    required this.title,
    required this.description,
    required this.image,
    required this.review,
    required this.seller,
    required this.price,
    required this.category,
    int quantity = 1, // Đặt giá trị mặc định là 1
  }) : _quantity = quantity;

  // Getter cho quantity
  int get quantity => _quantity;

  // Setter cho quantity để đảm bảo quantity không âm
  set quantity(int newQuantity) {
    if (newQuantity >= 0) {
      _quantity = newQuantity;
    }
  }

  // Chuyển đổi từ Firestore document (Map) sang Product
  factory Product.fromMap(Map<String, dynamic> map, {String? id}) {
    return Product(
      id: id ?? '', // Dùng ID truyền vào nếu có
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      image: map['image'] ?? '',
      review: map['review'] ?? '',
      seller: map['seller'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      category: map['category'] ?? '',
      quantity: map['quantitys'] ?? 1,
    );
  }

  // Chuyển đổi từ Product sang Map để lưu vào Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'image': image,
      'review': review,
      'seller': seller,
      'price': price,
      'category': category,
      'quantity': _quantity,
    };
  }
}

