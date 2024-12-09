import 'dart:convert';

import 'package:apitutorials/const.dart';
import 'package:apitutorials/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleThree extends StatefulWidget {
  const ExampleThree({super.key});

  @override
  State<ExampleThree> createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree> {
  List<UserModel> userList = [];
  Future<List<UserModel>> getUserApi() async {
    Uri uriUser = Uri.parse("https://jsonplaceholder.typicode.com/users");
    final response = await http.get(uriUser);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "API Tutorial(Ex-3)",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                  future: getUserApi(),
                  builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("Loading");
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.hasError}");
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text("No data available");
                    } else {
                      return ListView.builder(
                          itemCount: userList.length,
                          itemBuilder: (context, int index) {
                            return Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              color: Colors.grey[50],
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ResUsableRow(
                                      title: "Name: ",
                                      value:
                                          snapshot.data![index].name.toString(),
                                    ),
                                    ResUsableRow(
                                      title: "UserName: ",
                                      value: snapshot.data![index].username
                                          .toString(),
                                    ),
                                    ResUsableRow(
                                      title: "Email: ",
                                      value: snapshot.data![index].email
                                          .toString(),
                                    ),
                                    ResUsableRow(
                                      title: "Address(City): ",
                                      value: snapshot.data![index].address!.city
                                          .toString(),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                  }))
        ],
      ),
    );
  }
}

class ResUsableRow extends StatelessWidget {
  final String title, value;
  const ResUsableRow({required this.title, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: AppTextStyle.titleStyle,
        ),
        Text(
          value,
          style: AppTextStyle.bodyStyle,
        )
      ],
    );
  }
}
