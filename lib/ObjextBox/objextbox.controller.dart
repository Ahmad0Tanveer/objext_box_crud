import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../main.dart';
import 'object.user.entity.dart';

class ObjectBoxController extends GetxController {
  final store =  objectBox.store.box<ObjectBoxUser>();
  List<ObjectBoxUser> users = [];
  void initUser(){
    users = store.getAll();
  }
  void addUser({fName,lName, dd,mm,yyyy}){
    try{
      ObjectBoxUser user = ObjectBoxUser(
        fName: fName,
        lName: lName,
        addedAt: DateTime.now().toString(),
        birthDay: int.parse(dd),
        birthMonth: int.parse(mm),
        birthYear: int.parse(yyyy),
      );
      store.put(user);
      initUser();
      update();
      toast("User Add Successfully",bgColor: darkGreen);
    }catch(_){
      toast("Some thing Went Wrong",bgColor: redColor);
    }
  }
  void updateUser({required id,required fName,required lName,required mm, required dd,required yyyy}) {
    try{
      ObjectBoxUser user = ObjectBoxUser(
        id: id,
        fName: fName,
        lName: lName,
        addedAt: DateTime.now().toString(),
        birthDay: int.parse(dd),
        birthMonth: int.parse(mm),
        birthYear: int.parse(yyyy),
      );

      /*store.remove(id);
      store.put(user);*/

      store.put(user);
      initUser();
      update();
      toast("Updated Successfully",bgColor: darkGreen);
    }catch(_){
      toast("Some thing Went Wrong",bgColor: redColor);
    }
  }
  void deleteUser({required id,required name}){
    store.remove(id);
    toast("$name Deleted",bgColor: darkGreen);
    initUser();
    update();
  }
}