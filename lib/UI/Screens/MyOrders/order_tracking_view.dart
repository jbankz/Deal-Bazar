import 'package:deal_bazaar/UI/Screens/MyOrders/custom_text.dart';
import 'package:deal_bazaar/UI/base_view/base_view.dart';
import 'package:deal_bazaar/UI/shared/navigation_appbar.dart';
import 'package:flutter/material.dart';

import '../../../core/models/order_status_model.dart';

class OrderTrackingView extends StatelessWidget {
  final OrderStatusModel order;
  const OrderTrackingView({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseViewWidget(
      appBar: backNavigationAppBar(title: 'Order Tracking'),
      avoidScrollView: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _order(),
          OrderTimelineStatusTile(
              isActive: order.isFinalized,
              title: 'Order Finalized',
              iconPath: order.isFinalized == true
                  ? MarkaIcons.orderActive
                  : MarkaIcons.orderInActive),
          OrderTimelineStatusTile(
              isActive: order.isDelieveredToShippingPoints,
              title: 'Delievery To Shipping Points',
              iconPath: order.isDelieveredToShippingPoints == true
                  ? MarkaIcons.delieverToShippingUnitsActive
                  : MarkaIcons.delieverToShippingUnitsInActive),
          OrderTimelineStatusTile(
              isActive: order.isShippingStarted,
              title: 'Shipping Started',
              iconPath: order.isDelieveredToShippingPoints == true
                  ? MarkaIcons.shippingLaunchedActive
                  : MarkaIcons.shippingLaunchedInActive),
          OrderTimelineStatusTile(
              isActive: order.isDelievered,
              title: 'Delievered To You',
              iconPath: order.isDelievered == true
                  ? MarkaIcons.delieveredToYouActive
                  : MarkaIcons.delieveredToYouInActive),
          OrderTimelineStatusTile(
              isActive: order.isFeedback,
              title: 'Your Feedback',
              iconPath: order.isFeedback == true
                  ? MarkaIcons.feedbackActive
                  : MarkaIcons.feedbackInActive),
        ],
      ),
    );
  }

  _order() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
      padding: EdgeInsets.only(top: 10.h, bottom: 10.h, right: 10.w, left: 0.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          InkWell(
            // onTap: onTapAction,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  MarkaIcons.circleBackIcon,
                  color: MarkaColors.black,
                ),
                Center(
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: const Color(0xFFD99E30).withOpacity(0.5),
                    child: Image.asset(
                      products[0].imageUrl.toString(),
                      scale: 0.1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 5.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    products[0].title,
                    style: TextStyles.m_22.copyWith(
                      overflow: TextOverflow.ellipsis,
                    ),
                    color: MarkaColors.black,
                  ),
                  // ignore: avoid_unnecessary_containers
                  SizedBox(
                    width: 10.w,
                  ),
                  // ignore: avoid_unnecessary_containers
                  CustomText(
                    '07/12/2021',
                    style: TextStyles.r_14.copyWith(
                      overflow: TextOverflow.ellipsis,
                    ),
                    color: MarkaColors.darkGrey,
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                children: [
                  const CustomText('Quantity:',
                      style: TextStyles.r_19, color: MarkaColors.darkGrey),
                  SizedBox(
                    width: 2.w,
                  ),
                  const CustomText('1',
                      style: TextStyles.m_19, color: MarkaColors.black),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: MarkaColors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText('Tracking ID: ',
                        style: TextStyles.r_19, color: MarkaColors.darkGrey),
                    SizedBox(
                      width: 2.w,
                    ),
                    const CustomText('Mark2021',
                        style: TextStyles.m_19, color: MarkaColors.black),
                    SizedBox(
                      width: 2.w,
                    ),
                    SvgPicture.asset(MarkaIcons.copyClipboardIcon),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  const CustomText('Confirm Payment:',
                      style: TextStyles.r_14, color: MarkaColors.grey),
                  SizedBox(
                    width: 2.w,
                  ),
                  Row(
                    children: [
                      const CustomText(
                        '\$',
                        style: TextStyles.b_9,
                        color: MarkaColors.lightGreen,
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      CustomText(
                        products[0].discountedPrice.toString(),
                        style: TextStyles.b_16
                            .copyWith(overflow: TextOverflow.ellipsis),
                        color: MarkaColors.yellow,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OrderTimelineStatusTile extends StatelessWidget {
  final bool? isActive;
  final String iconPath;
  final String title;
  const OrderTimelineStatusTile({
    Key? key,
    required this.isActive,
    required this.title,
    required this.iconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(iconPath),
        Expanded(
          child: Container(
              margin: EdgeInsets.only(top: 18.h),
              child: CustomText(
                title,
                maxlines: 1,
                style: TextStyles.retTextStyle(
                  TextStyles.m_18,
                  isActive == true
                      ? MarkaColors.white
                      : MarkaColors.white.withOpacity(0.25),
                ),
              )),
        ),
      ],
    );
  }
}
