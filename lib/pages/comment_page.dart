// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todos/services/commentDao.dart';
import 'package:flutter_todos/widgets/background.dart';
import 'package:flutter_todos/widgets/beveled_button.dart';
import '../models/comment.dart';
import '../services/auth_service.dart';
import '../widgets/nav_drawer.dart';
import 'login_page.dart';

class Comment_Page extends StatefulWidget {
  Comment_Page({super.key});
  static const String routeName = '/Comment';
  final commentDao = CommentDao();
  final autoDao = AuthenticationHelper();

  @override
  State<Comment_Page> createState() => _Comment_PageState();
}

class _Comment_PageState extends State<Comment_Page> {
  final Future<FirebaseApp> _future = Firebase.initializeApp();
  final _nameController = TextEditingController();
  final _commentController = TextEditingController();
  String Key = "";
  bool editStatus = false;

  @override
  void initState() {
    // TODO: implement initState

    final connectRef = widget.commentDao.getMessageQuery();
    connectRef.keepSynced(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationCustomDrawer(),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Comment Page'),       
        actions: <Widget>[
          IconButton(
              onPressed: () {
                widget.autoDao.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: backgroundContainer(fillbody()),
    );
  }

  Widget fillbody() {
    return (FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error");
          } else {
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(hintText: "Enter name"),
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: _commentController,
                    decoration:
                        const InputDecoration(hintText: "Enter comment"),
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: beveledButton(
                        title: "Save",
                        onTap: () {
                          String name = _nameController.text;
                          String comment = _commentController.text;

                          _saveComment(name, comment);
                        }),
                  ),
                ),
                _getMessageList(),
              ],
            );
          }
        }));
  }

  Widget _getMessageList() {
    return Expanded(
        child: FirebaseAnimatedList(
      query: widget.commentDao.getMessageQuery(),
      itemBuilder: (context, snapshot, animation, index) {
        final json = snapshot.value as Map<dynamic, dynamic>;
        final comment = Comment.fromJson(json);
        // return ListTile(
        //   title: Text(comment.name),
        //   subtitle: Text(comment.comment),);
        return Card(
            elevation: 10.0,
            //color: Colors.grey.withOpacity(0.7),
            child: ListTile(
              title: Text(comment.name),
              subtitle: Text(comment.comment),
              trailing: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          editStatus = true;
                          _nameController.text = comment.name;
                          _commentController.text = comment.comment;
                          Key = snapshot.key.toString();
                          _clearData();
                        },
                        icon: const Icon(Icons.edit)),
                    IconButton(
                        onPressed: () {
                          widget.commentDao
                              .deleteComment(snapshot.key.toString());
                          _clearData();
                        },
                        icon: const Icon(Icons.delete)),
                  ]),
            ));
      },
    ));
  }

  /// crud logic
  void _saveComment(String name, String comment) {
    final _comment =
        Comment(name: name.toUpperCase(), comment: comment.toLowerCase());

    switch (editStatus) {
      case false:
        widget.commentDao.saveComment(_comment);
        break;
      case true:
        widget.commentDao.upadateComment(Key, _comment);
        editStatus = false;
        break;
    }

    _clearData();
  }

  void _clearData() {
    _nameController.clear();
    _commentController.clear();
  }
}
