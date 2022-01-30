import 'package:canton_design_system/canton_design_system.dart';
import 'package:elisha/src/models/book.dart';
import 'package:elisha/src/models/verse.dart';
import 'package:elisha/src/providers/local_user_repository_provider.dart';
import 'package:elisha/src/providers/study_tools_repository_provider.dart';
import 'package:elisha/src/ui/views/verse_of_the_day_view/verse_of_the_day_view.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerseOfTheDayCard extends StatefulWidget {
  const VerseOfTheDayCard({this.verses, Key? key}) : super(key: key);

  final List<Verse>? verses;

  @override
  State<VerseOfTheDayCard> createState() => _VerseOfTheDayCardState();
}

class _VerseOfTheDayCardState extends State<VerseOfTheDayCard> {
  var _isFavorite = false;
  List<Verse>? _verses = [];

  @override
  void initState() {
    super.initState();
    _checkIfVerseIsNull();
    _checkIfVerseIsFavorite();
  }

  void _checkIfVerseIsFavorite() {
    _isFavorite = context.read(studyToolsRepositoryProvider).favoriteVerses.where((e) {
      return widget.verses!.any((element) => e.text == element.text);
    }).isNotEmpty;
  }

  void _checkIfVerseIsNull() {
    _verses = widget.verses;
    _verses ??= [
      Verse(
        id: 40028020,
        chapterId: 28,
        verseId: 20,
        text:
            'teaching them to observe all things whatsoever I have commanded you: and, lo, I am with you alway, even unto the end of the world. Amen.',
        book: Book(
          id: 40,
          name: 'Matthew',
          testament: 'New',
          chapters: [],
        ),
        favorite: false,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    const elementSpacing = 17.0;
    Color bgColor() {
      if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
        return CantonDarkColors.gray[800]!;
      }
      return CantonColors.gray[300]!;
    }

    return Consumer(
      builder: (context, watch, child) {
        return GestureDetector(
          onTap: () {
            CantonMethods.viewTransition(context, VerseOfTheDayView(verses: widget.verses!));
          },
          child: Container(
            padding: const EdgeInsets.all(17.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: CantonMethods.alternateCanvasColorType3(context),
            ),
            child: Column(
              children: [
                _buildImage(context),
                const SizedBox(height: elementSpacing),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _header(context, bgColor()),
                          const SizedBox(height: elementSpacing),
                          _body(context, bgColor()),
                          const SizedBox(height: elementSpacing),
                          _bookChapterVerse(context),
                        ],
                      ),
                    ),
                    _favoriteButton(context, bgColor(), widget.verses!),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildImage(BuildContext context) {
    var imagePath = context.read(localUserRepositoryProvider).getNatureImage;

    final imageWidget = ClipRRect(
      borderRadius: BorderRadius.circular(7),
      child: Image.asset(
        imagePath,
        fit: BoxFit.fitWidth,
        height: 140,
        width: MediaQuery.of(context).size.width,
        errorBuilder: (_, __, ___) {
          return Container();
        },
      ),
    );

    return imageWidget;
  }

  Widget _header(BuildContext context, Color bgColor) {
    return Text(
      'Verse of the Day',
      style: Theme.of(context).textTheme.headline4?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _favoriteButton(BuildContext context, Color bgColor, List<Verse> verses) {
    return Consumer(
      builder: (context, watch, child) {
        Color heartColor() {
          if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
            return CantonDarkColors.red[400]!;
          }
          return CantonColors.red[400]!;
        }

        Icon icon() {
          if (watch(studyToolsRepositoryProvider).favoriteVerses.where((e) {
            return widget.verses!.any((element) => e.text == element.text);
          }).isNotEmpty) {
            return Icon(LineAwesomeIcons.heart_1, size: 24, color: heartColor());
          }
          return Icon(LineAwesomeIcons.heart, size: 24, color: Theme.of(context).colorScheme.primary);
        }

        return GestureDetector(
          onTap: () async {
            HapticFeedback.mediumImpact();

            setState(() {
              _isFavorite = !_isFavorite;
            });

            for (Verse item in verses) {
              if (_isFavorite) {
                await context.read(studyToolsRepositoryProvider).addFavoriteVerse(item);
              } else {
                await context.read(studyToolsRepositoryProvider).removeFavoriteVerse(item);
              }
            }
          },
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.secondary,
            ),
            child: Center(
              child: icon(),
            ),
          ),
        );
      },
    );
  }

  Widget _body(BuildContext context, Color bgColor) {
    String verseText() {
      var str = '';
      for (Verse item in widget.verses!) {
        str += item.text + ' ';
      }
      return str.substring(0, str.length);
    }

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
              verseText(),
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
              style: Theme.of(context).textTheme.headline5?.copyWith(
                    color: widget.verses == null ? Theme.of(context).colorScheme.error : null,
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bookChapterVerse(BuildContext context) {
    String versesString() {
      if (widget.verses != null) {
        var str = '';
        if (widget.verses!.length > 1) {
          str = widget.verses!.first.verseId.toString() + ' - ' + widget.verses!.last.verseId.toString();
        } else {
          str = widget.verses![0].verseId.toString();
        }

        return str;
      }
      return '';
    }

    return Text(
      widget.verses == null
          ? 'Matthew 28:20'
          : widget.verses![0].book.name! + ' ' + widget.verses![0].chapterId.toString() + ':' + versesString(),
      style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.w500),
    );
  }
}
