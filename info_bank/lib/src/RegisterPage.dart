import 'package:flutter/material.dart';
import 'package:info_bank/src/constants/buttons.dart';
import 'constants/allConstants.dart';
import 'package:info_bank/src/services/firebase_services.dart';
import 'package:info_bank/tabs/tabspage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  static final FServices _firebaseServices = FServices();
  //final TextEditingController _nameController = TextEditingController();
  late String _nameController;
  final TextEditingController _accController = TextEditingController();
  final GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //aren't sure if appbar needed
      body: Container(
          padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
          child: Column(
            children: [
              const Text(
                "註冊",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              const Text(
                "請填寫以下使用者資料",
                style: TextStyle(fontSize: 15),
              ),
              Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      TextFormField(
                          autofocus: true,
                          controller: _accController,
                          decoration: const InputDecoration(
                            labelText: "ID",
                            prefixIcon: Icon(Icons.directions_run),
                            hintText: "輸入想要的使用者帳號(限英文和數字)",
                          ),
                          validator: validateAcc),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        autofocus: true,
                        //controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: "暱稱",
                          prefixIcon: Icon(Icons.person_2_outlined),
                          hintText: "輸入想要的暱稱(限中文、英文和數字)",
                        ),
                        validator: validateName,
                        onSaved: (value) {
                          _nameController = value.toString();
                        },
                        onChanged: (value) =>
                            setState(() => _nameController = value.toString()),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                          style: testButtonStyle,
                          onPressed: () async {
                            if ((_formKey.currentState as FormState)
                                .validate()) {
                              final result = await _firebaseServices.addUser(
                                  acc: _accController.text,
                                  nickname: _nameController);

                              if (result!.contains('Success') &&
                                  context.mounted) {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) =>
                                      TabsPage(selectedIndex: 0),
                                ));
                              }
                            }
                          },
                          child: const Text("提交"))
                    ],
                  )),
            ],
          )),
    );
  }

  //validators
  String? validateAcc(String? value) {
    //check [A-Za-z0-9]
    if (!RegExp(r'^\w+$').hasMatch(value.toString())) {
      return "格式錯誤";
    } else {
      return null;
    }
  }

  static String? validateName(String? value) {
    //check [A-Za-z0-9]
    if (!RegExp(r'^[a-zA-Z0-9\u4e00-\u9fa5]+$').hasMatch(value.toString())) {
      return "格式錯誤";
    } else {
      return null;
    }
  }
}
