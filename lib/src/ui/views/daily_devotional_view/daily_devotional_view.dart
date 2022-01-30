import 'package:canton_design_system/canton_design_system.dart';
import 'package:elisha/src/providers/reader_settings_repository_provider.dart';
import 'package:elisha/src/ui/views/daily_devotional_view/components/daily_devotional_view_header.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_html/flutter_html.dart' as htm;
import 'package:url_launcher/url_launcher.dart';

class DailyDevotionalView extends ConsumerWidget {
  const DailyDevotionalView({Key? key, required this.htmlData}) : super(key: key);

  final String htmlData;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return CantonScaffold(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      backgroundColor: CantonMethods.alternateCanvasColor(context),
      body: _content(context, watch),
    );
  }

  Widget _content(BuildContext context, ScopedReader watch) {
    return Column(
      children: [
        const DailyDevotionalViewHeader(),
        _body(context, watch),
      ],
    );
  }

  Widget _body(BuildContext context, ScopedReader watch) {
    final _scrollController = ScrollController();
    final font = watch(readerSettingsRepositoryProvider).typeFace;

    return Expanded(
      child: Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: htm.Html(
                  style: {
                    'h1': htm.Style(fontSize: const htm.FontSize(32), fontFamily: font),
                    'center': htm.Style(fontSize: const htm.FontSize(20), fontFamily: font),
                    'b': htm.Style(
                      fontSize: const htm.FontSize(18),
                      lineHeight: const htm.LineHeight(1.5),
                      fontFamily: font,
                    ),
                    'p': htm.Style(
                      fontSize: const htm.FontSize(18),
                      lineHeight: const htm.LineHeight(1.85),
                      fontFamily: font,
                    ),
                  },
                  data: htmlData,
                ),
              ),
              const SizedBox(height: 10),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Linkify(
                    onOpen: (link) async {
                      if (await canLaunch(link.url)) {
                        await launch(link.url);
                      } else {
                        throw 'Could not launch $link';
                      }
                    },
                    text:
                        'Daily Devotional is courtesy of © 2022 DAILY SCRIPTURE READINGS AND MEDITATIONS. Their Website is located at https://www.dailyscripture.net/daily-meditation/',
                    style: Theme.of(context).textTheme.headline6,
                    linkStyle: Theme.of(context).textTheme.headline6?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                          decoration: TextDecoration.underline,
                        ),
                  ),
                ),
              ),
              const SizedBox(height: 17),
            ],
          ),
        ),
      ),
    );
  }
}
