import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/network/cache_helper.dart';
import '../../shared/styles/color.dart';
import '../login/login.dart';

class liquidOnBoarding extends StatefulWidget {
  const liquidOnBoarding({Key? key}) : super(key: key);

  @override
  State<liquidOnBoarding> createState() => _liquidOnBoardingState();
}

class _liquidOnBoardingState extends State<liquidOnBoarding> {
  LiquidController liquid = LiquidController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          LiquidSwipe(
            liquidController: liquid,
            enableSideReveal: true,
            slideIconWidget: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPageChangeCallback: (index) {
              setState(() {});
            },
            pages: [
              buildItem(
                  color: Colors.black,
                  img: 'image/social2.png',
                  title:
                      "Socialkom is a local social media app that is made specific for you ... \n \n I hope you like it... "),
              buildItem(
                  color: Color(0xff0b554c),
                  img: 'image/social1.png',
                  title:
                      "React and activate with your friends feeds ... \n \n posts or stories... "),
              buildItem(
                  color: Color(0xff592386),
                  img: 'image/social3.png',
                  title:
                      "Socialkom has a hashtags to give your posts more reality  ... \n \n try it on your first post... "),
              buildItem(
                  color: Colors.blueGrey,
                  img: 'image/social4.png',
                  title:
                      "Socialkom makes you more comfortable and secure  ... \n \n I hope you like it... "),
              buildItem(
                  color: Color(0xff7b087a),
                  img: 'image/social5.png',
                  title:
                      "Socialkom is cross platform app in android,ios,web,windows,macos, linux... \n try it on all platforms... "),
              buildItem(
                  color: Color(0xff0b3855),
                  img: 'image/social6.png',
                  title:
                      "Socialkom makes you online from any place in the earth ... \n \n log in and start now... "),
            ],
          ),
          Positioned(
            bottom: 10,
            left: 16,
            right: 32,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      submit();
                    },
                    child: Text(
                      "Skip",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                AnimatedSmoothIndicator(
                  activeIndex: liquid.currentPage,
                  count: 6,
                  effect: ExpandingDotsEffect(
                      activeDotColor: social4,
                      dotColor: social1,
                      dotHeight: 13,
                      dotWidth: 13,
                      expansionFactor: 3.5,
                      spacing: 9),
                  onDotClicked: (index) {
                    liquid.animateToPage(page: index);
                  },
                ),
                TextButton(
                    onPressed: () {
                      final page = liquid.currentPage + 1;
                      if (page == 6)
                        submit();
                      else
                        liquid.animateToPage(page: page > 6 ? 0 : page);
                    },
                    child: Text(
                      "Next",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildItem({
    required String img,
    String label = "Socialkom",
    required String title,
    required Color color,
  }) {
    return Container(
      color: color,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 550,
            child: Image(
              image: AssetImage(
                img,
              ),
              height: 400,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            label,
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
                color: social1),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            title,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color: social1),
          ),
        ],
      ),
    );
  }

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => Login()), (route) => false);
    });
  }
}
