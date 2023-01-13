
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'object.user.entity.dart';
import 'objextbox.controller.dart';

class ObjectBoxCRUD extends StatefulWidget {
  const ObjectBoxCRUD({Key? key}) : super(key: key);
  @override
  State<ObjectBoxCRUD> createState() => _ObjectBoxCRUDState();
}

class _ObjectBoxCRUDState extends State<ObjectBoxCRUD> {
  final fake = Faker();
  final db = Get.put(ObjectBoxController());
  @override
  void initState() {
    db.initUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Insert"),
              Tab(text: "View"),
               Tab(text: "Query"),
              Tab(text: "Update"),
              Tab(text: "Delete"),
            ],
          ),
          title: const Text('Object Box'),
        ),
        body: TabBarView(
          children: [
            insetWidget(context),
            viewWidget(context),
            queryWidget(context),
            updateWidget(context),
            deleteWidget(context),
          ],
        ),
      ),
    );
  }
  Widget simpleInput(hint,controller){
    var decoration = BoxDecoration(
        color: const Color.fromRGBO(237, 245, 245, 1),
        borderRadius: BorderRadius.circular(8)
    );
    return Container(
      decoration: decoration,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint
        ),
      ),
    );
  }
  Widget dateInput(mm,dd,yyyy){
    var decoration = BoxDecoration(
        color: const Color.fromRGBO(237, 245, 245, 1),
        borderRadius: BorderRadius.circular(8)
    );
    return  Container(
      height: 50,
      alignment: Alignment.center,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: [
          Container(
            width: 60,
            decoration: decoration,
            child: TextField(
              controller: mm,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "MM"
              ),
            ),
          ),
          10.width,
          Container(
            width: 60,
            decoration: decoration,
            child: TextField(
              controller: dd,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "DD"
              ),
            ),
          ),
          10.width,
          Container(
            width: 90,
            decoration: decoration,
            child: TextField(
              controller: yyyy,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "YYYY"
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget insetWidget(BuildContext context){
    var fName = TextEditingController();
    var lName = TextEditingController();
    var mm = TextEditingController();
    var dd = TextEditingController();
    var yyyy = TextEditingController();

    return Container(
      margin: const EdgeInsets.all(10),
      child: ListView(
        shrinkWrap: true,
        children: [
          simpleInput("Fist Name", fName),
          16.height,
          simpleInput("Last Name", lName),
          16.height,
          dateInput(mm, dd, yyyy),
          16.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppButton(
                child: const Text("Generate"),
                onTap: (){
                 lName.text = fake.person.lastName();
                 fName.text = fake.person.firstName();
                 mm.text = fake.person.random.integer(12,min: 1).toString();
                 dd.text = fake.person.random.integer(28,min: 1).toString();
                 yyyy.text = fake.person.random.integer(2022,min: 1975).toString();
                },
              ),
              10.width,
              AppButton(
                child: const Text("Add"),
                onTap: () => db.addUser(fName: fName.text,lName: lName.text,mm: mm.text,dd: dd.text,yyyy: yyyy.text),
              ),
            ],
          )
        ],
      ),
    );
  }
  Widget viewWidget(BuildContext context){
    return GetBuilder(
      init: db,
      builder: (_) => Container(
        margin: const EdgeInsets.all(10),
        child: ListView(
          children: db.users.map((ObjectBoxUser user) => ListTile(
            leading: Container(
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                color: Colors.indigo,
                shape: BoxShape.circle,
              ),
              child: Text(user.fName[0],style: boldTextStyle(color: white),),
            ),
            title: Text("${user.fName} ${user.lName}",style: primaryTextStyle(),),
          )).toList(),
        ),
      ),
    );
  }
  Widget queryWidget(BuildContext context){
    return Container(
      margin: const EdgeInsets.all(10),
      child: const Text("Test 3"),);
  }
  Widget updateWidget(BuildContext context){
    return GetBuilder(
      init: db,
      builder: (_) => Container(
        margin: const EdgeInsets.all(10),
        child: ListView(
          children: db.users.map((ObjectBoxUser user){
            var fName = TextEditingController(text: user.fName);
            var lName = TextEditingController(text: user.lName);
            var mm = TextEditingController(text: user.birthMonth.toString());
            var dd = TextEditingController(text: user.birthDay.toString());
            var yyyy = TextEditingController(text: user.birthYear.toString());
            return ListTile(
              trailing: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.indigo,
                  shape: BoxShape.circle,
                ),
                child: GestureDetector(
                  onTap: () {
                    Get.dialog(
                      Dialog(
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              simpleInput("Fist Name", fName),
                              16.height,
                              simpleInput("Last Name", lName),
                              16.height,
                              dateInput(mm, dd, yyyy),
                              16.height,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  AppButton(
                                    child: const Text("Update"),
                                    onTap: () {
                                      db.updateUser(fName: fName.text,lName: lName.text,mm: mm.text,dd: dd.text,yyyy: yyyy.text,id: user.id);
                                      Get.back();
                                    },
                                  ),
                                  10.width,
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  child: const Icon(Icons.edit,color: Colors.white,),
                ),
              ),
              leading: Container(
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  color: Colors.indigo,
                  shape: BoxShape.circle,
                ),
                child: Text(user.fName[0],style: boldTextStyle(color: white),),
              ),
              title: Text("${user.fName} ${user.lName}",style: primaryTextStyle(),),
            );
          }).toList(),
        ),
      ),
    );
  }
  Widget deleteWidget(BuildContext context){
    return GetBuilder(
      init: db,
      builder: (_) => Container(
        margin: const EdgeInsets.all(10),
        child: ListView(
          children: db.users.map((ObjectBoxUser user) => ListTile(
            trailing: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.indigo,
                shape: BoxShape.circle,
              ),
              child: GestureDetector(
                onTap: () => db.deleteUser(id: user.id, name: user.fName),
                child: const Icon(Icons.delete_outline,color: Colors.white,),
              ),
            ),
            leading: Container(
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                color: Colors.indigo,
                shape: BoxShape.circle,
              ),
              child: Text(user.fName[0],style: boldTextStyle(color: white),),
            ),
            title: Text("${user.fName} ${user.lName}",style: primaryTextStyle(),),
          )).toList(),
        ),
      ),
    );
  }
}
