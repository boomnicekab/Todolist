import 'package:flutter/material.dart';
//https method
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController todo_title = TextEditingController();
  TextEditingController todo_detail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("เพิ่มรายการใหม่"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              TextField(
                  controller: todo_title, //link with textediting controller
                  decoration: InputDecoration(
                      labelText: 'รายการที่ต้องทำ',
                      border: OutlineInputBorder())),
              SizedBox(
                height: 30,
              ),
              TextField(
                  minLines: 4,
                  maxLines: 8,
                  controller: todo_detail, //link with textediting controller
                  decoration: InputDecoration(
                      labelText: 'รายละเอียด', border: OutlineInputBorder())),
              SizedBox(
                height: 30,
              ),

              //ปุ่มเพิ่ม

              ElevatedButton(
                onPressed: () {
                  print('-------------------');
                  print('title: ${todo_title.text}');
                  print('title: ${todo_detail.text}');
                  postTodo();
                  setState(() {
                    todo_title.clear();
                    todo_detail.clear();
                  });
                  Navigator.pop(context);
                },
                child: Text("เพิ่มรายการ"),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.blueAccent),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.fromLTRB(50, 20, 50, 20)),
                    textStyle:
                        MaterialStateProperty.all(TextStyle(fontSize: 30))),
              ),
            ],
          ),
        ));
  }

  Future postTodo() async {
    var url = Uri.http('192.168.1.102:8000', '/api/post-todolist');
    //var url = Uri.https('127.0.0.1:8000', '/api/post-todolist');
    Map<String, String> header = {"Content-type": "application/json"};
    String jsondata =
        '{"title": "${todo_title.text}","detail":"${todo_detail.text}"}';
    var response = await http.post(url, headers: header, body: jsondata);
    print('---------result-----------');
    print(response.body);
  }
}
