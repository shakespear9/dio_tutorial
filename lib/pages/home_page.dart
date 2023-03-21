import 'package:dio_tutorial/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../models/posts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var result = Service().getPosts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: result,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return normalBuild(snapshot.data ?? []);
          }
          if (snapshot.hasError) {
            return errorBuild(snapshot.error.toString());
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget normalBuild(List<Post> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(posts[index].title),
        );
      },
    );
  }

  Widget errorBuild(String errMsg) {
    return Center(
      child: Column(
        children: [
          Text(errMsg),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  result = Service().getPosts();
                });
              },
              child: const Text("Reload"))
        ],
      ),
    );
  }
}
