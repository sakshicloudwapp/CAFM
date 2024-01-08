import 'package:fm_pro/global/my_string.dart';
import 'package:get/get.dart';

class OnboardingData {
  String image;
  String title;
  String description;
  String color_bottom;

  OnboardingData({required this.image, required this.title, required this.description, required this.color_bottom});
}
List<OnboardingData> contents = [
  OnboardingData(
      title: "Hello Welcome".tr,
      image: 'assets/images/onboarding_one.png',
      description: MyString.Lorem.tr,
      color_bottom: '0xFFF2FBFF'
  ),
  OnboardingData(
      title: 'Lorem Ipsum'.tr,
      image: 'assets/images/onboarding_two.png',
      description: MyString.Lorem.tr,
      color_bottom: '0xFFF2FBFF'
  ),
  OnboardingData(
      title: 'Lorem Ipsum'.tr,
      image: 'assets/images/onboarding_three.png',
      description: MyString.Lorem.tr,
      color_bottom: '0xFFFEF6ED'
  ),
];