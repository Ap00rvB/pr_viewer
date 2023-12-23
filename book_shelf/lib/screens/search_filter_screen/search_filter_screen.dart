import 'package:book_shelf/screens/search_filter_screen/search_filter_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../common/circular_progress_indicator.dart';
import '../book_loading.dart';

class SearchFilterScreen extends StatelessWidget {
  var text;

  SearchFilterScreen({super.key, @required this.text});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return SearchFilterVm(text);
      },
      child: _screen(context),
    );
  }

  Widget _screen(BuildContext context) {
    return Consumer<SearchFilterVm>(
      builder: (context, vm, __) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              vm.title,
            ),
            backgroundColor: Colors.indigo[600],
          ),
          body: _body(context, vm),
        );
      },
    );
  }

  Widget _body(BuildContext context, SearchFilterVm vm) {
    return vm.isBusy
        ? ModalCircularProgressIndicator(null, vm.isBusy)
        : _mainScreen(context, vm);
  }

  Widget _mainScreen(BuildContext context, SearchFilterVm vm) {
    return vm.cp["items"]==null
        ? Center(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 120),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/red_lady_empty.svg"),
                      const SizedBox(height: 16),
                      Text(vm.emptyText,
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  color: Colors.indigo[800],
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                          textAlign: TextAlign.center),
                    ])))
        : Column(
            children: [
              Container(
                color: Colors.indigo[600],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: vm.cp["items"].length - 1,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10),
                        child: (Container(
                          padding: EdgeInsets.all(10),
                          height: 250,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.brown[50],
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 210,
                                width: 140,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: NetworkImage(vm.cp["items"]
                                                [index + 1]["volumeInfo"]
                                            ["imageLinks"]["thumbnail"]),
                                        fit: BoxFit.cover)),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Flexible(
                                    child: Text(
                                      (vm.cp["items"][index + 1]["volumeInfo"]
                                                      ["title"])
                                                  .length >
                                              20
                                          ? st(vm.cp["items"][index + 1]
                                              ["volumeInfo"]["title"])
                                          : vm.cp["items"][index + 1]
                                              ["volumeInfo"]["title"],
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              color: Colors.indigo[800],
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Flexible(
                                    child: Text(
                                      (vm.cp["items"][index + 1]["volumeInfo"]
                                                      ["authors"][0])
                                                  .length >
                                              20
                                          ? "by ${st(vm.cp["items"][index + 1]["volumeInfo"]["authors"][0])}"
                                          : "by " +
                                              vm.cp["items"][index + 1]
                                                  ["volumeInfo"]["authors"][0],
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              color: Colors.indigo[800],
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Page Count:- ${vm.cp["items"][index + 1]["volumeInfo"]["pageCount"]}",
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            color: Colors.indigo[800],
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    (vm.cp["items"][index + 1]["volumeInfo"]
                                                ["averageRating"]) ==
                                            null
                                        ? "⭐ " + "No rating available"
                                        : "⭐ ${vm.cp["items"][index + 1]["volumeInfo"]["averageRating"]}",
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            color: Colors.indigo[800],
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: const StadiumBorder(),
                                      primary: Colors.indigo[800],
                                    ),
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return Bookloading(
                                            c: vm.getIsbn(index));
                                      }));
                                    },
                                    child:  Text(
                                      vm.detailsText,
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )),
                      );
                    }),
              )
            ],
          );
  }

  String st(String s) {
    int count = 0;
    String ans = "";
    for (int i = 0; i < s.length; i++) {
      if (count == 20) {
        break;
      }
      count++;
      ans = ans + s[i];
    }
    return "$ans...";
  }
}
