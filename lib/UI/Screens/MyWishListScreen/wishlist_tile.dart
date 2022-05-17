import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:deal_bazaar/core/services/database/db_service.dart';
import 'package:deal_bazaar/ui/base_view/base_view.dart';

import '../user_viewmodel/user_viewmodel.dart';

class WishlistTile extends StatelessWidget {
  final ProductModel product;
  const WishlistTile({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin:EdgeInsets.(vertical: 15.h, horizontal: 10.w),
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      height: 148,
      width: BaseViewWidget.width * 0.4226,
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
              Container(
                  height: BaseViewWidget.height * 0.025,
                  width: BaseViewWidget.height * 0.025,
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 0), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: Icon(Icons.favorite_outline)),
              // ignore: avoid_unnecessary_containers
              Container(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(Icons.circle_rounded),
                    Center(
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor:
                            const Color(0xFFD99E30).withOpacity(0.5),
                        child: ClipRRect(
                          child: CachedNetworkImage(
                            imageUrl: product.images?.first,
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
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                      height: BaseViewWidget.height * 0.025,
                      width: BaseViewWidget.height * 0.025,
                      padding:
                          EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 5,
                            offset: const Offset(
                                0, 0), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      child: Icon(Icons.shopping_cart)),
                  SizedBox(
                    height: 5.h,
                  ),
                  InkWell(
                    onTap: () async {
                      await DbService().deleteFromWishlist(
                          dbId: context
                              .read<UserViewModel>()
                              .user
                              .dbId
                              .toString(),
                          wishlistId: product.id.toString());
                    },
                    child: Container(
                        height: BaseViewWidget.height * 0.025,
                        width: BaseViewWidget.height * 0.025,
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 5,
                              offset: const Offset(
                                  0, 0), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        child: Icon(Icons.delete)),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  product.title.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.retTextStyle(
                      TextStyles.m_12, MarkaColors.black),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                product.price.toString(),
                style: TextStyles.b_20.copyWith(
                    overflow: TextOverflow.ellipsis, color: Colors.yellow),
              ),
              SizedBox(width: 5.w),
              Expanded(
                child: Text(
                  product.reviews.toString(),
                  maxLines: 1,
                  style: const TextStyle(
                      fontSize: 9, color: MarkaColors.lightGrey),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
