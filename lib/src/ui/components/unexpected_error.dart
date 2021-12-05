import 'package:canton_design_system/canton_design_system.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UnexpectedError extends StatelessWidget {
  const UnexpectedError(this.provider, {Key? key}) : super(key: key);

  final AutoDisposeFutureProvider provider;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Oops, something unexpected happened :(',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5?.copyWith(
                  color: Theme.of(context).colorScheme.secondaryVariant,
                ),
          ),
          const SizedBox(height: 20),
          CantonPrimaryButton(
            buttonText: 'Retry',
            color: Theme.of(context).primaryColor,
            textColor: CantonColors.white,
            containerWidth: MediaQuery.of(context).size.width / 2 - 74,
            onPressed: () => context.refresh(provider),
          ),
        ],
      ),
    );
  }
}
