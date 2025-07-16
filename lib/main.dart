import 'package:flutter/material.dart';
import 'package:frqncy_app/src/config/routes.dart';
import 'package:frqncy_app/src/config/theme.dart';
import 'package:frqncy_app/src/screens/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'firebase_options.dart';
import 'package:adapty_flutter/adapty_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.frqncy.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

    @override
  void initState() {
    super.initState();
    _initializeAdapty();
  }

  Future<void> _initializeAdapty() async {
    try {
      await Adapty().activate(
        configuration: AdaptyConfiguration(apiKey: 'public_live_TePyjO2a.ds83rB2srxSycxY6IU5U')
          ..withLogLevel(AdaptyLogLevel.debug)  // Use debug for testing
          ..withObserverMode(false)  // Set to true if you handle purchases yourself
          ..withCustomerUserId(null)  // Optional: set user ID
          ..withIpAddressCollectionDisabled(false)
          ..withAppleIdfaCollectionDisabled(false)
          ..withGoogleAdvertisingIdCollectionDisabled(false),
      );
      print('Adapty initialized successfully');
    } catch (e) {
      print('Error initializing Adapty: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(440, 956),
      minTextAdapt: true,
      builder: (context, child) => child!,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FRQNCY',
        theme: theme,
        routes: routes,
        home: SplashScreen(),
        // initialRoute: HomeScreen.routeName,
      ),
    );
  }
}
