// Project imports:
import 'package:alanis/export.dart';

class BottomNavigationScreen extends StatefulWidget {
  final int index;

  BottomNavigationScreen(this.index);

  @override
  _BottomNavigationScreenState createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int tabIndex;
  int screenIndex;
  DateTime currentBackPressTime;
  List<Widget> screen = [
    Home(),
    MessagesPage(),
    ProfileDoc(),
    Network(),
    Settings()
  ];

  @override
  void initState() {
    super.initState();
    if (mounted)
      setState(() {
        screenIndex = widget.index;
      });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        bottomNavigationBar: _bottomAppBar(),
        body: screen[screenIndex],
      ),
    );
  }

  Future<bool> onWillPop() {
    if (screenIndex == 0) {
      DateTime now = DateTime.now();
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime) > Duration(seconds: 1)) {
        currentBackPressTime = now;
        HelperWidget.toast(Strings.backgroundApp);
        return Future.value(false);
      }
      return Future.value(true);
    } else {
      if (mounted)
        setState(() {
          screenIndex = 0;
        });
      return Future.value(false);
    }
  }

  _bottomAppBar() {
    return BottomAppBar(
      child: Container(
        height: 60,
        child: Container(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              homeBottomBarItem(),
              Container(
                width: 1,
                height: 30,
                color: Colors.grey,
              ),
              messageBottomBarItem(),
              Container(
                width: 1,
                height: 30,
                color: Colors.grey,
              ),
              profileBottomBarItem(),
              Container(
                width: 1,
                height: 30,
                color: Colors.grey,
              ),
              professionalBottomBarItem(),
              Container(
                width: 1,
                height: 30,
                color: Colors.grey,
              ),
              settingBottomBarItem(),
            ],
          ),
        ),
      ),
    );
  }

  homeBottomBarItem() {
    return Expanded(
      child: TextButton(
        onPressed: () {
          final index = 0;
          if (mounted)
            setState(() {
              screenIndex = index;
            });
        },
        child: Column(
          children: [
            Image.asset(screenIndex == 0 ? Assets.home_selected : Assets.home,
                height: 20),
            SizedBox(height: 3),
            Expanded(
                child: Text(
              Strings.home,
              style: HelperUtility.textStyle(
                fontsize: 10,
                color: screenIndex == 0 ? primaryColor : grey,
              ),
            ))
          ],
        ),
      ),
    );
  }

  messageBottomBarItem() {
    return Expanded(
      child: TextButton(
        onPressed: () {
          final index = 1;
          if (mounted)
            setState(() {
              screenIndex = index;
            });
        },
        child: Column(
          children: [
            Image.asset(
                screenIndex == 1 ? Assets.message_selected : Assets.message,
                height: 20),
            SizedBox(height: 3),
            Text(
              Strings.messages,
              style: HelperUtility.textStyle(
                fontsize: 10,
                color: screenIndex == 1 ? primaryColor : grey,
              ),
            )
          ],
        ),
      ),
    );
  }

  profileBottomBarItem() {
    return Expanded(
      child: TextButton(
        onPressed: () {
          final index = 2;
          if (mounted)
            setState(() {
              screenIndex = index;
            });
        },
        child: Column(
          children: [
            Image.asset(
                screenIndex == 2
                    ? Assets.profile_bottom_selected
                    : Assets.profile_bottom,
                height: 20),
            SizedBox(height: 4),
            Text(
              Strings.textProfile,
              style: HelperUtility.textStyle(
                fontsize: 10,
                color: screenIndex == 2 ? primaryColor : grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  professionalBottomBarItem() {
    return Expanded(
      child: TextButton(
        onPressed: () {
          final index = 3;
          if (mounted)
            setState(() {
              screenIndex = index;
            });
        },
        child: Column(
          children: [
            Image.asset(
                screenIndex == 3
                    ? Assets.professional_selected
                    : Assets.professional,
                height: 20),
            SizedBox(height: 4),
            Expanded(
              child: Text(
                Strings.network,
                style: HelperUtility.textStyle(
                  fontsize: 10,
                  color: screenIndex == 3 ? primaryColor : grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  settingBottomBarItem() {
    return Expanded(
      child: TextButton(
        onPressed: () {
          final index = 4;
          if (mounted)
            setState(() {
              screenIndex = index;
            });
        },
        child: Column(
          children: [
            Image.asset(
                screenIndex == 4 ? Assets.setting_selected : Assets.settings,
                height: 20),
            SizedBox(height: 4),
            Text(
              Strings.settings,
              style: HelperUtility.textStyle(
                fontsize: 10,
                color: screenIndex == 4 ? primaryColor : grey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
