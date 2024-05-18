import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:guidy/controllers/main_screen_controller.dart';
import 'package:guidy/view/widgets/custom_offer.dart';

import '../../../../core/constants/AppColors.dart';
import '../../../../core/constants/appTheme.dart';

class ShowFavorites extends StatelessWidget {
  const ShowFavorites({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MainScreenController());
    return GetBuilder<MainScreenController>(builder: (controller) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
            child: ListView(
              children: [
                Row(
                  children: [
                    Card(
                      elevation: 5,
                      child: Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Text(
                          "Favorites",
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

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8, // Example: 80% of available height
                  child: ListView.builder(
                    itemCount: controller.favorites.length,
                    itemBuilder: (context, index) {
                      final offer = controller.favorites[index].key;
                      final shop = controller.favorites[index].value;
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
    });
  }
}
