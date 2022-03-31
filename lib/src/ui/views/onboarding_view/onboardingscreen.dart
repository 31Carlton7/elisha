import 'package:canton_design_system/canton_design_system.dart';
import 'package:elisha/src/ui/views/devotional_page/devotional_page.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SafeArea (
      child: IntroductionScreen(
        pages: [
          PageViewModel(
            title: 'Study',
            body: 'Let the word of God dwell in you richly',
            image: buildImage('assets/images/heart.jpeg'),
            decoration: getPageDecoration()
          ),
          PageViewModel(
            title: 'Pray',
            body: 'Pray without ceasing. The effectual fervent prayer of the righteous man makes tremendous power available',
              image: buildImage('assets/images/heart.jpeg'),
            decoration: getPageDecoration()
          ),
          PageViewModel(
            title: 'Without Distractions',
            body: 'Avoid distractions while you focus on God in the course of your devotion',
              image: buildImage('assets/images/heart.jpeg'),
            decoration: getPageDecoration()
          ),
        ],
        done: Text('Done', style: TextStyle(fontWeight: FontWeight.bold),),
        onDone: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => DevotionalPage())),
        next: MaterialButton(
          onPressed: () {},
          color: Colors.white,
          child: Icon(Icons.arrow_forward_ios_rounded, size: 24, color: Colors.black),
          shape: CircleBorder(),
          padding: EdgeInsets.all(16),
        ),
        globalBackgroundColor: Theme.of(context).primaryColor,
        animationDuration: 700,
        nextFlex: 0,
      ),
   );
  Widget buildImage(String path) =>
      Center(child: Image.asset(path, width: 350));

  DotsDecorator getDotDecorator () => DotsDecorator(
    color: Colors.grey,
    size: Size(12, 12),
    activeColor: Colors.purple,
    activeSize: Size(22, 10),
    activeShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24)
    )

  );

  PageDecoration getPageDecoration() => PageDecoration(
    titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    bodyTextStyle: TextStyle(fontSize: 20),
    bodyPadding: EdgeInsets.all(16).copyWith(bottom: 0),
    imagePadding: EdgeInsets.all(24)
  );
}
