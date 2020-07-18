class WikiSearchResponse {
  final List<WikiSearchResults> searchResults;

  WikiSearchResponse({this.searchResults});

  factory WikiSearchResponse.fromJSON(List<dynamic> json) {
    // ignore: omit_local_variable_types
    List<WikiSearchResults> results = [];
    for (var i = 0; i < (json[1] as List).length; i++) {
      String title = json[1][i];
      String url = json[3][i];
      results.add(WikiSearchResults(title: title, url: url));
    }

    return WikiSearchResponse(searchResults: results);
  }

  @override
  String toString() {
    return 'WikiSearchResponse: ${searchResults.length} results';
  }
}

class WikiSearchResults {
  final String title;
  final String url;

  WikiSearchResults({this.title, this.url});

  @override
  String toString() {
    return '$title-$url';
  }
}

class WikiQueryResponse {
  WikiQueryResponse({
    this.batchcomplete,
    this.query,
  });

  String batchcomplete;
  QueryResponse query;

  factory WikiQueryResponse.fromJson(Map<String, dynamic> json) =>
      WikiQueryResponse(
        batchcomplete: json['batchcomplete'],
        query: QueryResponse.fromJson(json['query']),
      );

  Map<String, dynamic> toJson() => {
        'batchcomplete': batchcomplete,
        'query': query.toJson(),
      };
}

class QueryResponse {
  QueryResponse({
    this.pages,
  });

  Map<String, Response> pages;

  factory QueryResponse.fromJson(Map<String, dynamic> json) => QueryResponse(
        pages: Map.from(json['pages'])
            .map((k, v) => MapEntry<String, Response>(k, Response.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        'pages': Map.from(pages)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class Response {
  Response({
    this.extract,
    this.ns,
    this.pageid,
    this.title,
  });

  String extract;
  double ns;
  double pageid;
  String title;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        extract: json['extract'],
        ns: json['ns'].toDouble(),
        pageid: json['pageid'].toDouble(),
        title: json['title'],
      );

  Map<String, dynamic> toJson() => {
        'extract': extract,
        'ns': ns,
        'pageid': pageid,
        'title': title,
      };
}
