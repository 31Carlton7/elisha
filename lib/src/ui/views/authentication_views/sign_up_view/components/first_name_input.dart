import 'package:canton_design_system/canton_design_system.dart';

class FirstNameInput extends StatelessWidget {
  const FirstNameInput({Key? key, required this.firstNameController}) : super(key: key);

  final TextEditingController firstNameController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(7),
      width: MediaQuery.of(context).size.width / 2 - 44,
      child: CantonTextInput(
        hintText: '',
        labelText: 'First Name',
        isTextFormField: true,
        obscureText: false,
        controller: firstNameController,
        textInputType: TextInputType.name,
      ),
    );
  }
}
