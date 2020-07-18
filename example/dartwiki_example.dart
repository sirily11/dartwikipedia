import 'package:dartwiki/dartwiki.dart';

void main() async {
  changeLanguage();
}

void changeLanguage() async {
  var wiki = Wikipedia();
  wiki.wikiLocation = WikiLocations.zh;
  var result = await wiki.search('你好世界');
  print(result);
}

void searchUseSteam() async {
  var wiki = Wikipedia();

  wiki.stream.listen((event) {
    print('Get event: $event');
  });
  await wiki.search('hello world');
  await wiki.search('hello world');
}

void queryPage() async {
  var wiki = Wikipedia();
  var results = await wiki.search('hello world');
  var queryResults = await wiki.getPage(results.searchResults[0].title);
  print(queryResults);
}
