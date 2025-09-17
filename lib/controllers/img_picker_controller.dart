
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends ChangeNotifier {
  ImagePicker imagePicker = ImagePicker();

  List<String>? imgList=[];

  void removePhoto(int index){
    imgList!.removeAt(index);
    notifyListeners();
  }
  
bool isImagePicked= false;
  Future<void> getImage() async {
    var result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result!=null) {
      // imgPath= result!.files[0].path!;
      imgList?.add(result.files[0].path!);
      isImagePicked= true;
    }
    notifyListeners();
  }

  Future<void> getImageByCamera() async {
    var result = await imagePicker.pickImage(source: ImageSource.camera);

    if (result!=null) {
      imgList?.add(result.path);
      isImagePicked= true;

    }
    notifyListeners();
  }

  Future<void> clearList()async{

imgList!.clear();


  }


bool isClicked = false;
Future<void> onChanged(String value)async{

if (value.isEmpty) {
  isClicked=false;
}else{
  isClicked=true;
}

notifyListeners();
}


Future<void> equalToImgFileList(List<String>? list)async{

 imgList= list;

notifyListeners();
}




List<String>? viewPageList=[];


void updateState(){

viewPageList;
notifyListeners();
  
}

Future<void> getImageByCameraForPageView(List<String>? list) async {
    var result = await imagePicker.pickImage(source: ImageSource.camera);

    if (result!=null) {
      viewPageList!.add(result.path);
      isImagePicked= true;

    }
    notifyListeners();
  }

void cleanViewPageList(){

viewPageList!.clear();
notifyListeners();
}

 Future<void> getImageByGalleryForPageView(List<String>? list) async {
    var result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result!=null) {
      // imgPath= result!.files[0].path!;
      viewPageList!.add(result.files[0].path!);
      isImagePicked= true;
      
    }
    notifyListeners();
  }

Future<void> equalToNotePadList(List<String> l)async{

viewPageList=List.from(l);


}

int? currentPageViewBuilderINDEX;

Future<void> onChangedPageViewBuilder(int value)async{

currentPageViewBuilderINDEX=value;
notifyListeners();

}

void currentPageViewIndexEqualToClickPhotoIndex(int index){

currentPageViewBuilderINDEX=index;

// notifyListeners();
// print(currentPageViewBuilderINDEX);

}



Future<void> removeAtViewPageList(int index, )async{



 viewPageList!.removeAt(index);
  viewPageList= viewPageList;
notifyListeners();

}

}
