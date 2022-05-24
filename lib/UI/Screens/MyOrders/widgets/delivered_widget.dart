import 'package:deal_bazaar/UI/base_view/base_view.dart';
import 'package:flutter/material.dart';

import '../../user_viewmodel/user_viewmodel.dart';


class DelieveredOrdersView extends StatelessWidget {
  const DelieveredOrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final um = context.watch<UserViewModel>();

    return BaseViewWidget(
        avoidScrollView: true,
        body:
            Container() /*Expanded(
        child: Column(
          children: [
            StreamBuilder<List<OrderStatusModel>>(
                stream:
                    DbService().delieveredOrders(dbId: um.user.dbId.toString()),
                initialData: const [],
                builder: (context, snapshot) {
                  log(snapshot.data!.length.toString());
                  if (snapshot.data!.isNotEmpty) {
                    //   return Container();
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (ctx, index) {
                          return InkWell(
                              onTap: () => Get.to(() => OrderTrackingView(
                                  order: snapshot.data![index])),
                              child: OrderStatusTile(
                                  order: snapshot.data![index]));
                        });
                  } else if (snapshot.data!.isEmpty) {
                    return const Text('No Order Placed');
                  }
                  return const LoaderWidget(message: 'Fetching Order Placed');
                }),
          ],
        ),
      ),*/
        );
  }
}
