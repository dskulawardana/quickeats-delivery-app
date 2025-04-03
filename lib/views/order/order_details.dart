import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_ex_delivery_app/controllers/global-controller.dart';
import 'package:food_ex_delivery_app/controllers/order_details_controller.dart';
import 'package:food_ex_delivery_app/utils/font_size.dart';
import 'package:food_ex_delivery_app/utils/images.dart';
import 'package:food_ex_delivery_app/utils/size_config.dart';
import 'package:food_ex_delivery_app/utils/theme_colors.dart';
import 'package:food_ex_delivery_app/widgets/order_details_bottom_bar.dart';
import 'package:food_ex_delivery_app/widgets/shimmer/oder_details_shimmer.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controllers/notification_order_controller.dart';

class OrderDetailsById extends StatefulWidget {
  final int? orderId;
  const OrderDetailsById({super.key, this.orderId});

  @override
  _OrderDetailsByIdState createState() => _OrderDetailsByIdState();
}

class _OrderDetailsByIdState extends State<OrderDetailsById> {
  int statusValue = 0;
  int statusActive = 1;
  final settingsController = Get.put(GlobalController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig();
    sizeConfig.init(context);
    var orderDetailsController =
        Get.put(OrderDetailsController(widget.orderId));

    Future<Null> onRefresh() {
      setState(() {
        orderDetailsController.onInit();
      });
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        onRefresh();
      });
      Completer<Null> completer = Completer<Null>();
      Timer(const Duration(seconds: 3), () {
        completer.complete();
      });
      return completer.future;
    }

    return GetBuilder<OrderDetailsController>(
      init: OrderDetailsController(widget.orderId),
      builder: (orderDetails) => orderDetails.loader
          ? const Order_detailsShimmer()
          : Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Get.find<OrderListController>().onInit;
                    Navigator.of(context).pop();
                  },
                ),
                title: Text(
                  "ORDER_DETAILS".tr,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: FontSize.xLarge,
                    color: Colors.white,
                  ),
                ),
                backgroundColor: ThemeColors.baseThemeColor,
                centerTitle: true,
                elevation: 0.0,
              ),
              bottomNavigationBar: Order_details_bottom_bar(
                subTotal:
                    orderDetails.orderDetailsByIdData!.subTotal.toString(),
                deliveryFee: orderDetails.orderDetailsByIdData!.deliveryCharge
                    .toString(),
                total: orderDetails.orderDetailsByIdData!.total,
                orderID: orderDetails.orderDetailsByIdData!.id,
                statusCode: orderDetails.statusCode,
              ),
              body: RefreshIndicator(
                onRefresh: onRefresh,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    statusActive = 1;
                                  });
                                },
                                child: Container(
                                  height: 50,
                                  width: 150,
                                  decoration: statusActive == 1
                                      ? BoxDecoration(
                                          color: ThemeColors.baseThemeColor,
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        )
                                      : BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          border: const Border.fromBorderSide(
                                            BorderSide(
                                              color: ThemeColors.baseThemeColor,
                                            ),
                                          ),
                                        ),
                                  child: Center(
                                      child: Text('DETAILS'.tr,
                                          style: TextStyle(
                                              color: statusActive == 1
                                                  ? Colors.white
                                                  : ThemeColors
                                                      .baseThemeColor))),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    statusActive = 2;
                                  });
                                },
                                child: Container(
                                  height: 50,
                                  width: 150,
                                  decoration: statusActive == 2
                                      ? BoxDecoration(
                                          color: ThemeColors.baseThemeColor,
                                          borderRadius:
                                              BorderRadius.circular(40))
                                      : BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          border: const Border.fromBorderSide(
                                            BorderSide(
                                              color: ThemeColors.baseThemeColor,
                                            ),
                                          ),
                                        ),
                                  child: Center(
                                    child: Text(
                                      'TRACKING_ORDER'.tr,
                                      style: TextStyle(
                                        color: statusActive == 2
                                            ? Colors.white
                                            : ThemeColors.baseThemeColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        statusActive == 1
                            ? ListView(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                children: [
                                    Container(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 1.0, horizontal: 15),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "${"ORDER_NO".tr} #${orderDetails.orderCode}",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                Text(
                                                  "${Get.find<GlobalController>().currency!}${orderDetails.total}",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 15),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${"ORDER".tr} ${orderDetails.statusName}",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 13,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "${orderDetails.createdTime} ",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 13,
                                                      color: Colors.grey),
                                                ),
                                                Text(
                                                  "${"ITEMS".tr} ${orderDetails.orderDetailsByIdData!.items!.length} ",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 13,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          //   Stepper
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(
                                              top: 20, bottom: 10, left: 15),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.shopping_basket_outlined,
                                                color:
                                                    ThemeColors.baseThemeColor,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "SHOP_DETAILS".tr,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                    color: ThemeColors
                                                        .scaffoldBgColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: SizeConfig.screenWidth,
                                          child: Card(
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                  top: 10,
                                                  bottom: 10,
                                                  left: 5,
                                                  right: 5),
                                              child: Row(
                                                children: [
                                                  //shop image container
                                                  CachedNetworkImage(
                                                    imageUrl: orderDetails
                                                        .orderDetailsByIdData!
                                                        .restaurant!
                                                        .logo!,
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        Container(
                                                            width: SizeConfig
                                                                    .screenWidth! /
                                                                4,
                                                            height: SizeConfig
                                                                    .screenWidth! /
                                                                4,
                                                            decoration:
                                                                const BoxDecoration(
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10.0),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          10.0)),
                                                            ),
                                                            child: Image(
                                                                image:
                                                                    imageProvider)),
                                                    placeholder:
                                                        (context, url) =>
                                                            Shimmer.fromColors(
                                                      baseColor:
                                                          Colors.grey[300]!,
                                                      highlightColor:
                                                          Colors.grey[400]!,
                                                      child: Container(
                                                        width: SizeConfig
                                                                .screenWidth! /
                                                            4,
                                                        height: SizeConfig
                                                                .screenWidth! /
                                                            4,
                                                        decoration:
                                                            const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10.0),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          10.0)),
                                                        ),
                                                        child: Image(
                                                          image: AssetImage(
                                                              Images.food2),
                                                        ),
                                                      ),
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            const Icon(
                                                      Icons.error,
                                                      color: ThemeColors
                                                          .baseThemeColor,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),

                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          orderDetails
                                                              .orderDetailsByIdData!
                                                              .restaurant!
                                                              .name
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16,
                                                              color: ThemeColors
                                                                  .scaffoldBgColor),
                                                        ),
                                                        const SizedBox(
                                                          height: 2,
                                                        ),
                                                        Text(
                                                          orderDetails
                                                              .orderDetailsByIdData!
                                                              .restaurant!
                                                              .address
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontSize: 14,
                                                              color: ThemeColors
                                                                  .greyTextColor),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        const SizedBox(
                                                          height: 1,
                                                        ),
                                                        Text(
                                                          "${"TIME".tr}${orderDetailsController.orderDetailsByIdData!.restaurant!.openingTime}-${orderDetailsController.orderDetailsByIdData!.restaurant!.closingTime}",
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontSize: 14,
                                                              color: ThemeColors
                                                                  .greyTextColor),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    orderDetails.statusCode! >= 17
                                        ? Customer_details(orderDetails)
                                        : Container(
                                            height: 0,
                                          ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          top: 20, bottom: 10, left: 15),
                                      child: Row(
                                        children: [
                                          Text(
                                            "ORDERED_FOODS".tr,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: ThemeColors
                                                    .scaffoldBgColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      itemCount: orderDetails
                                          .orderDetailsByIdData!.items!.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            //SizedBox(height: 20,),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 15,
                                                  right: 15,
                                                  bottom: 2),
                                            ),
                                            Card(
                                              elevation: 1,
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(
                                                    vertical: 2),
                                                child: ListTile(
                                                  leading: CachedNetworkImage(
                                                    imageUrl: orderDetails
                                                        .orderDetailsByIdData!
                                                        .items![index]
                                                        .menuItem!
                                                        .image!,
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        Container(
                                                      height: SizeConfig
                                                              .screenWidth! /
                                                          5,
                                                      width: SizeConfig
                                                              .screenWidth! /
                                                          5,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        image: DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit.fill),
                                                      ),
                                                    ),
                                                    placeholder:
                                                        (context, url) =>
                                                            Shimmer.fromColors(
                                                      baseColor:
                                                          Colors.grey[300]!,
                                                      highlightColor:
                                                          Colors.grey[400]!,
                                                      child: Container(
                                                        width: SizeConfig
                                                                .screenWidth! /
                                                            4,
                                                        height: SizeConfig
                                                                .screenWidth! /
                                                            4,
                                                        decoration:
                                                            const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10.0),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          10.0)),
                                                        ),
                                                        child: Image(
                                                          image: AssetImage(
                                                              Images.food1),
                                                        ),
                                                      ),
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            const Icon(
                                                      Icons.error,
                                                      color: ThemeColors
                                                          .baseThemeColor,
                                                    ),
                                                  ),
                                                  title: Text(
                                                    orderDetails
                                                        .orderDetailsByIdData!
                                                        .items![index]
                                                        .menuItem!
                                                        .name
                                                        .toString(),
                                                    style: const TextStyle(
                                                      fontSize:
                                                          FontSize.xMedium,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  subtitle: Text(
                                                    '${Get.find<GlobalController>()
                                                            .currency!}${orderDetails
                                                            .orderDetailsByIdData!
                                                            .items![index]
                                                            .unitPrice} X ${orderDetails
                                                            .orderDetailsByIdData!
                                                            .items![index]
                                                            .quantity} = ${orderDetails
                                                            .orderDetailsByIdData!
                                                            .items![index]
                                                            .itemTotal}',
                                                    style: const TextStyle(
                                                      overflow:
                                                          TextOverflow.fade,
                                                      fontSize: FontSize.medium,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                                  ),
                                                  trailing: Column(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          Get.find<GlobalController>()
                                                                  .currency! +
                                                              orderDetails
                                                                  .orderDetailsByIdData!
                                                                  .items![index]
                                                                  .itemTotal
                                                                  .toString(),
                                                          style: const TextStyle(
                                                            fontSize:
                                                                FontSize.medium,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          orderDetails
                                                              .orderDetailsByIdData!
                                                              .timeFormat
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontSize: FontSize
                                                                  .medium,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                    settingsController.support_phone == null
                                        ? Container()
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    top: 20,
                                                    bottom: 10,
                                                    left: 15),
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                        FontAwesomeIcons
                                                            .phoneVolume,
                                                        color: ThemeColors
                                                            .baseThemeColor),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      "SUPPORT_NUMBER".tr,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16,
                                                          color: ThemeColors
                                                              .scaffoldBgColor),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: SizeConfig.screenWidth,
                                                child: Card(
                                                  child: Container(
                                                    padding: const EdgeInsets.only(
                                                        top: 10,
                                                        bottom: 10,
                                                        left: 5,
                                                        right: 5),
                                                    child: Row(
                                                      children: [
                                                        //shop image container
                                                        const Icon(
                                                          FontAwesomeIcons
                                                              .headset,
                                                          color: ThemeColors
                                                              .baseThemeColor,
                                                          size: 40,
                                                        ),
                                                        const SizedBox(
                                                          width: 30,
                                                        ),

                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'CALL_YOUR_SUPPORT'
                                                                    .tr,
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        16,
                                                                    color: ThemeColors
                                                                        .scaffoldBgColor),
                                                              ),
                                                              const SizedBox(
                                                                height: 2,
                                                              ),
                                                              Text(
                                                                settingsController.support_phone.toString(),
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300,
                                                                    fontSize:
                                                                        14,
                                                                    color: ThemeColors
                                                                        .greyTextColor),
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        IconButton(
                                                          onPressed: () {
                                                            _makePhoneCall(
                                                                settingsController
                                                                    .support_phone
                                                                    .toString());
                                                          },
                                                          icon: const Icon(
                                                            Icons.phone_enabled,
                                                            color: ThemeColors
                                                                .baseThemeColor,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                  ])
                            : Container(),
                        //order id container
                        statusActive == 2
                            ? ListView(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                children: [
                                    Container(
                                      child: Theme(
                                        data: ThemeData(
                                          colorScheme:
                                              ColorScheme.fromSwatch().copyWith(
                                            primary: ThemeColors.baseThemeColor,
                                          ),
                                        ),
                                        child: Stepper(
                                          physics: const ClampingScrollPhysics(),
                                          controlsBuilder:
                                              (BuildContext context,
                                                  ControlsDetails controls) {
                                            return const SizedBox(height: 0.0);
                                          },
                                          steps: getTrackingSteps(
                                              context,
                                              orderDetails.statusName,
                                              orderDetails.statusCode
                                                  .toString()),
                                          currentStep: statusValue,
                                        ),
                                      ),
                                    ),
                                  ])
                            : Container(),
                      ]),
                ),
              ),
            ),
    );
  }

  List<Step> getTrackingSteps(BuildContext context, statusName, status) {
    List<Step> orderStatusSteps = [];
    if (status == '10') {
      orderStatusSteps.add(Step(
        state: StepState.complete,
        title: Text(
          'ORDER_CANCEL'.tr,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        content: const SizedBox(
            width: double.infinity,
            child: Text(
              '',
            )),
        isActive: int.tryParse(status)! >= int.tryParse('10')!,
      ));
    } else {
      orderStatusSteps.add(Step(
        state: StepState.complete,
        title: Text(
          'ORDER_PENDING'.tr,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        content: const SizedBox(
          width: double.infinity,
          child: Text(
            '',
            style: TextStyle(
                color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        isActive: int.tryParse(status)! >= int.tryParse('5')!,
      ));
    }
    if (status == '12') {
      orderStatusSteps.add(Step(
        state: StepState.complete,
        title: Text(
          'ORDER_REJECT'.tr,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        content: const SizedBox(
            width: double.infinity,
            child: Text(
              '',
            )),
        isActive: int.tryParse(status)! >= int.tryParse('12')!,
      ));
    } else {
      orderStatusSteps.add(Step(
        state: StepState.complete,
        title: Text(
          'ORDER_ACCEPT'.tr,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        content: const SizedBox(
            width: double.infinity,
            child: Text(
              '',
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            )),
        isActive: int.tryParse(status)! >= int.tryParse('14')!,
      ));
    }
    orderStatusSteps.add(Step(
      state: StepState.complete,
      title: Text(
        'ORDER_PROCESS'.tr,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      content: const SizedBox(
          width: double.infinity,
          child: Text(
            '',
            style: TextStyle(
                color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold),
          )),
      isActive: int.tryParse(status)! >= int.tryParse('15')!,
    ));
    orderStatusSteps.add(Step(
      state: StepState.complete,
      title: Text(
        'ON_THE_WAY'.tr,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      content: const SizedBox(
          width: double.infinity,
          child: Text(
            '',
            style: TextStyle(
                color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold),
          )),
      isActive: int.tryParse(status)! >= int.tryParse('17')!,
    ));
    orderStatusSteps.add(Step(
      state: StepState.complete,
      title: Text(
        'ORDER_COMPLETED'.tr,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      content: const SizedBox(
        width: double.infinity,
        child: Text(
          '',
          style: TextStyle(
              color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      isActive: int.tryParse(status)! >= int.tryParse('20')!,
    ));
    return orderStatusSteps;
  }

  Customer_details(OrderDetailsController orderDetails) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 10, bottom: 10, left: 15),
          child: Row(
            children: [
              const Icon(
                FontAwesomeIcons.userTie,
                color: ThemeColors.baseThemeColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "CUSTOMER_DETAILS".tr,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: ThemeColors.scaffoldBgColor),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 25),
          color: Colors.white,
          //height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    orderDetails.orderDetailsByIdData!.customer!.name
                        .toString(),
                    style: const TextStyle(),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.person_pin,
                      color: ThemeColors.baseThemeColor,
                    ),
                  ),
                ],
              ),
              orderDetails.orderDetailsByIdData!.customer!.address == null
                  ? const SizedBox().marginZero
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          orderDetails.orderDetailsByIdData!.customer!.address
                              .toString(),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.location_on_outlined,
                            color: ThemeColors.baseThemeColor,
                          ),
                        ),
                      ],
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    orderDetails.orderDetailsByIdData!.customer!.phone
                        .toString(),
                  ),
                  IconButton(
                    onPressed: () {
                      _makePhoneCall(
                        orderDetails.orderDetailsByIdData!.customer!.phone
                            .toString(),
                      );
                    },
                    icon: const Icon(
                      Icons.phone_sharp,
                      color: ThemeColors.baseThemeColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }
}
