import 'package:canton_design_system/canton_design_system.dart';
import 'package:shimmer/shimmer.dart';

class LoadingCard extends StatelessWidget {
  const LoadingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: CantonMethods.alternateCanvasColorType3(context),
      ),
      child: Center(
        child: Shimmer(
          gradient: LinearGradient(colors: [
            Theme.of(context).colorScheme.secondary,
            Theme.of(context).colorScheme.onSecondary,
          ]),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 20,
                color: CantonColors.white,
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 20,
                color: CantonColors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
