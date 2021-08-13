import 'package:canton_design_system/canton_design_system.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:elisha/src/models/chapter.dart';
import 'package:elisha/src/ui/providers/bookmarked_chapters_provider.dart';

class BookmarkedChapterView extends StatefulWidget {
  const BookmarkedChapterView(this.chapter);

  final Chapter chapter;

  @override
  _BookmarkedChapterViewState createState() => _BookmarkedChapterViewState();
}

class _BookmarkedChapterViewState extends State<BookmarkedChapterView> {
  @override
  Widget build(BuildContext context) {
    return CantonScaffold(
      body: _content(context),
    );
  }

  Widget _content(BuildContext context) {
    List<Widget> children = [];
    List<InlineSpan> spans = [];
    children.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Text.rich(
          TextSpan(
            children: spans,
          ),
          style: Theme.of(context).textTheme.headline5!.copyWith(
                fontWeight: FontWeight.w400,
                height: 1.85,
              ),
        ),
      ),
    );
    for (int i = 0; i < widget.chapter.verses!.length; i++) {
      var item = widget.chapter.verses![i];

      spans.add(
        TextSpan(
          text: item.verseId!.toString() + ' ',
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                color: Theme.of(context).colorScheme.secondaryVariant,
              ),
        ),
      );

      spans.add(TextSpan(text: item.text!));

      if (!(i == widget.chapter.verses!.length - 1)) {
        spans.add(TextSpan(text: ' '));
      }
    }
    return Column(
      children: [
        _header(context),
        SizedBox(height: 10),
        Expanded(
          child: ListView(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _header(BuildContext context) {
    String name() {
      return widget.chapter.verses![0].book!.name! +
          ' ' +
          widget.chapter.number!;
    }

    return ViewHeaderTwo(
      title: name(),
      backButton: true,
      buttonTwo: CantonHeaderButton(
        onPressed: () {
          _showBookmarkedChapterOptionsBottomSheet(widget.chapter);
        },
        icon: IconlyIcon(
          IconlyBold.MoreCircle,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Future<void> _showBookmarkedChapterOptionsBottomSheet(Chapter chapter) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      elevation: 0,
      useRootNavigator: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.only(top: 15),
          child: FractionallySizedBox(
            heightFactor: 0.35,
            child: Column(
              children: [
                Container(
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10, left: 27, right: 27),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel',
                          style:
                              Theme.of(context).textTheme.headline6?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondaryVariant,
                                  ),
                        ),
                      ),
                      Spacer(flex: 7),
                      Text(
                        'Options',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Spacer(flex: 10),
                    ],
                  ),
                ),
                Divider(height: 30),
                Container(
                  padding: const EdgeInsets.only(top: 15, left: 27, right: 27),
                  child: Column(
                    children: [
                      CantonPrimaryButton(
                        buttonText: 'Remove',
                        containerColor: Theme.of(context).colorScheme.onError,
                        textColor: Theme.of(context).colorScheme.error,
                        onPressed: () {
                          context
                              .read(bookmarkedChaptersProvider.notifier)
                              .removeChapter(chapter);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
