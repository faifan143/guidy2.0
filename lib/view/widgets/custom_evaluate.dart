
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:guidy/controllers/main_screen_controller.dart';

import '../../model/shop_model.dart';

class CustomEvaluateWidget extends GetView<MainScreenController> {
  CustomEvaluateWidget({
    Key? key,
    required this.shopModel,
  }) : super(key: key);
  final ShopModel shopModel;

  final TextEditingController pricesFeedbackController =
  TextEditingController();
  final TextEditingController productsQualityFeedbackController =
  TextEditingController();
  final TextEditingController serviceQualityFeedbackController =
  TextEditingController();
  String overallRating = "3" ;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Shop Evaluation :"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: pricesFeedbackController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Prices',
              ),
            ),
            TextField(
              controller: productsQualityFeedbackController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Products Quality',
              ),
            ),
            TextField(
              controller: serviceQualityFeedbackController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Services Quality',
              ),
            ),
            SizedBox(
              height: 35.h,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Overall Rating :"),
            ),
            SizedBox(
              height: 5.h,
            ),
            RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                overallRating = rating.toString();
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
            controller.evaluateShop(
                context: context,
                shopModel: shopModel,
                pricesFB: pricesFeedbackController.text.trim(),
                productsFB: productsQualityFeedbackController.text.trim(),
                serviceFB: serviceQualityFeedbackController.text.trim(),
                overall: overallRating);
          },
          child: const Text('Evaluate'),
        ),
      ],
    );
  }
}
