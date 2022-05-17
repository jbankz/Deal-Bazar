import 'package:deal_bazaar/core/utils/images.dart';

class ProductModel {
  String? title;
  String? price;
  String? discount;
  String? discountedPrice;
  int? customerReviewCount;
  String? brand;
  String? reviews;
  String? description;
  List<dynamic>? images;
  String? productUrl;
  String? imageUrl;
  int? quantity;
  bool? isAvailable;
  String? mainImage;
  String? shippingFirm;
  String? seller;
  String? originalPrice;
  String? delieveryDate;
  List<dynamic>? productInfo;
  List<dynamic>? delieveryMessages;

  String? productWeight;
  String? productDimensions;

  String? dimensionalWeight;

  String? finalWeight;

  double? shippingCost;
  String? id;
  ProductModel({
    this.brand,
    this.title,
    this.delieveryDate,
    this.mainImage,
    this.quantity,
    this.discount,
    this.discountedPrice,
    this.originalPrice,
    this.delieveryMessages,
    this.productWeight,
    this.productDimensions,
    this.dimensionalWeight,
    this.finalWeight,
    this.shippingCost,
    this.id,
    this.isAvailable,
    this.customerReviewCount,
    this.imageUrl,
    this.description,
    this.productUrl,
    this.productInfo,
    this.images,
    this.price,
    this.reviews,
    this.seller,
    this.shippingFirm,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      title: json['body']['name'],
      productUrl: json['body']['canonicalUrl'],
      seller: json['body']['soldBy']['name'],
      shippingFirm: json['body']['deliveredBy'],
      isAvailable: json['body']['inStock'],
      brand: json['body']['brand'],
      customerReviewCount: json['body']['customerReviewCount'],
      images: json['body']['images'],
      reviews: json['body']['customerReview'],
      description: json['body']['description'],
      productInfo: json['body']['productInformation'],
      price: json['body']['price'],
      delieveryMessages: json['body']['deliveryMessages'],
      mainImage: json['body']['mainImage'],
      originalPrice: json['body']['originalPrice'],
    );
  }
  toFirebase() {
    return {
      'title': title,
      'productUrl': productUrl,
      'seller': seller,
      'shippingFirm': shippingFirm,
      'isAvailable': isAvailable,
      'brand': brand,
      'customerReviewCount': customerReviewCount,
      'images': images,
      'reviews': reviews,
      'description': description,
      'productInfo': productInfo,
      'price': price,
      'delieveryMessages': delieveryMessages,
      'quantity': 1,
      'mainImage': mainImage,
      'originalPrice': originalPrice,
      'shippingCost': shippingCost,
      'productWeight': productWeight,
      'productDimensions': productDimensions,
      'dimensionalWeight': dimensionalWeight,
      'finalWeight': finalWeight,
    };
  }

  factory ProductModel.fromFirebase({firebase}) {
    return ProductModel(
      title: firebase['title'],
      productUrl: firebase['productUrl'],
      seller: firebase['seller'],
      shippingFirm: firebase['shippingFirm'],
      isAvailable: firebase['isAvailable'],
      brand: firebase['brand'],
      customerReviewCount: firebase['customerReviewCount'],
      images: firebase['images'],
      reviews: firebase['reviews'],
      description: firebase['description'],
      productInfo: firebase['productInfo'],
      price: firebase['price'],
      delieveryMessages: firebase['delieveryMessages'],
      quantity: firebase['quantity'],
      mainImage: firebase['mainImage'],
      originalPrice: firebase['originalPrice'],
      id: firebase['id'],
      shippingCost: firebase['shippingCost'],
      productWeight: firebase['productWeight'],
      productDimensions: firebase['productDimensions'],
      dimensionalWeight: firebase['dimensionalWeight'],
      finalWeight: firebase['finalWeight'],
    );
  }
}

List<ProductModel> products = [
  ProductModel(
    title: 'Rolex Watch',
    discountedPrice: '16.99',
    imageUrl: MarkaImages.watch,
    price: '26.99',
    discount: '10% off',
    brand: 'Rolex',
    seller: 'Smart Watches & Co',
    shippingFirm: 'Amazon',
    reviews: '89 Reviews',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis magna justo, scelerisque et euismod sit amet, eleifend quis magna. Sed fringilla, est at volutpat sodales, nisl eros tristique sapien, ut gravida urna lorem a odio. Sed bibendum lacinia nisl,',
    delieveryDate: 'Monday, 13 Dec',
  ),
  ProductModel(
    title: 'Iphone 7',
    discountedPrice: '899.99',
    price: '999.99',
    discount: '10% off',
    imageUrl: MarkaImages.phone,
    brand: 'Apple',
    seller: 'Cell Choice',
    shippingFirm: 'Amazon',
    reviews: '89 Reviews',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis magna justo, scelerisque et euismod sit amet, eleifend quis magna. Sed fringilla, est at volutpat sodales, nisl eros tristique sapien, ut gravida urna lorem a odio. Sed bibendum lacinia nisl,',
    delieveryDate: 'Monday, 13 Dec',
  ),
  ProductModel(
    title: 'Gaming Headset',
    discountedPrice: '24.99',
    price: '36.99',
    discount: '10% off',
    imageUrl: MarkaImages.gamingHeadset,
    brand: 'Logitech',
    seller: 'Cell Choice',
    shippingFirm: 'Amazon',
    reviews: '89 Reviews',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis magna justo, scelerisque et euismod sit amet, eleifend quis magna. Sed fringilla, est at volutpat sodales, nisl eros tristique sapien, ut gravida urna lorem a odio. Sed bibendum lacinia nisl,',
    delieveryDate: 'Monday, 13 Dec',
  ),
  ProductModel(
    title: 'DSLR Camera',
    discountedPrice: '199.99',
    price: '350',
    discount: '33% off',
    imageUrl: MarkaImages.camera,
    brand: 'Nikon',
    seller: 'Cell Choice',
    shippingFirm: 'Amazon',
    reviews: '99 Reviews',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis magna justo, scelerisque et euismod sit amet, eleifend quis magna. Sed fringilla, est at volutpat sodales, nisl eros tristique sapien, ut gravida urna lorem a odio. Sed bibendum lacinia nisl,',
    delieveryDate: 'Monday, 13 Dec',
  ),
];
