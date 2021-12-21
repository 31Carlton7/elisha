import 'package:canton_design_system/canton_design_system.dart';
import 'package:elisha/src/ui/views/sunday_mass_view/components/sunday_mass_view_header.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SundayMassView extends StatelessWidget {
  const SundayMassView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CantonScaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: _content(context),
    );
  }

  Widget _content(BuildContext context) {
    final ytController = YoutubePlayerController(
      initialVideoId: '2jNNnbJo1aI',
      flags: const YoutubePlayerFlags(autoPlay: true, enableCaption: true),
    );
    return Column(
      children: [
        const SundayMassViewHeader(),
        ClipRRect(
          borderRadius: BorderRadius.circular(7),
          child: YoutubePlayer(
            controller: ytController,
            liveUIColor: Theme.of(context).primaryColor,
            bufferIndicator: Loading(),
            progressColors: ProgressBarColors(
              playedColor: Theme.of(context).primaryColor,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              handleColor: Theme.of(context).primaryColor,
              bufferedColor: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
