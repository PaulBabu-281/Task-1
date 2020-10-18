import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:task1/profile_model.dart';

class ProfileView extends StatelessWidget {
  Widget header(String head) {
    return Padding(
        padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Text(
                  head,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Profile>(builder: (context, myModel, child) {
      myModel.getName();
      myModel.getPath();
      myModel.getPhoneNo();
      return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(children: [
              Container(
                height: MediaQuery.of(context).size.height * .5,
                child: Stack(children: [
                  Container(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: ExactAssetImage(myModel.path == ' '
                                  ? 'assets/image2.png'
                                  : myModel.path),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * .47,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 30,
                            color:
                                Theme.of(context).primaryColor.withOpacity(.80))
                      ],
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Positioned(
                      right: 0,
                      bottom: 25,
                      child: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            myModel.editable = !myModel.editable;
                            // print(editable);
                          })),
                  Positioned(
                      left: 0,
                      bottom: 25,
                      child: IconButton(
                          icon: Icon(Icons.photo_camera),
                          onPressed: () async {
                            FilePickerResult result =
                                await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: [
                                'jpg',
                                'png',
                              ],
                            );
                            if (result != null) {
                              File file = File(result.files.first.path);
                              print(file.toString().substring(6));
                              var sa = file.toString();
                              var pathSave =
                                  file.toString().substring(7, (sa.length - 1));
                              myModel.setPath(pathSave);
                              print("   Saved   ");
                            } else
                              print("Need Storage Permission");
                          })),
                ]),
              ),
              header('Name'),
              myModel.editable
                  ? Padding(
                      padding:
                          EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Flexible(
                            child: new TextFormField(
                              autofocus: myModel.editable,
                              initialValue: myModel.name ?? '',
                              onFieldSubmitted: (value) {
                                myModel.setName(value);
                                myModel.editable = !myModel.editable;
                              },
                              decoration: const InputDecoration(
                                hintText: "Enter Your Name",
                              ),
                              enabled: myModel.editable,
                            ),
                          ),
                        ],
                      ))
                  : Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: ListTile(
                        //(padding: EdgeInsets.only(left: 5)),
                        title: Text(myModel.name ?? 'Enter name'),
                      ),
                    ),
              header('Phone Number'),
              myModel.editable
                  ? Padding(
                      padding:
                          EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                      child: new Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          new Flexible(
                            child: new TextFormField(
                              keyboardType: TextInputType.number,
                              initialValue: myModel.phoneNo ?? '',
                              onFieldSubmitted: (value) {
                                myModel.setPhoneNo(value);
                                myModel.editable = !myModel.editable;
                              },
                              onSaved: (newValue) {
                                myModel.setPhoneNo(newValue);
                                myModel.editable = !myModel.editable;
                              },
                              decoration: const InputDecoration(
                                hintText: "Enter Your Phone Number",
                              ),
                              enabled: myModel.editable,
                            ),
                          ),
                        ],
                      ))
                  : Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: ListTile(
                        //(padding: EdgeInsets.only(left: 5)),
                        title: Text(myModel.phoneNo ?? 'Enter phone number'),
                      ),
                    ),
            ]),
          ),
        ),
      );
    });
  }
}
