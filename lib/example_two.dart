import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleTwo extends StatefulWidget {
  const ExampleTwo({super.key});

  @override
  State<ExampleTwo> createState() => _ExampleTwoState();
}

class _ExampleTwoState extends State<ExampleTwo> {
  List<Photos> photoList = [];
  Future<List<Photos>> getPhotos() async {
    Uri uriPhotos = Uri.parse("https://jsonplaceholder.typicode.com/photos");
    final response = await http.get(uriPhotos);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body) as List; // Decode and cast to List
      for (var i in data) {
        Photos photo = Photos(title: i["title"], url: i["url"]);
        photoList.add(photo);
      }
    } else {
      print("Failed to fetch photos: ${response.statusCode}");
    }

    return photoList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "API Tutorial(Ex-2)",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: FutureBuilder(
          future: getPhotos(),
          builder: (context, AsyncSnapshot<List<Photos>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Text("Loading..."),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.hasError}"),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text("No Data Available"),
              );
            } else {
              return ListView.builder(
                itemCount: photoList.length,
                itemBuilder: (context, index) {
                  var apiCall = snapshot.data![index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        apiCall.url.toString(),
                      ),
                    ),
                    title: Text(
                      apiCall.title.toString(),
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}

class Photos {
  String title, url;
  Photos({required this.title, required this.url});
}
