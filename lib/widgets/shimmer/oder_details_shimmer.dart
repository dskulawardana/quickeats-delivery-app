import 'package:flutter/material.dart';
import 'package:food_ex_delivery_app/controllers/order_details_controller.dart';
import 'package:food_ex_delivery_app/utils/font_size.dart';
import 'package:food_ex_delivery_app/utils/size_config.dart';
import 'package:food_ex_delivery_app/utils/theme_colors.dart';
import 'package:food_ex_delivery_app/widgets/order_details_bottom_bar.dart';
import 'package:shimmer/shimmer.dart';

class Order_detailsShimmer extends StatefulWidget {
  final int? orderId;
  const Order_detailsShimmer({super.key, this.orderId});

  @override
  _Order_detailsShimmerState createState() => _Order_detailsShimmerState();
}

class _Order_detailsShimmerState extends State<Order_detailsShimmer> {
  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig();
    sizeConfig.init(context);

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[400]!,
          child: const Order_details_bottom_bar(
            subTotal: '145',
            deliveryFee: '73',
            total: '240',
            orderID: 1,
            statusCode: 1,
          ),
        ),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            //order id container
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 10, left: 15),
                  child: Row(
                    children: [
                      Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[400]!,
                          child: const Icon(Icons.shopping_basket_outlined)),
                      const SizedBox(
                        width: 10,
                      ),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[400]!,
                        child: const Text(
                          "Shop details",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.transparent),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                    width: SizeConfig.screenWidth,
                    child: Card(
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 5, right: 5),
                        child: Row(
                          children: [
                            //shop image container
                            Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[400]!,
                              child: Container(
                                  width: SizeConfig.screenWidth! / 4,
                                  height: SizeConfig.screenWidth! / 4,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        bottomLeft: Radius.circular(10.0)),
                                  ),
                                  child: const Image(
                                      image: AssetImage(
                                          'assets/images/farmhouse.jpg'))),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            //shop descrption container
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[400]!,
                                  child: const Text(
                                    'MacDonalds',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.transparent,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[400]!,
                                  child: const Text(
                                    'USA',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14,
                                      color: Colors.transparent,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 1,
                                ),
                                Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[400]!,
                                  child: const Text(
                                    "Time : 08:00 am"
                                    "-10:00 pm",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14,
                                        color: Colors.transparent),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(top: 20, bottom: 10, left: 15),
              child: Row(
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[400]!,
                    child: const Text(
                      "Ordered Foods",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: ThemeColors.scaffoldBgColor),
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //SizedBox(height: 20,),
                    Container(
                      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 2),
                    ),
                    Card(
                      elevation: 1,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: ListTile(
                          leading: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[400]!,
                            child: Container(
                              height: SizeConfig.screenWidth! / 5,
                              width: SizeConfig.screenWidth! / 5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/farmhouse.jpg'),
                                      fit: BoxFit.fill)),
                            ),
                          ),
                          title: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[400]!,
                            child: const Text(
                              'Burger',
                              style: TextStyle(
                                fontSize: FontSize.xMedium,
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                          subtitle: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[400]!,
                            child: const Text(
                              'Farmhous Burger',
                              style: TextStyle(
                                overflow: TextOverflow.fade,
                                fontSize: FontSize.medium,
                                fontWeight: FontWeight.w300,
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                          trailing: Column(
                            children: [
                              Expanded(
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[400]!,
                                  child: const Text(
                                    '\$71',
                                    style: TextStyle(
                                      fontSize: FontSize.medium,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.transparent,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2.0),
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[400]!,
                                    child: const Text(
                                      '12-12-2021',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: FontSize.medium,
                                        color: Colors.transparent,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[400]!,
                                  child: const Text(
                                    '12 hours',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: FontSize.medium,
                                        color: Colors.transparent),
                                  ),
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
            )
          ]),
        ),
      ),
    );
  }

  Customer_details(OrderDetailsController orderDetails) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 10, bottom: 10, left: 15),
          child: Row(
            children: [
              Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[400]!,
                  child: const Icon(Icons.person_pin)),
              const SizedBox(
                width: 10,
              ),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[400]!,
                child: const Text(
                  "Customer details",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: ThemeColors.scaffoldBgColor),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 25),
          color: ThemeColors.off_white_Color,
          //height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[400]!,
                    child: const Text(
                      'Abdul',
                      style: TextStyle(color: Colors.transparent),
                    ),
                  ),
                  Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[400]!,
                      child: IconButton(
                          onPressed: () {}, icon: const Icon(Icons.person_pin))),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[400]!,
                    child: const Text(
                      'USA',
                      style: TextStyle(color: Colors.transparent),
                    ),
                  ),
                  Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[400]!,
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.location_on_outlined))),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[400]!,
                    child: const Text(
                      '017165416516',
                      style: TextStyle(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[400]!,
                      child: IconButton(
                          onPressed: () {}, icon: const Icon(Icons.phone_sharp))),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
