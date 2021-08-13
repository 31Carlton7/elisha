import 'package:canton_design_system/canton_design_system.dart';
import 'package:elisha/src/ui/providers/authentication_providers/authentication_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountView extends StatelessWidget {
  const AccountView();

  @override
  Widget build(BuildContext context) {
    return CantonScaffold(
      body: _content(context),
    );
  }

  Widget _content(BuildContext context) {
    return Column(
      children: [
        _header(context),
        _signOutButton(context),
      ],
    );
  }

  Widget _header(BuildContext context) {
    return ViewHeaderTwo(
      title: 'Account',
      backButton: true,
    );
  }

  Widget _signOutButton(BuildContext context) {
    return CantonPrimaryButton(
      buttonText: 'Sign Out',
      containerColor: Theme.of(context).colorScheme.onError,
      textColor: Theme.of(context).colorScheme.error,
      containerWidth: MediaQuery.of(context).size.width / 2 - 34,
      onPressed: () {
        context.read(authenticationRepositoryProvider).signOut();
        Navigator.pop(context);
      },
    );
  }
}
