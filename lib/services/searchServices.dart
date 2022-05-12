import 'dart:convert';
import 'storage.dart';

class SearchServices{
  static setHistoryList(keywords) async{
    /*

    1. get data in local disk (searchList)
    2. check if the loaded data is empty
      2.1 if not empty
        1. load data
        2.
     */
    String? searchList = await Storage.getString("searchList");
    if (searchList != null) {
      List searchListData = json.decode(searchList);
      var hasData = searchListData.any((v){
        return v == keywords;
      });
      if (!hasData){
        searchListData.add(keywords);
        print("add ${keywords}");
        await Storage.setString('searchList', json.encode(searchListData));
      }
    } else{
      List tempList = [];
      tempList.add(keywords);
      print("add 1st ${keywords}");
      await Storage.setString('searchList', json.encode(tempList));
    }

  }
  static getHistoryList() async{
    String? searchList = await Storage.getString("searchList");
    // print(searchList);
    if (searchList != null) {
      return json.decode(searchList);
      }

    return [];
    }

  static clearHistoryList() async{
    await Storage.remove('searchList');
  }

  static removeHistoryList(keywords) async{
    String? searchList = await Storage.getString("searchList");
    if (searchList != null) {
      List searchListData = json.decode(searchList);
      searchListData.remove(keywords);
      await Storage.setString('searchList', json.encode(searchListData));
      return ;
    }
  }
}