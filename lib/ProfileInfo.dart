class Product {
  final String name;
  final String description;
  final int quantity;

  Product(this.name,this.description,this.quantity);

  factory Product.fromMap(Map<String, dynamic> json){
    return Product(
      json['id'],
      json['names'],
      json['phone']
    );
  }
}