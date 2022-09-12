import 'package:cinema_mobile/src/core/connection/preferences_manager.dart';
import 'package:cinema_mobile/src/screens/login_screen.dart';
import 'package:cinema_mobile/src/pages/signup_page.dart';
import 'package:cinema_mobile/src/providers/main_provider.dart';
import 'package:cinema_mobile/src/widgets/movies_details_widget.dart';
import 'package:cinema_mobile/src/screens/home_screen.dart';
import 'package:cinema_mobile/src/widgets/rewards_deatils_widget.dart';
import 'package:cinema_mobile/src/themes/data_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  developer.log('Handling a background message ${message.messageId}');
}

late AndroidNotificationChannel channel;
//Carga del los Notificadores y la aplicaion

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
void main() async {
  // Permite que la aplicacion este bien inicializada
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

Future<bool> loadLoginStatus() async {
  return await PreferenceManager.isLogedIn();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _setupToken();

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? value) => developer.log(value.toString()));

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: 'launch_background',
            ),
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      developer.log('A new onMessageOpenedApp event was published!');
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    return FutureBuilder(
        future: loadLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            try {
              return ScreenUtilInit(
                  designSize: const Size(360, 690),
                  builder: (_) => MaterialApp(
                      debugShowCheckedModeBanner: false,
                      title: 'Flutter Demo',
                      theme: AppTheme.themeData(mainProvider.mode).copyWith(
                          pageTransitionsTheme: const PageTransitionsTheme(
                        builders: <TargetPlatform, PageTransitionsBuilder>{
                          TargetPlatform.android: ZoomPageTransitionsBuilder(),
                        },
                      )),
                      routes: {
                        'singUp': (_) => const SignUpPage(),
                        'home': (_) => const HomeScreen(),
                        'detailsMovies': (_) => const MoviesDetailsScreen(),
                        'detailsRewards': (_) => const RewardsDetailsScreen(),
                      },
                      home: snapshot.data! == false
                          ? const LoginPage()
                          : const HomeScreen()));
            } catch (e) {
              //print(e)
            }
          }
          return const SizedBox.square(
              dimension: 100.0, child: CircularProgressIndicator());
        });
  }
}

_setupToken() async {
  String? token = await FirebaseMessaging.instance.getToken();
  developer.log(token ?? "");
}
