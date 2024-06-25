import 'package:chat_app/common/widgets/error_screen.dart';
import 'package:chat_app/common/widgets/loader.dart';
import 'package:chat_app/features/auth/controller/auth_controller.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/router.dart';
import 'package:chat_app/screens/mobile_layout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chat_app/common/utils/colors.dart';
import 'package:chat_app/features/auth/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: const AppBarTheme(color: appBarColor),
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) => generateRoute(settings),
      home: ref.watch(userDataAuthProvider).when(
          data: (user) {
            if (user == null) {
              return const LoginScreen();
            }
            return const MobileLayoutScreen();
          },
          error: (error, trace) {
            return ErrorScreen(error: error.toString());
          },
          loading: () => const Loader()),
    );
  }
}
