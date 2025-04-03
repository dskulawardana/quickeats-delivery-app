import 'package:flutter/material.dart';
import 'package:food_ex_delivery_app/utils/font_size.dart';
import 'package:food_ex_delivery_app/utils/images.dart';
import 'package:food_ex_delivery_app/utils/theme_colors.dart';
import 'package:get/get.dart';

class NoOrderFound extends StatefulWidget {
  const NoOrderFound({super.key});

  @override
  _NoOrderFoundPageState createState() => _NoOrderFoundPageState();
}

class _NoOrderFoundPageState extends State<NoOrderFound> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Images.noOrder),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                'NO_ORDER_FOUND_YET'.tr,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ThemeColors.baseThemeColor,
                    fontSize: FontSize.xLarge),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
