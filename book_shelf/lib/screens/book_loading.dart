// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'book_display_screen/book_display_screen.dart';

class Bookloading extends StatefulWidget {
  var c;
  Bookloading({super.key, @required this.c});

  @override
  State<Bookloading> createState() => _BookloadingState();
}

class _BookloadingState extends State<Bookloading> {
  var c2;

  @override
  void initState() {
    print(widget.c);
    // TODO: implement initState
    super.initState();
    getdata();
  }

  void getdata() async {
    try {
      Response r = await get(Uri.parse(
          "https://www.googleapis.com/books/v1/volumes?q=isbn:${widget.c}&key=AIzaSyAqxw3nnCxwNQXRmXb-ZFi8FTNyhz6kwGA"));
      c2 = jsonDecode(r.body);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return BookdisplayScreen(d: c2);
      }));
    } catch (e) {
      print("error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return (const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    ));
  }
}
