import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guidy/controllers/main_screen_controller.dart';
import 'package:guidy/model/offer_model.dart';
import 'package:guidy/view/widgets/custom_offer.dart';

import '../../../../core/constants/AppColors.dart';
import '../../../../core/constants/appTheme.dart';

class ShowShopOffers extends StatelessWidget {
  final String shopId;

  const ShowShopOffers({Key? key, required this.shopId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MainScreenController controller = Get.put(MainScreenController());
    return FutureBuilder<List<OfferModel>>(
      future: controller.getShopOffers(
          shopId: shopId,
          token: controller.myServices.sharedPref.getString("token")!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else {
          final List<OfferModel> offers = snapshot.data!;
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Text(
                              "Offers",
                              style: englishTheme.textTheme.bodyText1!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.gradientDarkColor,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: offers.length,
                        itemBuilder: (context, index) {
                          final OfferModel offer = offers[index];
                          return CustomOfferWidget(
                            offerModel: offer,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
