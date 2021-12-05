import 'package:canton_design_system/canton_design_system.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:elisha/src/ui/components/something_went_wrong.dart';
import 'package:elisha/src/ui/providers/authentication_providers/authentication_stream_provider.dart';
import 'package:elisha/src/ui/views/authentication_views/sign_in_view.dart';
import 'package:elisha/src/ui/views/authentication_views/sign_up_view.dart';
import 'package:elisha/src/ui/views/current_view.dart';

class AuthenticationWrapper extends StatefulWidget {
  @override
  _AuthenticationWrapperState createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  bool showSignIn = true;

  @override
  void initState() {
    super.initState();
    useLocalEmulator();
  }

  void useLocalEmulator() {
    var host = 'localhost';
    var firestorePort = 8080;

    FirebaseFirestore.instance.useFirestoreEmulator(host, firestorePort);
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
            return SomethingWentWrong();
          },
          loading: () => Loading(),
          data: (user) {
            if (user == null) {
              if (showSignIn) {
                return SignInView(toggleView);
              } else {
                return SignUpView(toggleView);
              }
            } else {
              return CurrentView();
            }
          },
        );
      },
    );
  }
}