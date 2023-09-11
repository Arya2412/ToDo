import 'package:flutter/material.dart';
import 'package:todo/constants/colors.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/screens/home.dart';

class todo_item extends StatelessWidget {
  final ToDo todo;
  final onToDochanged;
  final onDeleteItem;
  const todo_item({Key? key, required this.todo,required this.onDeleteItem, required this.onToDochanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: (){
          onToDochanged(todo);
        },
        contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: Colors.white,
        leading: Icon(todo.isDone? Icons.check_box : Icons.check_box_outline_blank,
          color: tdBlue,
        ),
        title: Text(todo.todoText!,
        style: TextStyle(
          fontSize: 16,
          color: tdBlack,
          decoration:todo.isDone? TextDecoration.lineThrough : null,
        ),
        ),
        trailing: Container(
          height: 35, width: 35,
         // padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: tdRed,
            borderRadius: BorderRadius.circular(5)
          ),
          child: IconButton(
            onPressed: (){
                onDeleteItem(todo);
                print('fhju');
            },

            color: Colors.white,
            iconSize: 18,
            icon: Icon( Icons.delete ),
          ),
        ),
      ),
    );
  }
}
