import 'dart:convert';

import 'package:chooperapp/pages/postById.dart';
import 'package:chooperapp/services/post_service.dart';
import 'package:flutter/material.dart';
import 'package:chopper/chopper.dart';
import 'package:provider/provider.dart';
import 'package:chooperapp/utils/utils.dart' as utils;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

final _formKey = GlobalKey<FormState>();

final titleController = TextEditingController();

final bodyController = TextEditingController();

class _HomePageState extends State<HomePage> {
  // final formKey = GlobalKey<FormState>();

  // Post postModel = new Post();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chopper Blog'),
      ),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _postAlert(context);
          // final response =
          //     await Provider.of<PostService>(context, listen: false)
          //         .postPost({'key': 'value'});
          // print(response.body);
        },
      ),
    );
  }

  FutureBuilder<Response> _buildBody(BuildContext context) {
    return FutureBuilder<Response>(
      future: Provider.of<PostService>(context).getPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List posts = json.decode(snapshot.data.bodyString);
          return _buildPosts(context, posts);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  ListView _buildPosts(BuildContext context, List posts) {
    return ListView.builder(
      itemCount: posts.length,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          child: ListTile(
            title: Text(
              posts[index]['title'],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(posts[index]['body']),
            onTap: () => _navigateToPost(context, posts[index]['id']),
          ),
        );
      },
    );
  }

  void _postAlert(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Nuevo Post"),
            content: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      _postTitle(),
                      _postContent(),
                    ],
                  ),
                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    "Volver a la post",
                    style: TextStyle(color: Colors.blue),
                  )),
              FlatButton(
                  onPressed: () async {
                    // _subimt();
                    final response =
                        await Provider.of<PostService>(context, listen: false)
                            .postPost({'key': 'value'});
                    print(response.body);
                    Navigator.of(context).pop();
                    utils.showSnack(
                        context, 'Post : ${titleController.text}creado');
                  },
                  child: Text(
                    "Guardar",
                    style: TextStyle(color: Colors.blue),
                  )),
            ],
          );
        });
  }

  Widget _postTitle() {
    return TextFormField(
      maxLength: 33,
      controller: titleController,
      textCapitalization: TextCapitalization.sentences,
      textAlign: TextAlign.center,
      // onSaved: (value) => posttModel.title = value,
      validator: (value) {
        if (utils.isEmpty(value)) {
          return null;
        } else {
          return "Llenar Campos";
        }
      },
      decoration: InputDecoration(
        labelText: "Titulo",
        labelStyle: TextStyle(color: Colors.blue),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
    );
  }

  Widget _postContent() {
    return TextFormField(
      maxLength: 33,
      controller: bodyController,
      textCapitalization: TextCapitalization.sentences,
      textAlign: TextAlign.center,
      //onSaved: (value) => posttModel.body = value,
      validator: (value) {
        if (utils.isEmpty(value)) {
          return null;
        } else {
          return "Llenar Campos";
        }
      },
      decoration: InputDecoration(
        labelText: "Contenido",
        labelStyle: TextStyle(color: Colors.teal),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.teal),
        ),
      ),
    );
  }

  void _navigateToPost(BuildContext context, int id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PostById(postId: id),
      ),
    );
  }
}
