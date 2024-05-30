import 'package:flutter/material.dart';
import 'package:flutter_todos/widgets/background.dart';
import 'package:flutter_todos/widgets/nav_drawer.dart';

class Todos extends StatefulWidget {
  const Todos({super.key});
  static const String routeName = '/HomePage';

  @override
  State<Todos> createState() => _TodosState();
}

class _TodosState extends State<Todos> {
  final List<String> todoList = [
    // "Buy groceries",
    // "Take out the trash",
    // "Dead will rise again",
    // "Born free live free",
    // "What happens to the soules who look in the eyes of draggon",
    // "There is no evil by my contious",
    // "Dead man walking"
  ];

  final TextEditingController _todoTextCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationCustomDrawer(),
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: backgroundContainer(fillbody()),
     
      floatingActionButton: FloatingActionButton(
          onPressed: ()=>_displayDialog(), tooltip: 'Add task', child: const Icon(Icons.add)),
    );
  }

  Widget fillbody(){
    return Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background.jpg"),
                  fit: BoxFit.cover)),
          child: todoList.isNotEmpty
              ? ListView.builder(
                  itemCount: todoList.length,
                  itemBuilder: (context, index) {
                    final item = todoList[index];
                    // return Card(
                    //   color: Colors.white70,
                    //   child: Text(item),
                    // );
                    return Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) {
                       deleteTask(index);
                      },
                      background: Container(),
                      secondaryBackground: Container(
                        color: Colors.black54,
                        child: const Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: Text(
                              "Delete",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      direction: DismissDirection.endToStart,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: Card(
                          elevation: 5,
                          color: Colors.red.withOpacity(0.4),
                          child: ListTile(
                            title: Text(
                              item,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            trailing: const Icon(Icons.clear,color: Colors.white,),
                            onLongPress: () {
                             deleteTask(index);
                            },
                          ),
                        ),
                      ),
                    );
                  
                  },
                )
              : const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        color: Colors.black54,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text(
                                "List is empty",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ));
  }


  Future<void> _displayDialog()async{
    return showDialog<void>(
      context: context, 
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
            backgroundColor: Colors.black,
            title: Text("Add Item",style: Theme.of(context).textTheme.titleMedium,),
            content: TextField(
              controller: _todoTextCont,
              decoration: const InputDecoration(
                hintText: "Enter your task here...",
                filled: true,
                fillColor: Colors.white
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: (){
                  setState(() {
                    todoList.add(_todoTextCont.text);
                  });
                  _todoTextCont.clear();
                  Navigator.of(context).pop();
                }, 
                child: const Text("Add")
                ),
                 TextButton(
                onPressed: (){
                 
                  _todoTextCont.clear();
                  Navigator.of(context).pop();
                }, 
                child: const Text("Cancel")
                ),
            ],
        );
      }
      );
  }

  void deleteTask(int index){
 setState(() {
                                todoList.removeAt(index);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("item is removed")));
                              });
  }
}
