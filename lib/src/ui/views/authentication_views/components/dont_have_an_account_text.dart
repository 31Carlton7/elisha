import 'package:canton_design_system/canton_design_system.dart';

class DontHaveAnAccountText extends StatelessWidget {
  const DontHaveAnAccountText({Key? key, this.toggleView}) : super(key: key);

  final Function()? toggleView;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don\'t have an account? ',
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                color: Theme.of(context).colorScheme.secondaryVariant,
                fontWeight: FontWeight.w500,
              ),
        ),
        GestureDetector(
          onTap: () {
            toggleView!();
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Create Account',
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
