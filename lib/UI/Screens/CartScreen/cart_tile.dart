import 'package:cached_network_image/cached_network_image.dart';
import 'package:deal_bazaar/UI/base_view/base_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../core/models/product_model.dart';
import '../../../marka_imports.dart';

class CartTile extends StatelessWidget {
  final ProductModel product;
  final int quantity;
  final VoidCallback? increaseAction;

  final VoidCallback? decreaseAction;
  final VoidCallback? cancelAction;

  const CartTile({
    Key? key,
    required this.product,
    this.cancelAction,
    this.decreaseAction,
    required this.quantity,
    this.increaseAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 200,
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
      // constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          InkWell(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(Icons.backpack),
                Center(
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: const Color(0xFFD99E30).withOpacity(0.5),
                    child: CachedNetworkImage(
                      imageUrl: product.mainImage.toString(),
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              const SpinKitThreeBounce(
                        color: Colors.white,
                        size: 15.0,
                      ),
                      errorWidget: (context, url, error) {
                        log(error.toString());
                        return const Icon(Icons.error);
                      },
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
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        product.title.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.retTextStyle(
                            TextStyles.m_15, MarkaColors.white),
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    // ignore: avoid_unnecessary_containers
                    InkWell(
                        onTap: cancelAction, child: Icon(Icons.delete_sharp)),
                  ],
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                product.price.toString(),
                style: TextStyles.b_20.copyWith(
                    overflow: TextOverflow.ellipsis, color: Colors.yellow),
              ),
              SizedBox(
                height: 5.h,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.discountedPrice != null
                          ? product.discountedPrice.toString()
                          : '',
                      style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontSize: 9,
                          color: MarkaColors.lightGrey),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: Text(
                        product.isAvailable == true
                            ? 'Available'
                            : 'Not Available',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 9,
                            color: MarkaColors.lightGrey),
                      ),
                    ),
                    SizedBox(
                      width: BaseViewWidget.width * 0.1041,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: decreaseAction,
                          child: Container(
                            height: 16,
                            width: 16,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: MarkaColors.lightGold.withOpacity(0.33),
                            ),
                            child: Icon(Icons.remove),
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.w, vertical: 5.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            color: MarkaColors.white,
                          ),
                          child: Text(
                            product.quantity.toString(),
                            style: TextStyle(color: MarkaColors.black),
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        InkWell(
                          onTap: increaseAction,
                          child: Container(
                            height: 16,
                            width: 16,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: MarkaColors.lightGold.withOpacity(0.33),
                            ),
                            child: Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
