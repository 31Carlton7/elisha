import 'package:canton_design_system/canton_design_system.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:elisha/src/providers/authentication_providers/authentication_stream_provider.dart';
import 'package:elisha/src/ui/components/something_went_wrong.dart';
import 'package:elisha/src/ui/views/authentication_views/sign_in_providers_view/sign_in_providers_view.dart';
import 'package:elisha/src/ui/views/authentication_views/sign_up_view/sign_up_view.dart';
import 'package:elisha/src/ui/views/current_view.dart';

class AuthenticationWrapper extends StatefulWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  _AuthenticationWrapperState createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  bool showSignIn = true;

  @override
  void initState() {
    super.initState();
  }

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final _authState = watch(authenticationStreamProvider);

        return _authState.when(
          error: (e, s) {
            return const SomethingWentWrong();
          },
          loading: () => Loading(),
          data: (user) {
            if (user == null) {
              if (showSignIn) {
                return SignInProvidersView(toggleView);
              } else {
                return SignUpView(toggleView);
              }
            } else {
              return const CurrentView();
            }
          },
        );
      },
    );
  }
}
