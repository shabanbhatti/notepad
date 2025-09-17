import 'package:flutter/cupertino.dart';

class IsClickedToShowUpdateProvider extends ChangeNotifier {
  bool isClicked = false;
  Future<void> viewPageOnChanged() async {
    isClicked = true;
    notifyListeners();
  }

  Future<void> letToFalse() async {
    isClicked = false;
    notifyListeners();
  }
}