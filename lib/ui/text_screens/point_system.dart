// Project imports:
import 'package:alanis/export.dart';

class PointSystem extends StatefulWidget {
  @override
  _PointSystemState createState() => _PointSystemState();
}

class _PointSystemState extends State<PointSystem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HelperWidget.appBar(
          title: Strings.pointSystem,
          context: context,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                HelperUtility.onBackPress(context: context);
              })),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            text(
                "We appreciate your commitment to Alanis and your engagement with other users. We believe our reward system encourages participation and helps newcomers to understand and engage with the community; so we are all inspired to achieve by women with vision."),
            text(
                "The more you post, the higher your rankings and a beautiful badge will be displayed against your name."),
            text(
                "In the next few months we will be adding new badges and bonuses as our way of saying thank you!"),
            SizedBox(height: 16),
            Row(
              children: [professionalDetail(), risingDetail()],
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  text(text) => Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16),
        child: Column(
          children: [
            Text(text,
                style: HelperUtility.textStyle(
                    fontsize: 14, color: Colors.black87)),
            SizedBox(height: 8)
          ],
        ),
      );

  professionalDetail() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(Strings.professional,
              style: HelperUtility.textStyleBold(fontWeight: FontWeight.bold)),
          HelperWidget.sizeBox(height: Dimens.height_10),
          badgeAndText(Assets.slightblue, "15 Posts", bg15),
          badgeAndText(Assets.slightpurple, "40 Posts", bg40),
          badgeAndText(Assets.slogopink, "70 Posts", bg70),
          badgeAndText(Assets.sdarkteapink, "100 Posts", bg100),
          badgeAndText(Assets.slightpink, "125 Posts", bg125),
        ],
      ),
    );
  }

  risingDetail() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(Strings.risingstars,
              style: HelperUtility.textStyleBold(fontWeight: FontWeight.bold)),
          HelperWidget.sizeBox(height: Dimens.height_10),
          badgeAndText(Assets.rlightblue, "15 Posts", bg15, rising: true),
          badgeAndText(Assets.rlightpurple, "40 Posts", bg40, rising: true),
          badgeAndText(Assets.rlightpink, "70 Posts", bg70, rising: true),
          badgeAndText(Assets.rdarkteapink, "100 Posts", bg100, rising: true),
          badgeAndText(Assets.rldarkpink, "125 Posts", bg125, rising: true),
        ],
      ),
    );
  }

  badgeAndText(assets, text, bgcolor, {bool rising = false}) => Container(
      height: 60,
      color: bgcolor,
      margin: EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            assets,
            height: rising ? 50 : 50,
            width: rising ? 50 : 30,
            fit: rising ? BoxFit.fitHeight : BoxFit.contain,
          ),
          SizedBox(width: 8),
          SizedBox(
            width: 65,
            child: Text(
              text,
              style: HelperUtility.textStyleBold(),
              textAlign: TextAlign.start,
            ),
          )
        ],
      ));
}
