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

class UnexpectedError extends ConsumerWidget {
  const UnexpectedError(this.provider, {Key? key}) : super(key: key);

  final AutoDisposeFutureProvider provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Oops, something unexpected happened :(',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(height: 20),
          CantonPrimaryButton(
            buttonText: 'Retry',
            color: Theme.of(context).colorScheme.primary,
            textColor: Theme.of(context).colorScheme.onBackground,
            borderRadius: BorderRadius.circular(27.5),
            containerWidth: MediaQuery.of(context).size.width / 2 - 90,
            containerHeight: 45,
            padding: EdgeInsets.zero,
            onPressed: () => ref.refresh(provider),
          ),
        ],
      ),
    );
  }
}
