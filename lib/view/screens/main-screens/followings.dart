import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:guidy/controllers/main_screen_controller.dart';
import 'package:guidy/core/constants/AppColors.dart';
import 'package:guidy/core/constants/appTheme.dart';
import 'package:guidy/view/widgets/custom_shop.dart';

class FollowingScreen extends GetView<MainScreenController> {
  const FollowingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(MainScreenController());
    return GetBuilder<MainScreenController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
        child: Column(
          children: [
            Row(
              children: [
                Card(
                  elevation: 5,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      "Following".tr,
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
            controller.followings.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: controller.followings.isNotEmpty
                          ? controller.followings.length
                          : 0,
                      itemBuilder: (context, index) {
                        return SizedBox(
                            width: 300.w,
                            child: CustomShopWidget(
                                shopModel: controller.followings[index], isProfile: false,
                                ));
                      },
                    ),
                  )
                : Expanded(
                  child: Center(
                      child: Text(
                        "No Shops",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ),
                ),
            SizedBox(
              height: 100.h,
            ),
          ],
        ),
      );
    });
  }
}
