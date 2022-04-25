import 'dart:async';

import 'package:canton_design_system/canton_design_system.dart';
import 'package:elisha/src/theme/apptheme.dart';
import 'package:elisha/src/ui/views/current_view.dart';
import 'package:elisha/src/ui/views/home_view/home_view.dart';
import 'package:elisha/src/ui/views/note_view/note_view.dart';
import 'package:elisha/src/ui/views/onboarding_view/onboardingScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {

}
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;
  late SharedPreferences? prefs;

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
//    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    super.initState();
    _controller =
    AnimationController(vsync: this, duration: Duration(seconds: 5))
      ..repeat(reverse: true);
    _animation = CurvedAnimation(parent: _controller!, curve: Curves.easeIn);
    check();
  }

  void check() async {
    prefs = await SharedPreferences.getInstance();

    //first check if is first time (for onboarding) and check if logged in.

    Timer(
        Duration(seconds: 3),
            () => isFirstTime().then((isFirstTime) {
          print("Is First time?: " + isFirstTime.toString());
          isFirstTime
              ? Navigator.pushReplacement(
              context,
              PageTransition(
                  duration: Duration(milliseconds: 6000),
                  type: PageTransitionType.fade,
                  child: OnBoardingScreen()))
              : Navigator.pushReplacement(
              context,
              PageTransition(
                  duration: Duration(milliseconds: 600),
                  type: PageTransitionType.fade,
                  child: CurrentView()));
        }));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height,
      color: AppTheme.kPrimaryColor,
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: Color.fromRGBO(3, 3, 70, 1),
            body: Column(
              children: [
                Expanded(
                  child: FadeTransition(
                    opacity: _animation!,
                    child: Center(
                      child: Image.asset(
                        'assets/images/app_icon.png',
                        width: 300.0,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Future<bool> isFirstTime() async {
    var isFirstTime = prefs!.getBool('onboarded');
    print("Onboarded?: " + isFirstTime.toString());
    if (isFirstTime != null && isFirstTime) {
      return false;
    } else {
      return true;
    }
  }
}
