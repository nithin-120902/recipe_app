import 'dart:convert';

import '../service/model.dart';

import 'package:http/http.dart' as http;

class HomepageRepository{

  late List<Model> suggestionList=[];

  Future<List<Model>?> getHomepageData() async{

    var url =
            "https://api.edamam.com/search?q=&app_id=292ff540&app_key=389aa8ecd494756a7cef3337a9b4b9a4&from=0&to=100&calories=591-722&health=alcohol-free";
    var response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      Map json = jsonDecode(response.body);
        json['hits'].forEach((e) {
          Model model = Model(
              url: e['recipe']['url'],
              image: e['recipe']['image'],
              source: e['recipe']['source'],
              label: e['recipe']['label']);
          suggestionList.add((model));
        });
      return suggestionList;
    }
    else{
      throw Exception(response.reasonPhrase);
    }
  }
}