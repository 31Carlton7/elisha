import 'package:canton_design_system/canton_design_system.dart';
import 'package:elisha/src/ui/views/sunday_mass_view/sunday_mass_view.dart';

class SundayMassCard extends StatelessWidget {
  const SundayMassCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CantonMethods.viewTransition(context, const SundayMassView());
      },
      child: Card(
        color: CantonMethods.alternateCanvasColorType2(context),
        shape: CantonSmoothBorder.defaultBorder(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildVideoImage(context),
              const SizedBox(height: 15),
              Text(
                'Sunday Mass',
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: 7),
              Text(
                'SERVICE FOR THE FOURTH SUNDAY OF ADVENT',
                style: Theme.of(context).textTheme.overline?.copyWith(
                      letterSpacing: 2,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).primaryColor,
                    ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Join Sunday Service today by watching today\'s mass',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVideoImage(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(7),
          child: Image.network(
            'https://img.youtube.com/vi/2jNNnbJo1aI/0.jpg',
            fit: BoxFit.fitWidth,
            height: 100,
            width: MediaQuery.of(context).size.width,
            errorBuilder: (_, __, ___) {
              return Container();
            },
            loadingBuilder: (_, child, progress) {
              if (progress == null) return child;

              return Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              );
            },
          ),
        ),
        const Icon(FeatherIcons.playCircle, color: CantonColors.white, size: 24),
      ],
    );
  }
}
