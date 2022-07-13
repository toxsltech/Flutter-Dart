
/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited
 */

import '../../../export.dart';

Widget buildImage(String assetName, {double? width, double? height = 200}) {
  return Container(
    height: height,
    child: Image.asset(
      assetName,
      width: width,
      height: height,
    ),
  );
}

  var pageDecoration =  PageDecoration(
  titleTextStyle: TextStyle(
      fontSize:  FONT_18, color: Colors.black, fontWeight: FontWeight.w400),
  bodyTextStyle: TextStyle(
      fontSize: FONT_18, color: Colors.black, fontWeight: FontWeight.w400),
  descriptionPadding: EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 16.0),
  pageColor: Colors.white,
  imagePadding: EdgeInsets.zero,
);

List<Widget> pages = [
  OnBoardingScreen(
    label:
        "Welcome to Flutter\n\nWhere you can enjoy the reading experience with our app.",
    image: ICON_img1,
    footer: ICON_slider1,
  ),
  OnBoardingScreen(
    label:
        'To start the reading experience, you have to login to Flutter/library, download a book, and then enjoy reading.',
    image: ICON_img2,
    footer: ICON_slider2,
  ),
  OnBoardingScreen(
    label:
        'Print reader provides a customizable reading experience, and other features where you can lend books to friends or family or gift it as a gift.',
    image: ICON_img3,
    footer: ICON_slider3,
  ),
];

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen(
      {Key? key,
      required this.label,
      required this.image,
      required this.footer})
      : super(key: key);
  final String label;
  final String image;
  final String footer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              Spacer(),
              Column(
                children: [
                  buildImage(image),
                  vGap(32),
                  text(label,
                      maxLines: 4,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.center),
                ],
              ),
              Spacer(),
              imageAsset(footer, height: 12, width: 90, fit: BoxFit.contain)
            ],
          ),
        ),
      ),
    );
  }
}
