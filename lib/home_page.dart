import 'dart:convert';
import 'package:apitutorials/const.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/posts_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PostsModel> postModelList = [];

  Future<List<PostsModel>> getPostApi() async {

    try {

      Uri uri = Uri.parse("https://jsonplaceholder.typicode.com/posts");
      final response = await http.get(uri);
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        for (Map<String, dynamic> i in data) {
          postModelList.add(PostsModel.fromJson(i));
        }
      } else {
        return postModelList;
      }
    } catch (e) {
      print("Error: $e");
    }
    return postModelList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "API Tutorial",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPostApi(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: Text("Loading..."));
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No data available"));
                } else {
                  return ListView.builder(
                      itemCount: postModelList.length,
                      itemBuilder: (context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Title:${postModelList[index].title.toString()}",
                                    style: AppTextStyle.titleStyle,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Description:\n${postModelList[index].body.toString()}",
                                    style: AppTextStyle.bodyStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
