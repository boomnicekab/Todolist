import 'package:flutter/material.dart';
//https method
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class UpdatePage extends StatefulWidget {
  final v1, v2, v3;
  const UpdatePage(this.v1, this.v2, this.v3);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  var _v1, _v2, _v3;
  TextEditingController todo_title = TextEditingController();
  TextEditingController todo_detail = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _v1 = widget.v1;
    _v2 = widget.v2;
    _v3 = widget.v3;
    todo_title.text = _v2;
    todo_detail.text = _v3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("แก้ไข"),
          actions: [
            IconButton(
                onPressed: () {
                  print("Delete ID: $_v1");
                  deleteTodo();
                  Navigator.pop(context, 'delete');
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.black,
                ))
          ],
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
                  updateTodo();
                  final snackBar = SnackBar(
                    content: const Text('อัพเดทรายการเรียบร้อย'),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Text("แก้ไข"),
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

  Future updateTodo() async {
    var url = Uri.http('128.199.83.91:8081', '/api/update-todolist/$_v1');
    //var url = Uri.https('127.0.0.1:8000', '/api/post-todolist');
    Map<String, String> header = {"Content-type": "application/json"};
    String jsondata =
        '{"title": "${todo_title.text}","detail":"${todo_detail.text}"}';
    var response = await http.put(url, headers: header, body: jsondata);
    print('---------result-----------');
    print(response.body);
  }

  Future deleteTodo() async {
    var url = Uri.http('128.199.83.91:8081', '/api/delete-todolist/$_v1');
    //var url = Uri.https('127.0.0.1:8000', '/api/post-todolist');
    Map<String, String> header = {"Content-type": "application/json"};
    var response = await http.delete(url, headers: header);
    print('---------result-----------');
    print(response.body);
  }
}
