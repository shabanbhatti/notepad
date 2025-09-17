import 'package:flutter/widgets.dart';

class CheckForDeleteController extends ChangeNotifier{
  
bool isCheck= false;

Future<void> selectButton()async{
  isCheck=true;
  notifyListeners();
}



}