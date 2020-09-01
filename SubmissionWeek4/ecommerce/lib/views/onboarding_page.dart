import 'package:ecommerce/models/shared_preferenced.dart';
import 'package:ecommerce/utils/onboarding.dart';
import 'package:ecommerce/views/login.dart';
import 'package:flutter/material.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  DataShared _dataShared = DataShared();

  final List<Introduction> list = [
    Introduction(
      title: 'Receive Money',
      subTitle: '',
      imageUrl: 'assets/images/shop_app.png',
    ),
    Introduction(
      title: 'Buy & Sell',
      subTitle: '',
      imageUrl: 'assets/images/select_item.png',
    ),
    Introduction(
      title: 'Delivery',
      subTitle: '',
      imageUrl: 'assets/images/delivery.png',
    ),
    Introduction(
      title: 'Finish',
      subTitle: '',
      imageUrl: 'assets/images/business.png',
    ),
  ];

  Future _setOnBoarding() async {
    await _dataShared.setValueOnboarding(true);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    return IntroScreenOnboarding(
      introductionList: list,
      onTapSkipButton: () {
        _setOnBoarding();
      },
    );
  }
}
