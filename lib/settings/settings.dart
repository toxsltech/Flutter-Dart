// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:alanis/export.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  CustomLoader _customLoader;

  void logoutApiCall() async {
    _customLoader.show(context);
    await APIRepository.logoutApiCall(context).then((value) {
      if (value != null) {
        _customLoader.hide();
        HelperWidget.toast(Strings.logout_);
        PrefManger.saveRegisterData(null);
        HelperUtility.pushAndRemoveUntil(
            route: LoginScreen(), context: context);
      } else {
        _customLoader.hide();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _customLoader = CustomLoader();
  }

  @override
  void dispose() {
    super.dispose();
    _customLoader.hide();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              title: Text(Strings.textChangePassword),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () =>
                  HelperUtility.push(context: context, route: ChangePassword()),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              title: Text(Strings.textNotification),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () => HelperUtility.push(
                  context: context, route: NotificationSetting()),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              title: Text(Strings.aboutus),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () => HelperUtility.push(
                  context: context,
                  route: StaticPages(Strings.aboutus, aboutUsType)),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              title: Text(Strings.pointSystem),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () =>
                  HelperUtility.push(context: context, route: PointSystem()),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              title: Text(Strings.help),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () => HelperUtility.push(
                  context: context, route: StaticPages(Strings.help, helpType)),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              title: Text(Strings.faq),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () => HelperUtility.push(
                  context: context, route: StaticPages(Strings.faq, faqType)),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              title: Text(Strings.privacyPolicy),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () => HelperUtility.push(
                  context: context,
                  route: StaticPages(Strings.privacyPolicy, privacyType)),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              title: Text(Strings.tc),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () => HelperUtility.push(
                  context: context,
                  route: StaticPages(Strings.tc, termAndCondtionType)),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              title: Text(Strings.contactus),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () =>
                  HelperUtility.push(context: context, route: ContactUs()),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              title: Text(Strings.logout),
              onTap: () {
                showAlertDialog(context, logoutApiCall);
              },
            ),
          ],
        ),
      ),
    );
  }

  _appBar() => HelperWidget.appBar(
        title: Strings.settings,
        context: context,
        leading: HelperWidget.getInkwell(
            onTap: () {
              HelperUtility.push(context: context, route: AddPost());
            },
            widget: Padding(
              padding: EdgeInsets.all(5.0),
              child: Image.asset(Assets.add, height: 20),
            )),
      );
}

showAlertDialog(BuildContext context, Function logout) {
  Widget cancelButton = TextButton(
    child: Text(
      Strings.cancel,
      style: HelperUtility.textStyle(color: Colors.red),
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
      child: Text(Strings.continuee),
      onPressed: () {
        Navigator.pop(context);
        logout();
      }
      // logoutApiCall();

      );

  AlertDialog alert = AlertDialog(
    title: Text(Strings.appNameC),
    content: Text(Strings.wantLogout),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
