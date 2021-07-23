// /*
//  *  @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
//  *  @author     : Shiv Charan Panjeta < shiv@toxsl.com >
//  *  All Rights Reserved.
//  *  Proprietary and confidential :  All information contained herein is, and remains
//  *  the property of ToXSL Technologies Pvt. Ltd. and its partners.
//  * Unauthorized copying of this file, via any medium is strictly prohibited.
//  */

// Package imports:
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/scheduler.dart';

// Project imports:
import 'export.dart';

Future<void> main() async {
  APIRepository();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light,
  );
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: primaryColor,
  ));
  await PrefManger.getFirstTime().then((value) {
    if (value == null || value == false) DefaultCacheManager().emptyCache();
  });
  PrefManger.isFirstTime(true);
  await Firebase.initializeApp();
  runZonedGuarded<Future<void>>(() async {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    runApp(MyApp());
  }, FirebaseCrashlytics.instance.recordError);
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> implements WidgetsBindingObserver {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  // connection - online or offline
  // final Connectivity _connectivity = Connectivity();

  @override
  void initState() {
    super.initState();

    // Connection Flash
    // _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    flutterLocalNotificationsPlugin.cancelAll();
    FirebaseMessaging.instance
        .requestPermission(alert: true, badge: true, sound: true);
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        sound: true, badge: true, alert: true);
    FirebaseMessaging.instance.getToken().then((value) {
      debugPrint("token $value");
    });

    var androids =
        new AndroidInitializationSettings('drawable/ic_launcher_transparent');
    var ios = new IOSInitializationSettings();
    var platform = new InitializationSettings(android: androids, iOS: ios);

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('A new onMessageOpenedApp event was published! $message');
      SchedulerBinding.instance.addPostFrameCallback((_) {
        switch (message.data['action']) {
          case "follow":
            {
              HelperUtility.push(
                  context: GlobalVariable.navState.currentContext,
                  route: RequestPage(notification: true));
            }
            break;

          case "accept-follow-request":
            {
              HelperUtility.pushNamed(
                  context: GlobalVariable.navState.currentContext,
                  route: Routes.professionalDetail,
                  arguments: {
                    'arg': jsonDecode(message.data['detail'])['created_by_id'],
                    'home': 'notification'
                  });
            }
            break;
          case "send":
            {
              HelperUtility.pushNamed(
                  context: GlobalVariable.navState.currentContext,
                  route: Routes.chatscreen,
                  arguments: {
                    "arg": jsonDecode(message.data['detail'])['created_by_id']
                  });
            }
            break;

          case "comment":
            {
              HelperUtility.pushNamed(
                context: GlobalVariable.navState.currentContext,
                route: Routes.postdetails,
                arguments: {
                  "modelID": jsonDecode(message.data['detail'])['model_id'],
                  'home': 'notification',
                },
              );
            }
            break;

          case "like":
            {
              HelperUtility.pushNamed(
                context: GlobalVariable.navState.currentContext,
                route: Routes.postdetails,
                arguments: {
                  "modelID": jsonDecode(message.data['detail'])['model_id'],
                  'home': 'notification',
                },
              );
            }
            break;

          default:
            {
              Navigator.of(GlobalVariable.navState.currentContext).push(
                  MaterialPageRoute(
                      builder: (context) => BottomNavigationScreen(0)));
            }
            break;
        }
      });
    });

    // foreground - Android

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      debugPrint("fcm message ${message.data}");
      debugPrint("firebase message Recived  ${message.data['action']}");
      debugPrint(
          "firebase message Recived message  ${message.data['message']}");

      var notification = message.data;
      flutterLocalNotificationsPlugin.initialize(platform,
          onSelectNotification: (String data) async {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          switch (message.data['action']) {
            case "follow":
              {
                HelperUtility.push(
                    context: GlobalVariable.navState.currentContext,
                    route: RequestPage(notification: true));
              }
              break;

            case "accept-follow-request":
              {
                HelperUtility.pushNamed(
                    context: GlobalVariable.navState.currentContext,
                    route: Routes.professionalDetail,
                    arguments: {
                      'arg':
                          jsonDecode(message.data['detail'])['created_by_id'],
                      'home': 'notification'
                    });
              }
              break;
            case "send":
              {
                HelperUtility.pushNamed(
                    context: GlobalVariable.navState.currentContext,
                    route: Routes.chatscreen,
                    arguments: {
                      "arg": jsonDecode(message.data['detail'])['created_by_id']
                    });
              }
              break;

            case "comment":
              {
                HelperUtility.pushNamed(
                  context: GlobalVariable.navState.currentContext,
                  route: Routes.postdetails,
                  arguments: {
                    "modelID": jsonDecode(message.data['detail'])['model_id'],
                    'home': 'notification',
                  },
                );
              }
              break;

            case "like":
              {
                HelperUtility.pushNamed(
                  context: GlobalVariable.navState.currentContext,
                  route: Routes.postdetails,
                  arguments: {
                    "modelID": jsonDecode(message.data['detail'])['model_id'],
                    'home': 'notification',
                  },
                );
              }
              break;

            default:
              {
                Navigator.of(GlobalVariable.navState.currentContext).push(
                    MaterialPageRoute(
                        builder: (context) => BottomNavigationScreen(0)));
              }
              break;
          }
        });
      });

      if (Platform.isAndroid) {
        var androidPlatformChannelSpecifics = AndroidNotificationDetails(
          '1',
          'alanis',
          'alanis channel',
          groupKey: "com.app.alanis",
          importance: Importance.max,
          setAsGroupSummary: true,
          playSound: true,
          groupAlertBehavior: GroupAlertBehavior.all,
          enableVibration: true,
        );
        var iOSPlatformChannelSpecifics = IOSNotificationDetails();
        var platformChannelSpecifics = NotificationDetails(
            android: androidPlatformChannelSpecifics,
            iOS: iOSPlatformChannelSpecifics);

        await flutterLocalNotificationsPlugin.show(
            0, "Alanis", message.data['message'], platformChannelSpecifics,
            payload: jsonEncode(notification));
      }
    });

    // On Kill to Resume State

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      if (message != null) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          switch (message.data['action']) {
            case "follow":
              {
                HelperUtility.push(
                    context: GlobalVariable.navState.currentContext,
                    route: RequestPage(notification: true));
              }
              break;

            case "accept-follow-request":
              {
                HelperUtility.pushNamed(
                    context: GlobalVariable.navState.currentContext,
                    route: Routes.professionalDetail,
                    arguments: {
                      'arg':
                          jsonDecode(message.data['detail'])['created_by_id'],
                      'home': 'notification'
                    });
              }
              break;
            case "send":
              {
                HelperUtility.pushNamed(
                    context: GlobalVariable.navState.currentContext,
                    route: Routes.chatscreen,
                    arguments: {
                      "arg": jsonDecode(message.data['detail'])['created_by_id']
                    });
              }
              break;

            case "comment":
              {
                HelperUtility.pushNamed(
                  context: GlobalVariable.navState.currentContext,
                  route: Routes.postdetails,
                  arguments: {
                    "modelID": jsonDecode(message.data['detail'])['model_id'],
                    'home': 'notification',
                  },
                );
              }
              break;

            case "like":
              {
                HelperUtility.pushNamed(
                  context: GlobalVariable.navState.currentContext,
                  route: Routes.postdetails,
                  arguments: {
                    "modelID": jsonDecode(message.data['detail'])['model_id'],
                    'home': 'notification',
                  },
                );
              }
              break;

            default:
              {
                Navigator.of(GlobalVariable.navState.currentContext).push(
                    MaterialPageRoute(
                        builder: (context) => BottomNavigationScreen(0)));
              }
              break;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus.unfocus();
        }
      },
      child: MaterialApp(
        navigatorKey: GlobalVariable.navState,
        debugShowCheckedModeBanner: false,
        title: Strings.appName,
        theme: themeData,
        routes: Routes.routes,
        home: SplashScreen(),
      ),
    );
  }

  @override
  void dispose() {
    flutterLocalNotificationsPlugin.cancelAll();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        flutterLocalNotificationsPlugin.cancelAll();
        break;
      case AppLifecycleState.inactive:
        // Handle this case
        break;
      case AppLifecycleState.paused:
        // Handle this case
        break;
      case AppLifecycleState.detached:
        flutterLocalNotificationsPlugin.cancelAll();
        break;
    }
  }

  @override
  void didChangeAccessibilityFeatures() {
    // TODO: implement didChangeAccessibilityFeatures
  }

  @override
  void didChangeLocales(List<Locale> locales) {
    // TODO: implement didChangeLocales
  }

  @override
  void didChangeMetrics() {
    // TODO: implement didChangeMetrics
  }

  @override
  void didChangePlatformBrightness() {
    // TODO: implement didChangePlatformBrightness
  }

  @override
  void didChangeTextScaleFactor() {
    // TODO: implement didChangeTextScaleFactor
  }

  @override
  void didHaveMemoryPressure() {
    // TODO: implement didHaveMemoryPressure
  }

  @override
  Future<bool> didPopRoute() {
    // TODO: implement didPopRoute
    throw UnimplementedError();
  }

  @override
  Future<bool> didPushRoute(String route) {
    // TODO: implement didPushRoute
    throw UnimplementedError();
  }

  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) {
    // TODO: implement didPushRouteInformation
    throw UnimplementedError();
  }
}

class GlobalVariable {
  /// This global key is used in material app for navigation through firebase notifications.
  /// [navState] usage can be found in [notification_notifier.dart] file.
  static final GlobalKey<NavigatorState> navState = GlobalKey<NavigatorState>();
}
