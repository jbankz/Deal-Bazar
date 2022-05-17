import 'package:deal_bazaar/UI/Screens/MyOrders/custom_text.dart';
import 'package:deal_bazaar/UI/base_view/base_view.dart';
import 'package:deal_bazaar/core/utils/text_styles.dart';
import 'package:flutter/material.dart';

import '../../../Core/utils/colors.dart';

class OrderStatusTile extends StatelessWidget {
  final OrderStatusModel order;
  const OrderStatusTile({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15.h, horizontal: 5.w),
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
        // height: 160,
        // width: 295,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFF1F1F1),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CustomText(
                      'ORDER# ',
                      style: TextStyles.m_16,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    CustomText(
                      order.orderId.toString().toUpperCase(),
                      style: TextStyles.m_16,
                      overflow: TextOverflow.ellipsis,
                      maxlines: 2,
                      color: Colors.black,
                    ),
                  ],
                ),
                SizedBox(
                  width: 5.w,
                ),
                Expanded(
                  child: CustomText(
                    order.date.toString(),
                    style: TextStyles.r_12,
                    maxlines: 1,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.black.withOpacity(0.75),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomText(
                      'Quantity:',
                      style: TextStyles.r_16,
                      color: Colors.black.withOpacity(0.75),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    CustomText(
                      order.products.length.toString(),
                      style: TextStyles.m_16,
                      color: Colors.black,
                    ),
                  ],
                ),
                Row(
                  children: [
                    CustomText(
                      'Price:',
                      style: TextStyles.r_16,
                      color: Colors.black.withOpacity(0.75),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    CustomText(
                      '\$ ' + order.price.toString(),
                      style: TextStyles.r_16,
                      color: Colors.black,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              children: [
                CustomText(
                  'Tracking ID:',
                  style: TextStyles.r_16,
                  color: Colors.black.withOpacity(0.75),
                ),
                SizedBox(
                  width: 2.w,
                ),
                CustomText(
                  order.trackingId.toString(),
                  style: TextStyles.m_16,
                  color: Colors.black,
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            order.isDelievered!
                ? Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 25.w,
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.0)),
                    child: const Center(
                      child: CustomText(
                        'Delievered Successfully',
                        style: TextStyles.m_15,
                        color: Colors.green,
                      ),
                    ),
                  )
                : Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 25.w,
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.0)),
                    child: const Center(
                      child: CustomText(
                        'Processing',
                        style: TextStyles.m_15,
                        color: Colors.red,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
