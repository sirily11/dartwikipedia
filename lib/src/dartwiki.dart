import 'dart:async';
import 'package:dio/dio.dart';
import 'package:dartwiki/src/response.dart';

enum WikiLocations { zh, en }

class Wikipedia {
  final StreamController _controller = StreamController<WikiSearchResponse>();
  WikiLocations _wikiLocation = WikiLocations.en;
  final String baseAPI = 'wikipedia.org/w/api.php';
  String wikiAPI = 'wikipedia.org/w/api.php';

  Wikipedia() {
    wikiAPI = 'https://en.' + baseAPI;
  }

  /// Set wiki language
  set wikiLocation(WikiLocations locations) {
    _wikiLocation = locations;
    switch (locations) {
      case WikiLocations.zh:
        wikiAPI = 'https://zh.' + baseAPI;
        break;
      case WikiLocations.en:
        wikiAPI = 'https://en.' + baseAPI;
        break;
    }
  }

  WikiLocations get wikiLocations => _wikiLocation;

  /// A stream which contains the wiki search results
  Stream<WikiSearchResponse> get stream => _controller.stream;

  /// Search wiki by keyword
  Future<WikiSearchResponse> search(String keyword) async {
    var response = await Dio().get(wikiAPI, queryParameters: {
      'action': 'opensearch',
      'search': keyword,
    });

    var data = WikiSearchResponse.fromJSON(response.data);
    _controller.sink.add(data);
    return data;
  }

  /// Get page content by keyword. In order to get the page you want,
  /// please you search method and then use the return keyword to get.
  ///
  /// * [useHtml] get the summary content in html format
  Future<WikiQueryResponse> getPage(String keyword,
      {bool useHtml = false}) async {
    Map<String, String> queryParameters;

    if (!useHtml) {
      queryParameters = {
        'format': 'json',
        'action': 'query',
        'prop': 'extracts',
        'explaintext': '1',
        'titles': keyword,
      };
    } else {
      queryParameters = {
        'format': 'json',
        'action': 'query',
        'prop': 'extracts',
        'titles': keyword,
      };
    }

    var response = await Dio().get(wikiAPI, queryParameters: queryParameters);
    return WikiQueryResponse.fromJson(response.data);
  }
}
