import 'package:canton_design_system/canton_design_system.dart';
import 'package:elisha/src/providers/local_user_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChangeFirstNameCard extends StatelessWidget {
  const ChangeFirstNameCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController();

    String currentNameStr() {
      return 'Current First Name: ' + context.read(localUserRepositoryProvider).getUser.firstName;
    }

    return CantonExpansionTile(
      title: Text(
        'Change First Name',
        style: Theme.of(context).textTheme.headline6,
      ),
      decoration: BoxDecoration(
        color: CantonMethods.alternateCanvasColorType2(context),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
      ),
      backgroundColor: CantonMethods.alternateCanvasColor(context),
      iconColor: Theme.of(context).colorScheme.primary,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                currentNameStr(),
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(height: 10),
              CantonTextInput(
                isTextFormField: true,
                obscureText: false,
                hintText: '',
                controller: _controller,
                containerPadding: const EdgeInsets.all(7),
              ),
              const SizedBox(height: 17),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CantonPrimaryButton(
                    buttonText: 'Confirm',
                    color: Theme.of(context).colorScheme.primary,
                    textColor: Theme.of(context).colorScheme.onBackground,
                    containerWidth: 100,
                    containerHeight: 30,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    onPressed: () {
                      final updatedUser =
                          context.read(localUserRepositoryProvider).getUser.copyWith(firstName: _controller.text);
                      context.read(localUserRepositoryProvider).updateUser(updatedUser);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
