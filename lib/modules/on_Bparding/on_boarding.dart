import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:socialkom/modules/login/login.dart';
import 'package:socialkom/shared/network/cache_helper.dart';
import 'package:socialkom/shared/styles/color.dart';

class ItemModel {
  final String img;
  final String label;
  final String title;
  ItemModel({required this.img, required this.label, required this.title});
}

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  List<ItemModel> items = [
    ItemModel(
        img: 'image/social2.png',
        label: "Socialkom",
        title:
            "Socialkom is a local social media app that is made specific for you ... \n \n I hope you like it... "),
    ItemModel(
        img: 'image/social1.png',
        label: "Socialkom",
        title:
            "React and activate with your friends feeds ... \n \n posts or stories... "),
    ItemModel(
        img: 'image/social3.png',
        label: "Socialkom",
        title:
            "Socialkom has a hashtags to give your posts more reality  ... \n \n try it on your first post... "),
    ItemModel(
        img: 'image/social4.png',
        label: "Socialkom",
        title:
            "Socialkom makes you more comfortable and secure  ... \n \n I hope you like it... "),
    ItemModel(
        img: 'image/social5.png',
        label: "Socialkom",
        title:
            "Socialkom is cross platform app in android,ios,web,windows,macos, linux... \n try it on all platforms... "),
    ItemModel(
        img: 'image/social6.png',
        label: "Socialkom",
        title:
            "Socialkom makes you online from any place in the earth ... \n \n log in and start now... "),
  ];
  bool isLast = false;
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                submit();
              },
              child: Text(
                "Skip",
                style: TextStyle(color: social2, fontSize: 26),
              ))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
              onPageChanged: (index) {
                if (index == items.length - 1) {
                  setState(() {
                    isLast = true;
                  });
                }
              },
              itemBuilder: (context, index) => onBoardingItem(items[index]),
              itemCount: items.length,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    pageController.previousPage(
                        duration: Duration(milliseconds: 750),
                        curve: Curves.easeInQuart);
                  },
                  icon: Icon(Icons.arrow_back_ios),
                  color: social4,
                ),
                SmoothPageIndicator(
                    controller: pageController,
                    count: items.length,
                    effect: ExpandingDotsEffect(
                        activeDotColor: social4,
                        dotColor: social1,
                        dotHeight: 10,
                        dotWidth: 10,
                        expansionFactor: 3.5,
                        spacing: 9)),
                IconButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      pageController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.easeInQuart);
                    }
                  },
                  icon: Icon(Icons.arrow_forward_ios_rounded),
                  color: social4,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 60,
          )
        ],
      ),
    );
  }

  Widget onBoardingItem(ItemModel model) {
    return Column(
      children: [
        Image(
          image: AssetImage(
            model.img,
          ),
          height: 400,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          model.label,
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
              color: social2),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            model.title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color: social3),
          ),
        ),
      ],
    );
  }

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => Login()), (route) => false);
    });
  }
}
