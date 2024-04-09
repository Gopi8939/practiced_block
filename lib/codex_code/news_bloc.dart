import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'news_info.dart';

enum NewsAction { fetch, delete }

class NewsBloc {
  final _stateStreamController = StreamController<List<Article>>();
  //Input
  StreamSink<List<Article>> get _newsSink => _stateStreamController.sink;
  //Output
  Stream<List<Article>> get newsStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<NewsAction>();
  //Input
  StreamSink<NewsAction> get eventSink => _eventStreamController.sink;
  //Output
  Stream<NewsAction> get _eventStream => _eventStreamController.stream;
  NewsBloc() {
    _eventStream.listen((event) async {
      if (event == NewsAction.fetch) {
        try {
          var news = await getNews();
          if (news != null) _newsSink.add(news.articles);
        } on Exception catch (e) {
          _newsSink.addError("Something went wrong");
        }
      }
    });
  }
  Future<NewsModel> getNews() async {
    var client = http.Client();
    var newsModel;

    try {
      var url = Uri.parse(
          "http://newsapi.org/v2/everything?domains=wsj.com&apiKey=dc76fb455716439ca165a36f18be7785");
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        log(jsonMap.toString());

        newsModel = NewsModel.fromJson(jsonMap);
      }
    } on Exception catch (e) {
      log(e.toString());
    }
    return newsModel;
  }
}
