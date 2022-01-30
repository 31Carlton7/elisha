import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class DailyDevotionalService {
  DailyDevotionalService(this._dio);

  final Dio _dio;
  final _rootUrl = 'http://dailyscripture.servantsoftheword.org/readings';
  final _date = DateFormat('MMMd').format(DateTime.now()).toLowerCase().replaceAll(' ', '');
  final _year = DateTime.now().year.toString();

  // Make algorithm to determine date for link above.
  Future<String> get todaysDailyDevotional async {
    final resp = await _dio.get(_rootUrl + '/' + _year + '/' + _date + '.htm');

    var data = (resp.data as String).substring(0, resp.data.indexOf('<font face='));
    data += '</body> </html>';

    data = data.replaceRange(data.indexOf('<h1>'), data.indexOf('<h1>') + 5, '<h1>');
    data = data.replaceRange(data.indexOf('<center>&nbsp;'), data.indexOf('<center>&nbsp;') + 14, '<center>');

    return data.trim();
  }
}
