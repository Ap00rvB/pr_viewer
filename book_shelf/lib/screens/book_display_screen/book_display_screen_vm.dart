import 'package:flutter/cupertino.dart';

class BookDisplayScreenVm extends ChangeNotifier {
  var d;

  BookDisplayScreenVm(this.d) {
    geturl();
    getlang();
    getpubdate();
    getdesc();
    getRating();
    getpagecount();
    getDownloadUrl();
  }

  String _pagecount = "Not available";
  String _desc = "Not available";
  String _pubdate = "Not available";
  String _lang = "Not available";
  String _rating = "Not available";
  String _url =
      "https://www.bing.com/images/search?view=detailV2&ccid=vx9%2fIUj5&id=3B7650A146D55682645F765E60E786419299154C&thid=OIP.vx9_IUj50utS7cbaiRtoZAHaE8&mediaurl=https%3a%2f%2fst3.depositphotos.com%2f1186248%2f14351%2fi%2f950%2fdepositphotos_143511907-stock-photo-not-available-rubber-stamp.jpg&exph=682&expw=1023&q=not+available&simid=608054098357136066&FORM=IRPRST&ck=BADF0353AC59677CCFAA67227357E3CB&selectedIndex=1&ajaxhist=0&ajaxserp=0";
  String _downloadUrl = "";

  String get pagecount => _pagecount;

  String get desc => _desc;

  String get pubdate => _pubdate;

  String get lang => _lang;

  String get rating => _rating;

  String get url => _url;

  String get downloadUrl => _downloadUrl;

  geturl() {
    try {
      _url = d["items"][0]["volumeInfo"]["imageLinks"]["thumbnail"];
    } catch (e) {
      _url = d["items"][1]["volumeInfo"]["imageLinks"]["thumbnail"];
      ;
    }
  }

  getlang() {
    try {
      _lang = d["items"][0]["volumeInfo"]["language"].toString().toUpperCase();
    } catch (e) {
      _lang = "Not available";
    }
  }

  getpubdate() {
    try {
      _pubdate = d["items"][0]["volumeInfo"]["publishedDate"].toString();
    } catch (e) {
      _pubdate = "Not available";
    }
  }

  getdesc() {
    try {
      _desc = d["items"][0]["volumeInfo"]["description"];
    } catch (e) {
      _desc = "Not available";
    }
  }

  getRating() {
    try {
      _rating = d["items"][0]["volumeInfo"]["averageRating"].toString();
    } catch (e) {
      _rating = "Not available";
    }
  }

  getpagecount() {
    try {
      _pagecount = d["items"][0]["volumeInfo"]["pageCount"].toString();
    } catch (e) {
      _pagecount = "Not available";
    }
  }

  getDownloadUrl() {
    try {
      _downloadUrl = d["items"][0]["accessInfo"]["epub"]["acsTokenLink"];
    } catch (e) {
      _downloadUrl ="";
    }
  }
}
