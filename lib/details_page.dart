import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sqflite_database/database_helper.dart';
import 'package:sqflite_database/todo_model.dart';

class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController nameEditingController = TextEditingController();
  int? _id;

  Random random = Random();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details page'),
        centerTitle: true,
      ),
      body: Column(
        children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              children: [
                TextField(
                  controller: nameEditingController,
                  decoration: InputDecoration(
                    hintText: 'Name',
                  ),
                ),
                TextField(
                  controller: titleEditingController,
                  decoration: InputDecoration(
                    hintText: 'Title',
                  ),
                ),
              ],
            ),
        ),
          SizedBox(height: 10,),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });

                        final todo = Todo(
                          id: random.nextInt(1000),
                          name: nameEditingController.text.toString(),
                          title: titleEditingController.text.toString(),
                        );

                        await DatabaseHelper.instance.addTodos(todo);
                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: Text('ADD')),
                ),


                SizedBox(width: 5,),
                // update button

                Expanded(
                  child: ElevatedButton(
                      onPressed: () async {
                        // final todo = Todo(
                        //       id: _id,
                        //   name: nameEditingController.text,
                        //   title: titleEditingController.text,
                        // );

                   //    await DatabaseHelper.instance.upDateTodo(todo);

                      },
                      child: Text('Update')),
                ),


              ],


            ),
          ),


          Expanded(
              child: FutureBuilder(
                  future: DatabaseHelper.instance.getTodos(),
                  builder: (context, AsyncSnapshot<List<Todo>> snapshot) {
                    if (snapshot.hasError) {
                      return Text("Error");
                    }
                    return snapshot.data!.isEmpty
                        ? Text("No Data Found")
                        : ListView(
                            children: snapshot.data!.map((Todo todo) {
                              return ListTile(
                                title: Text(todo.name),
                                subtitle: Text(todo.title),
                                // update and edit

                                leading: IconButton(
                                  onPressed: () async {

                                    setState(() {
                                       _id = todo.id!;
                                       nameEditingController.text= todo.name!;
                                       titleEditingController.text= todo.title!;

                                    });


                                  },
                                  icon: Icon(Icons.edit),
                                ),


                                // Delet Button
                                trailing: IconButton(
                                  onPressed: () async {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    await DatabaseHelper.instance
                                        .delteTodo(todo.id);
                                    setState(() {
                                      isLoading = false;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                  })),
        ],
      ),
    );
  }
}
