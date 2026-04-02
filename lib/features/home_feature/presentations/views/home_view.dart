import 'package:countfour_game_app/core/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(AppImages.bacgroundImage2, fit: BoxFit.fill),
          ),
          Positioned.fill(
            top: MediaQuery.of(context).size.height * 0.1,
            child: const Align(
              alignment: Alignment.topCenter,
              child: Text(
                "Count Four Game",
                style: TextStyle(
                  fontSize: 36,
                  color: Colors.white,
                  fontFamily: "FarmhouseChristmas",
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          Positioned.fill(
            bottom: MediaQuery.of(context).size.height * 0.1,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 234,
                height: 75,
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed("/gameview");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff3D41DD),
                  ),
                  child: const Row(
                    children: [
                      Text(
                        "let,s Play",
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.arrow_right_alt,
                        size: 45,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
