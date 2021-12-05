import 'package:canton_design_system/canton_design_system.dart';

class LastNameInput extends StatelessWidget {
  const LastNameInput({Key? key, required this.lastNameController}) : super(key: key);

  final TextEditingController lastNameController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(7),
      width: MediaQuery.of(context).size.width / 2 - 44,
      child: CantonTextInput(
        hintText: '',
        labelText: 'Last Name',
        isTextFormField: true,
        obscureText: false,
        controller: lastNameController,
        textInputType: TextInputType.name,
      ),
    );
  }
}
