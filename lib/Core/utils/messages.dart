import 'package:deal_bazaar/UI/base_view/base_view.dart';

void showSnack(String title, String? message, {bool? isError = false}) {
  Get.snackbar('Sign In Error', message ?? '',
      backgroundColor: isError! ? MarkaColors.red2 : MarkaColors.green,
      colorText: MarkaColors.white,
      duration: const Duration(seconds: 4),
      snackPosition: SnackPosition.BOTTOM);
}
