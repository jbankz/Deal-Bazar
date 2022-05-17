class AmazonProduct {
  String? title;
  String? price;
  String? discount;
  String? discountedPrice;
  String? brand;
  String? reviews;
  String? description;
  String? imageUrl;
  String? shippingFirm;
  String? seller;
  String? delieveryDate;
  List<String> colors = [];

  AmazonProduct({
    required this.colors,
    this.brand,
    this.delieveryDate,
    this.discount,
    this.discountedPrice,
    this.imageUrl,
    this.description,
    this.price,
    this.reviews,
    this.seller,
    this.shippingFirm,
    this.title,
  });
}
