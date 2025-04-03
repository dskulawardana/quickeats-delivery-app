import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:food_ex_delivery_app/controllers/global-controller.dart';
import 'package:food_ex_delivery_app/controllers/notification_order_controller.dart';
import 'package:food_ex_delivery_app/utils/font_size.dart';
import 'package:food_ex_delivery_app/utils/size_config.dart';
import 'package:food_ex_delivery_app/utils/theme_colors.dart';
import 'package:food_ex_delivery_app/views/order/no_order_found_page.dart';
import 'package:food_ex_delivery_app/views/order/order_details.dart';
import 'package:get/get.dart';

class Delivered extends StatefulWidget {
  const Delivered({super.key});

  @override
  _DeliveredState createState() => _DeliveredState();
}

class _DeliveredState extends State<Delivered> {
  final order_Controller = Get.put(OrderListController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      order_Controller.onInit();
    });
    return GetBuilder<OrderListController>(
        init: OrderListController(),
        builder: (orders) => Expanded(
              child: orders.orderListLen == 0
                  ? const NoOrderFound()
                  : ListView.builder(
                      itemCount: orders.orderHistoryList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (() {
                            Get.to(OrderDetailsById(
                                orderId: orders.orderHistoryList[index].id));
                          }),
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2.5),
                              width: SizeConfig.screenWidth,
                              //height: SizeConfig.screenHeight!/3.5,
                              child: Card(
                                  elevation: 1,
                                  // shadowColor: Colors.blueGrey,

                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    side: BorderSide(
                                      width: 0.05,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(Icons.access_time),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(orders
                                                    .orderHistoryList[index]
                                                    .timeFormat
                                                    .toString()),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                orders.orderHistoryList[index]
                                                    .statusName
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.green,
                                                    fontWeight:
                                                        FontWeight.w900),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 1),
                                          child: Divider(),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10, left: 5, right: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  //order id
                                                  Text(
                                                    "ORDER_NO#".tr,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 16,
                                                      //    color: Colors.deepOrange
                                                    ),
                                                  ),
                                                  Text(
                                                    orders
                                                        .orderHistoryList[index]
                                                        .orderCode
                                                        .toString(),
                                                    style: const TextStyle(
                                                      color: ThemeColors
                                                          .scaffoldBgColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          FontSize.xMedium,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  //order id
                                                  Text(
                                                    "TOTAL".tr,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 16,
                                                      //    color: Colors.deepOrange
                                                    ),
                                                  ),
                                                  Text(
                                                    Get.find<GlobalController>()
                                                            .currency! +
                                                        orders
                                                            .orderHistoryList[
                                                                index]
                                                            .total
                                                            .toString(),
                                                    style: const TextStyle(
                                                      color: ThemeColors
                                                          .scaffoldBgColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          FontSize.xMedium,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 2),
                                          child: Row(
                                            children: [],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2, horizontal: 5),
                                          child: Row(
                                            children: [
                                              Text(
                                                "TIME".tr,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16
                                                    // color: Colors.grey
                                                    ),
                                              ),
                                              Text(
                                                orders.orderHistoryList[index]
                                                    .createdAt
                                                    .toString(),
                                                style: const TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  //fontWeight: FontWeight.w300,
                                                  fontSize: 13,
                                                  color: Colors.grey,
                                                  fontFamily:
                                                      'AirbnbCerealBold',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2, horizontal: 5),
                                          child: Row(
                                            children: [
                                              Text(
                                                "PAYMENT_MODE".tr,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w400,

                                                  fontSize: 16,
                                                  // color: Colors.grey
                                                ),
                                              ),
                                              Text(
                                                orders.orderHistoryList[index]
                                                    .paymentMethodName
                                                    .toString(),
                                                style: const TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  // fontWeight: FontWeight.w300,
                                                  fontSize: 13,
                                                  color: Colors.grey,
                                                  fontFamily:
                                                      'AirbnbCerealBold',
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))),
                        );
                      }),
            ));
  }
}
