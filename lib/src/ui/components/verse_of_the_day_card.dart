import 'package:canton_design_system/canton_design_system.dart';
import 'package:elisha/src/models/verse.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VerseOfTheDayCard extends StatelessWidget {
  const VerseOfTheDayCard({required this.verse, Key? key}) : super(key: key);

  final Verse verse;

  @override
  Widget build(BuildContext context) {
    Color bgColor() {
      if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
        return CantonDarkColors.gray[300]!;
      }
      return CantonColors.gray[300]!;
    }

    return GestureDetector(
      onTap: () {
        CantonMethods.viewTransition(context, Container());
      },
      child: Card(
        color: CantonMethods.alternateCanvasColorType2(context),
        shape: CantonSmoothBorder.defaultBorder(),
        child: Container(
          padding: const EdgeInsets.all(17.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _header(context, bgColor()),
                    const SizedBox(height: 15),
                    _body(context, bgColor(), verse),
                    const SizedBox(height: 15),
                    _bookChapterVerse(context, verse),
                  ],
                ),
              ),
              _favoriteButton(context, bgColor()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context, Color bgColor) {
    return Text(
      'Verse of the Day',
      style: Theme.of(context).textTheme.headline4?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _favoriteButton(BuildContext context, Color bgColor) {
    Color heartColor() {
      if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
        return CantonDarkColors.red[400]!;
      }
      return CantonColors.red[400]!;
    }

    return Container(
      height: 35,
      width: 35,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: bgColor,
      ),
      child: Center(
        child: Icon(
          FontAwesomeIcons.solidHeart,
          size: 19,
          color: heartColor(),
        ),
      ),
    );
  }

  Widget _body(BuildContext context, Color bgColor, Verse verse) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Container(
            width: 4,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 17),
          Expanded(
            child: Text(
              verse.text,
              style: Theme.of(context).textTheme.headline4?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bookChapterVerse(BuildContext context, Verse verse) {
    return Text(
      verse.book.name! + ' ' + verse.chapterId.toString() + ':' + verse.verseId.toString(),
      style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.w500),
    );
  }
}
