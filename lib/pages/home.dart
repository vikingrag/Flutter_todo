import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


class Home extends StatefulWidget {
  const Home ({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late String _userToDo;
  List todoList = [];

  void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initFirebase();

    todoList.addAll(['Buy milk', 'Wash dishes', 'Купит картошку']);
  }

  void _menuOpen() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BildContext) {
        return Scaffold(
          appBar: AppBar(title: Text('Меню'),),
          body: Row (
            children: [
              ElevatedButton(onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              }, child: Text('На главную')),
              Padding(padding: EdgeInsets.only(left: 15)),
              Text('Наше простое меню')
            ],
          )
        );
      })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text('Cписок дел'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _menuOpen,
              icon: Icon(Icons.menu_open_sharp),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: todoList.length,
          itemBuilder: (BuildContext context, int index) {
          return Dismissible(key:
          Key(todoList[index]),
              child: Card(
                child: ListTile(
                    title: Text(todoList[index]),
                        trailing: IconButton(
                    icon: Icon(
                      Icons.delete_sweep,
                      color: Colors.deepOrangeAccent
                    ),
                          onPressed: () {
                            setState(() {
                              todoList.removeAt(index);
                            });
                          },
                ),
                ),
              ),
            onDismissed: (direction) {
            // if(direction == DismissDirection.endToStart );
              setState(() {
                todoList.removeAt(index);
              });
            },
          );
          }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        onPressed: () {
          showDialog(context: context, builder: (BuildContext context){
            return AlertDialog(
              title: Text('Добавить элемент'),
              content: TextField(
                onChanged: (String value) {
                  _userToDo = value;
                },
              ),
              actions: [
                ElevatedButton(onPressed: () {
                  FirebaseFirestore.instance.collection('items').add({'item':_userToDo});
                  Navigator.of(context).pop();
                }, child: Text('Добавить'))
              ],
            );
          });

        },
        child: Icon(
          Icons.add_box,
          color: Colors.white,
        )
      ),

    );
  }
}
