import 'package:deal_bazaar/core/utils/icons.dart';

class PaymentMethodModel {
  String? paymentMethodType;
  String? cardNumber;
  String? lastFourDigits;
  String? cvv;
  String? expDate;
  String? cardHolderName;
  String cardAvatar;

  PaymentMethodModel(
      {this.cardHolderName,
      this.cardNumber,
      this.cvv,
      this.expDate,
      required this.cardAvatar,
      this.lastFourDigits,
      this.paymentMethodType});
}

final List<String> cards = [
  MarkaIcons.visaCard,
];

final List<PaymentMethodModel> paymentMethods = [
  PaymentMethodModel(
    paymentMethodType: 'Visa',
    lastFourDigits: '8173',
    expDate: '07/2025',
    cardAvatar: MarkaIcons.visaCard,
  ),
  PaymentMethodModel(
    paymentMethodType: 'Master Card',
    lastFourDigits: '7438',
    expDate: '03/2024',
    cardAvatar: MarkaIcons.visaCard,
  ),
  PaymentMethodModel(
    paymentMethodType: 'Paypal',
    lastFourDigits: '5821',
    expDate: '05/2026',
    cardAvatar: MarkaIcons.visaCard,
  ),
];
