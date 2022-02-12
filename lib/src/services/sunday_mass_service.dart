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

class SundayMassService {
  SundayMassService();

  final _churchYouTubeChannelIds = <String>[
    'UCubahKRKNc4cj3sZSAmc-Nw',
    'UCv0TUu1tuIdVqRLFwGlos4A',
    'UCa7SbIMVl5UHycxUbHOpmow',
    'UCi6JtCVy4XKu4BSG-AE2chg',
  ];

  List<String> get getChurchYouTubeChannelIds => _churchYouTubeChannelIds;
}
