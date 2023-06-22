/*
Elisha iOS & Android App
Copyright (C) 2022 Carlton Aikins

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

import 'package:canton_ui/canton_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirstNameInput extends ConsumerWidget {
  const FirstNameInput({Key? key, required this.firstNameController}) : super(key: key);

  final TextEditingController firstNameController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
