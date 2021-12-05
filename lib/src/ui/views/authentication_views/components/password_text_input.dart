import 'package:canton_design_system/canton_design_system.dart';

class PasswordTextInput extends StatelessWidget {
  const PasswordTextInput({Key? key, required this.passwordController}) : super(key: key);

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(7),
      child: CantonTextInput(
        labelText: 'Password',
        hintText: '',
        isTextFormField: true,
        obscureText: true,
        controller: passwordController,
        textInputType: TextInputType.visiblePassword,
      ),
    );
  }
}
