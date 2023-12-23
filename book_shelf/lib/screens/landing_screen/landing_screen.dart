import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../common/circular_progress_indicator.dart';
import '../category/book_card_screen/book_card_train.dart';
import '../search_filter_screen/search_filter_screen.dart';
import 'landing_screen_vm.dart';

class LandingScreen extends StatefulWidget {
  static const routeName = 'landing_screen';

  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return LandingScreenVM();
      },
      child: _screen(context),
    );
  }

  Widget _screen(BuildContext context) {
    return Consumer<LandingScreenVM>(
      builder: (context, vm, __) {
        return Scaffold(
          resizeToAvoidBottomInset : false,
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
            title: Text(vm.title,),backgroundColor: Colors.indigo[600],
          ),
          body: _body(context, vm),
        );
      },
    );
  }

  Widget _body(BuildContext context, LandingScreenVM vm) {
    return vm.isBusy
        ? ModalCircularProgressIndicator(null, vm.isBusy)
        : _mainScreen(context, vm);
  }

  Widget _mainScreen(BuildContext context, LandingScreenVM vm) {
    return SafeArea(
        child: Column(
      children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                  opacity: 0.7,
                    image: AssetImage(
                      "assets/books_library.jpg",
                    ),
                    fit: BoxFit.cover)),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80.0),
                    child: Container(
                      height: 40,
                      child: TextField(
                        controller: _textEditingController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.all(10),
                            hintText: "Search Book...",
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(40))),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SearchFilterScreen(text: _textEditingController.text);
                      }));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.indigo[600],
                    ),
                    child: const Text(
                      "SEARCH",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text("Explore the book forest!",
                      style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.bold))),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Find the light you are chasing for.",
                    style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ),
          ),
        ),
        Expanded(
            flex: 2,
            child: Container(
              color: Colors.brown[50],
              child: Column(
                children: [
                  Expanded(
                      child: Container(
                          child: ListView(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text(
                              "Adventure",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      BooksCardTrain(bookModel: vm.adventureModel),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text(
                              "Fantasy",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BooksCardTrain(bookModel: vm.fantasyModel),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text(
                              "Horror",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BooksCardTrain(bookModel: vm.horrorModel),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text(
                              "Health",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BooksCardTrain(bookModel: vm.romanceModel),
                    ],
                  )))
                ],
              ),
            ))
      ],
    ));
  }
}
