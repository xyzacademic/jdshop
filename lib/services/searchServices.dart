import 'dart:convert';
import 'storage.dart';

class SearchServices{
  static setSearchData(keywords) async{
    /*

    1. get data in local disk (searchList)
    2. check if the loaded data is empty
      2.1 if not empty
        1. load data
        2.
     */
    String? searchList = await Storage.getString("searchLish");
    if (searchList != null) {
      List searchListData = json.decode(searchList);
      var hasData = searchListData.any((v){
        return v == keywords;
      });
      if (!hasData){
        searchListData.add(keywords);
        await Storage.setString('searchList', json.encode(searchListData));
      }
    } else{
      List tempList = [];
      tempList.add(keywords);
      await Storage.setString('searchList', json.encode(tempList));
    }




  }
}