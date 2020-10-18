//import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile with ChangeNotifier {
  String phoneNo;
  String name;
  String path;
  bool editable = false;
  Profile();

  setName(String value) async {
    name = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', value);
    print('name set $value');
    notifyListeners();
    print(name);
  }

  Future<String> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('name');
    name = value;
    notifyListeners();
    return value;
  }

  setPhoneNo(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('phoneNo', value);
    notifyListeners();
  }

  Future<String> getPhoneNo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('phoneNo');
    phoneNo = value;
    return value;
  }

  setPath(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('path', value);
    notifyListeners();
  }

  Future<String> getPath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('path') ?? ' ';
    path = value;
    return value;
  }
}
