import 'package:canton_design_system/canton_design_system.dart';

class EmailTextInput extends StatelessWidget {
  const EmailTextInput({Key? key, required this.emailController}) : super(key: key);

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(7),
      child: CantonTextInput(
        labelText: 'Email',
        hintText: '',
        isTextFormField: true,
        obscureText: false,
        controller: emailController,
        textInputType: TextInputType.emailAddress,
      ),
    );
  }
}
