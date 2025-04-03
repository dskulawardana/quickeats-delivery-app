import 'package:flutter/material.dart';
import 'package:food_ex_delivery_app/utils/font_size.dart';
import 'package:food_ex_delivery_app/utils/images.dart';
import 'package:get/get.dart';

class Delivery_completed extends StatefulWidget {
  const Delivery_completed({super.key});

  @override
  _Delivery_completedState createState() => _Delivery_completedState();
}

class _Delivery_completedState extends State<Delivery_completed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "FoodBank",
          style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: FontSize.xLarge,
              color: Colors.white),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 50,
              child: Image(
                image: AssetImage(
                  Images.deliverySuccess,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "DELIVERY_COMPLETED".tr,
              style: const TextStyle(
                  // fontWeight: FontWeight.w300,
                  fontSize: FontSize.xLarge,
                  color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
