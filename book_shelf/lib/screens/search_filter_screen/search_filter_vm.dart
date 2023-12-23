import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class SearchFilterVm extends ChangeNotifier {
  var text;

  SearchFilterVm(this.text) {
    getdata();
  }

  String get title => "Result";

  String get emptyText => "Uh No! There are no books here";

  String get detailsText => "DETAILS";
  dynamic _cp;
  var _isbn;

  get isbn => _isbn;

  get cp => _cp;

  bool _isBusy = false;

  bool get isBusy => _isBusy;

  Future<void> getdata() async {
    if (_isBusy) {
      return;
    }
    _isBusy = true;
    notifyListeners();
    Response r = await get(
      Uri.parse(
          "https://www.googleapis.com/books/v1/volumes?q=intitle:$text&maxResult=40&download=epub&orderBy=newest&key=AIzaSyA65-aOAsY2AKqVWuNtshiv4ZP16Nwb9j8"),
    );
    _cp = jsonDecode(r.body);
    _isBusy = false;
    notifyListeners();
  }

  getIsbn(int index) {
    return cp["items"][index + 1]["volumeInfo"]["industryIdentifiers"][0]
        ["identifier"];
  }
}
