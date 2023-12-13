import 'package:flutter/cupertino.dart';

import '../../../models/book_model.dart';

class BooksCardTrainVm extends ChangeNotifier{
  final BookModel _bookModel;
  BooksCardTrainVm(this._bookModel);
  String getIdentifier(int index){
    return _bookModel.items[index+1].volumeInfo.industryIdentifiers[0].identifier;
  }

  String getImage(int index){
    return _bookModel.items[index+1].volumeInfo.imageLinks.thumbnail;
  }

  String getText(int index){
    return _bookModel.items[index+1].volumeInfo.title;
  }

}