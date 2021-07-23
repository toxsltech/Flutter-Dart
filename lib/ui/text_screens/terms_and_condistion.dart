// Project imports:
import 'package:alanis/export.dart';

class TermsandCondition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: HelperWidget.appBar(
              title: Strings.termsandCond,
              context: context,
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    HelperUtility.onBackPress(context: context);
                  })),
          body: Center(
            child: Text(
              Strings.nodataFound,
              style: HelperUtility.textStyleBold(color: primaryColor),
            ),
          ),
        ),
      ),
    );
  }
}
