
import 'dart:developer';
import 'dart:io' as i;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'book_display_screen_vm.dart';

class BookdisplayScreen extends StatelessWidget {
  var d;

  BookdisplayScreen({super.key, @required this.d});

  Future openfile(var url, var title) async {
    final file = await downloadfile(url, title!);
    if (file == null) {
      print("null");
      return;
    }
    print(file.path);
    OpenFile.open(file.path);
  }

  Future<i.File?> downloadfile(var url, var filename) async {
    try {
      var appstorage = await getApplicationDocumentsDirectory();
      final file = i.File('${appstorage.path}/filename');
      final Response = await Dio().get(url,
          options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            receiveTimeout: 0,
          ));
      final raf = file.openSync(mode: i.FileMode.write);
      raf.writeFromSync(Response.data);
      await raf.close();

      return file;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return BookDisplayScreenVm(d);
      },
      child: _screen(context),
    );
  }

  Widget _screen(BuildContext context) {
    return Consumer<BookDisplayScreenVm>(
      builder: (context, vm, __) {
        return Scaffold(
          backgroundColor: Colors.brown[50],
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                            ..pop()
                            ..pop();
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 120,),
                      Text(
                        "DETAILS",
                        style: GoogleFonts.lato(
                            textStyle:
                            TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold)),
                      ),

                    ],
                  ),
                ),
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  d["items"][0]["volumeInfo"]["title"],
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontSize: 23,
                                          color: Colors.indigo[800],
                                          fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "by " +
                                      d["items"][0]["volumeInfo"]["authors"]
                                      [0],
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                        fontSize: 13,
                                        color: Colors.indigo[600],
                                      )),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Rating :",
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: Colors.indigo[800])),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      vm.rating,
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              fontSize: 13,
                                              color: Colors.indigo[600])),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Pages :",
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: Colors.indigo[800])),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      vm.pagecount,
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              fontSize: 13,
                                              color: Colors.indigo[600])),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Language :",
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: Colors.indigo[800])),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      vm.lang,
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              fontSize: 13,
                                              color: Colors.indigo[600])),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Publish date :",
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: Colors.indigo[800])),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      vm.pubdate.toUpperCase(),
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              fontSize: 13,
                                              color: Colors.indigo[600])),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      height: 35,
                                      width: 100,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.indigo[800],
                                          shape: const StadiumBorder(),
                                        ),
                                        onPressed: () async {
                                          log('webReader - ${d["items"][0]
                                          ["accessInfo"]["webReaderLink"]}');
                                          await launchUrl(Uri.parse(d["items"][0]
                                          ["accessInfo"]["webReaderLink"]));
                                        },
                                        child: const Flexible(
                                          child: Text(
                                            "Read Book",
                                            textWidthBasis: TextWidthBasis.longestLine,
                                            style: TextStyle(color: Colors.white),
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (d["items"][0]["accessInfo"]["epub"]
                                    ["isAvailable"] ==
                                        true)
                                      InkWell(
                                        onTap: () async {
                                          try {
                                            var check = d["items"][0]["accessInfo"]
                                            ["epub"]["isAvailable"];
                                            if (check == true && vm.downloadUrl.isNotEmpty) {
                                              log('download url - ${vm.downloadUrl}');
                                              await launchUrl(Uri.parse(vm.downloadUrl));
                                            }
                                          } catch (e) {
                                            print("Not available");
                                          }
                                        },
                                        child: const Icon(
                                          Icons.download_outlined,
                                          color: Colors.black,
                                          size: 30,
                                        ),
                                      )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 230,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    vm.url,
                                  ),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ],
                      ),
                    )),
                Expanded(
                  //flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: ListView(
                                children: [
                                  Text(
                                    "Description",
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                          color: Colors.indigo[800],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    vm.desc,
                                    style: GoogleFonts.lato(
                                        color: Colors.grey[600], fontSize: 15),
                                  )
                                ],
                              ),
                            ))
                      ],
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
}
