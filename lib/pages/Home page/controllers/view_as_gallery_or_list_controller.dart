import 'package:flutter/material.dart';
import 'package:notepad_app_using_database_sqflite/services/shared_prefernes_service.dart';


class GalleryOrListProvider extends ChangeNotifier {
  
String viewAs= 'Gallery';

bool isGrid= true;

Future<void> getGridOrList()async{

var gridOrList= await SpService.getBool(SpService.isGridKEY);
 if (gridOrList==false) {
isGrid= false;
viewAs= 'List';   
 }else{
  viewAs= 'Gallery';
  isGrid=true;
 }

notifyListeners();
}

Future<void> listOrGrid()async{
isGrid= !isGrid;
SpService.setBool(SpService.isGridKEY, isGrid);
if (isGrid==true) {
  viewAs='Gallery';
}else{
  viewAs='List';
}

notifyListeners();
}


}