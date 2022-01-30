import 'package:canton_design_system/canton_design_system.dart';
import 'package:elisha/src/models/translation.dart';
import 'package:elisha/src/ui/views/bible_view/components/translation_card.dart';

Future<void> showTranslationsBottomSheet(
  BuildContext context,
  List<Translation> translations,
  void Function(void Function()) setState,
) async {
  return await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    elevation: 0,
    useRootNavigator: true,
    builder: (context) {
      return FractionallySizedBox(
        heightFactor: 0.95,
        widthFactor: 0.75,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 27),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Versions',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 7),
            Expanded(
              child: ListView.separated(
                itemCount: translations.length,
                separatorBuilder: (context, index) {
                  return Responsive.isTablet(context) ? const SizedBox(height: 10) : Container();
                },
                itemBuilder: (context, index) {
                  return TranslationCard(
                    translation: translations[index],
                    index: index + 1,
                    setState: setState,
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
