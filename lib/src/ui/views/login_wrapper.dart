import 'package:canton_design_system/canton_design_system.dart';
import 'package:elisha/src/providers/local_user_repository_provider.dart';
import 'package:elisha/src/ui/views/current_view.dart';
import 'package:elisha/src/ui/views/introduction_view/introduction_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginWrapper extends StatefulWidget {
  const LoginWrapper({Key? key}) : super(key: key);

  @override
  State<LoginWrapper> createState() => _LoginWrapperState();
}

class _LoginWrapperState extends State<LoginWrapper> {
  @override
  void initState() {
    super.initState();
    context.read(localUserRepositoryProvider).loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final count = watch(localUserRepositoryProvider).getLoginCount;

        if (count > 1) {
          return const CurrentView();
        }

        return const IntroductionView();
      },
    );
  }
}
