/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

// Project imports:
import 'package:alanis/export.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 2));
    animation =
        new CurvedAnimation(parent: animationController, curve: Curves.easeOut);
    animation.addListener(() => this.setState(() {}));
    animationController.forward();
    if (mounted)
      setState(() {
        _visible = !_visible;
      });

    _navigateToNextScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
        child: Image.asset(
          Assets.icBackGround,
          fit: BoxFit.fill,
          width: HelperUtility.fullWidthScreen(context: context),
          height: HelperUtility.fullheightcreen(context: context),
        ),
      ),
      Align(
        alignment: Alignment.center,
        child: Container(
          width: animation.value * 300.0,
          height: animation.value * 300.0,
          alignment: Alignment.center,
          child: Image.asset(
            Assets.splashIconnew,
            fit: BoxFit.fill,
          ),
        ),
      ),
    ]));
  }

  /*============================================== Hold this screen for 5 second, after going to Next Route ======================================================= */

  _navigateToNextScreen() => Timer(
        Duration(seconds: 5),
        () async => PrefManger.getRegisterData().then(
          (value) {
            if (value == null) {
              HelperUtility.pushAndRemoveUntil(
                  context: context, route: LoginScreen());
            } else if (value.checkProfessionalDetail == false &&
                value.checkRisingDetail == false) {
              HelperUtility.pushAndRemoveUntil(
                  context: context, route: LoginScreen());
            } else {
              HelperUtility.pushAndRemoveUntil(
                  context: context, route: BottomNavigationScreen(0));
            }
          },
        ),
      );
}
