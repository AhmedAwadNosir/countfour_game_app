import 'package:countfour_game_app/core/bindings/main_binding.dart';
import 'package:countfour_game_app/features/home_feature/presentations/views/game_view.dart';
import 'package:countfour_game_app/features/home_feature/presentations/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {
  // this method to hide phone top par and phone navigation controler show it when swap for mini seconds
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const CountFourApp());
}

class CountFourApp extends StatelessWidget {
  const CountFourApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      //GetMaterialApp is not nessasry for stateManagement  but it nessary for routing
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, primarySwatch: Colors.blue),
      getPages: [
        GetPage(
          name: "/homeview",
          page: () => const HomeView(),
        ), //Note name of every page must start with "/"
        GetPage(
          name: "/gameview",
          page: () => Gameview(),
          binding: MainBindings(),
        ), // bindings for conect controler with page
      ],
      initialRoute: "/homeview",
    );
  }
}
