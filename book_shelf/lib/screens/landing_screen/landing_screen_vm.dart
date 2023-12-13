import 'dart:convert';
import 'dart:developer';

import 'package:book_shelf/models/book_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class LandingScreenVM extends ChangeNotifier {

  LandingScreenVM() {
    _loginApi();
  }

  bool _isBusy = false;
  dynamic _c1 ;
  dynamic _c2 ;
  dynamic _c3 ;
  dynamic _c4 ;
  late BookModel _adventureModel;
  late BookModel _fantasyModel;
  late BookModel _horrorModel;
  late BookModel _romanceModel;
  BookModel get adventureModel => _adventureModel;
  BookModel get fantasyModel => _fantasyModel;
  BookModel get horrorModel => _horrorModel;
  BookModel get romanceModel => _romanceModel;

  get c1 => _c1;
  get c2 => _c2;
  get c3 => _c3;
  get c4 => _c4;

  bool get isBusy => _isBusy;

  String get title => "Gallery";

  Future<void> _loginApi() async {
    if (_isBusy) {
      return;
    }
    _isBusy = true;
    notifyListeners();
    var r1 = await get(Uri.parse(
        "https://www.googleapis.com/books/v1/volumes?q=subject:thriller&download=epub&orderBy=newest&key=AIzaSyA65-aOAsY2AKqVWuNtshiv4ZP16Nwb9j8"));
    var r2 = await get(Uri.parse(
        "https://www.googleapis.com/books/v1/volumes?q=subject:fantasy&download=epub&orderBy=newest&key=AIzaSyA65-aOAsY2AKqVWuNtshiv4ZP16Nwb9j8"));
    var r3 = await get(Uri.parse(
        "https://www.googleapis.com/books/v1/volumes?q=subject:horror&download=epub&orderBy=newest&key=AIzaSyA65-aOAsY2AKqVWuNtshiv4ZP16Nwb9j8"));
    var r4 = await get(Uri.parse(
        "https://www.googleapis.com/books/v1/volumes?q=subject:health&download=epub&orderBy=newest&key=AIzaSyA65-aOAsY2AKqVWuNtshiv4ZP16Nwb9j8"));
    _c1 = jsonDecode(r1.body);
    _adventureModel = BookModel.fromJson(_c1);
    _c2 = jsonDecode(r2.body);
    _fantasyModel = BookModel.fromJson(_c2);
    _c3 = jsonDecode(r3.body);
    _horrorModel = BookModel.fromJson(_c3);
    _c4 = jsonDecode(r4.body);
    _romanceModel = BookModel.fromJson(_c4);
    _isBusy = false;
    notifyListeners();
  }
}
