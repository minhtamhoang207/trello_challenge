import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trello_challenge/di.dart';
import 'package:trello_challenge/routes/app_pages.dart';
import 'app_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjection.init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      enableLog: true,
      initialRoute: Routes.splash,
      defaultTransition: Transition.fade,
      getPages: AppPages.pages,
      initialBinding: AppBinding(),
      smartManagement: SmartManagement.keepFactory,
      navigatorObservers: [BotToastNavigatorObserver()],
      theme: ThemeData(
        textTheme: GoogleFonts.beVietnamProTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      builder: BotToastInit(),
    );
  }
}