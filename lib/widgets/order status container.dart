import 'package:flutter/widgets.dart';
import 'package:food_ex_delivery_app/utils/font_size.dart';
import 'package:food_ex_delivery_app/utils/size_config.dart';

class Order_status_container extends StatefulWidget {
  final String statusName;
  final String status_numbers;
  final Color bgColor;
  final Color text_color;
  final Icon icon;
  const Order_status_container(
      {super.key,
      required this.statusName,
      required this.bgColor,
      required this.text_color,
      required this.status_numbers,
      required this.icon});

  @override
  _Order_status_containerState createState() => _Order_status_containerState();
}

class _Order_status_containerState extends State<Order_status_container> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth! / 2.4,
      //     color: widget.bgColor,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: widget.bgColor,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          )),

      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.status_numbers,
                style: TextStyle(
                  fontSize: FontSize.xxLarge,
                  color: widget.text_color,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 1),
              widget.icon,
            ],
          ),
          Text(
            widget.statusName,
            style: TextStyle(
                color: widget.text_color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
