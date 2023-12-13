import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/book_model.dart';
import '../../book_loading.dart';
import 'book_card_train_vm.dart';

class BooksCardTrain extends StatelessWidget {
  final BookModel bookModel;

  const BooksCardTrain({super.key,  required this.bookModel});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return BooksCardTrainVm( bookModel);
      },
      child: _bookCard(context),
    );
  }

  Widget _bookCard(BuildContext context) {
    return Consumer<BooksCardTrainVm>(
      builder: (context, vm, __) {
        return (SizedBox(
          height: 270,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 9,
              itemBuilder: (context, index) {
                return (Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Bookloading(c: vm.getIdentifier(index)
                                );
                          }));
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 230,
                              width: 150,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 8,
                                      offset: Offset(2, 2))
                                ],
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(vm.getImage(index)),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              vm.getText(index).length > 20
                                  ? st(vm.getText(index))
                                  : vm.getText(index),
                              style: TextStyle(
                                  color: Colors.grey[900],
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ));
              }),
        ));
      },
    );
  }

  String st(String s) {

    int count = 0;
    String ans = "";
    for (int i = 0; i < s.length; i++) {
      if (count == 3) {
        break;
      }
      if (s[i] == ' ') {
        count++;
      }
      ans = ans + s[i];
    }
    return ans + "...";
  }
}
