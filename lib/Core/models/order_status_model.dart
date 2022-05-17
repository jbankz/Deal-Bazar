import 'package:deal_bazaar/core/enums/order_status.dart';

class OrderStatusModel {
  String? orderId;
  String? date;
  int? quantity;
  List<dynamic> products;
  double? price;
  String? trackingId;
  OrderStatus? status;
  bool? isFinalized;
  bool? isDelieveredToShippingPoints;
  bool? isShippingStarted;
  bool? isDelievered;
  bool? isFeedback;

  OrderStatusModel({
    this.date,
    this.orderId,
    this.price,
    this.quantity,
    this.status,
    this.trackingId,
    required this.products,
    this.isFinalized,
    this.isDelieveredToShippingPoints,
    this.isShippingStarted,
    this.isDelievered,
    this.isFeedback,
  });
  toFirebase() {
    return {
      'orderId': orderId,
      'date': date,
      'products': products,
      'price': price,
      'trackingId': trackingId,
      // 'status': status,
      'isFinalized': isFinalized,
      'isDelieveredToShippingPoints': isDelieveredToShippingPoints,
      'isShippingStarted': isShippingStarted,
      'isDelievered': isDelievered,
      'isFeedback': isFeedback,
    };
  }

  factory OrderStatusModel.fromFirebase({firebase}) {
    return OrderStatusModel(
      products: firebase['products'] ?? [],
      orderId: firebase['orderId'],
      date: firebase['date'],
      price: firebase['price'],
      trackingId: firebase['trackingId'],
      // status: firebase['status'],
      isFinalized: firebase['isFinalized'],
      isDelieveredToShippingPoints: firebase['isDelieveredToShippingPoints'],
      isShippingStarted: firebase['isShippingStarted'],
      isDelievered: firebase['isDelievered'],
      isFeedback: firebase['isFeedback'],
    );
  }
}

List<OrderStatusModel> delieveredOrders = [
  OrderStatusModel(
    products: [],
    date: '06/12/2021',
    orderId: 'M00183',
    quantity: 3,
    price: 145,
    trackingId: 'K6122021',
    status: OrderStatus.delievered,
  ),
  OrderStatusModel(
    products: [],
    date: '06/12/2021',
    orderId: 'M00183',
    quantity: 6,
    price: 165,
    trackingId: 'K6122021',
    status: OrderStatus.delievered,
  ),
  OrderStatusModel(
    products: [],
    date: '06/12/2021',
    orderId: 'M00183',
    quantity: 6,
    price: 165,
    trackingId: 'K6122021',
    status: OrderStatus.delievered,
  ),
];
List<OrderStatusModel> pendingOrders = [
  OrderStatusModel(
    products: [],
    date: '06/12/2021',
    orderId: 'M00183',
    quantity: 3,
    price: 145,
    trackingId: 'K6122021',
    status: OrderStatus.pending,
  ),
  OrderStatusModel(
    products: [],
    date: '06/12/2021',
    orderId: 'M00183',
    quantity: 6,
    price: 165,
    trackingId: 'K6122021',
    status: OrderStatus.pending,
  ),
  OrderStatusModel(
    products: [],
    date: '06/12/2021',
    orderId: 'M00183',
    quantity: 6,
    price: 165,
    trackingId: 'K6122021',
    status: OrderStatus.pending,
  ),
];
