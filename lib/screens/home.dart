import 'package:flutter/material.dart';
import 'package:todo/constants/colors.dart';
import 'package:todo/widgets/todo_item.dart';
import 'package:todo/models/todo.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todolist = ToDo.todoList();
  final _todocontroller = TextEditingController();

  List<ToDo>_founttodo = [];
  void _handleTodoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _founttodo = todolist;
    super.initState();
  }

  void _deleteTodochange(ToDo todo){
    setState(() {
      todolist.removeWhere((item) => item.id==todo.id);
    });

  }

  void _addTodoItem(String todo){

    setState(() {
      todolist.add(ToDo(id: DateTime.now().millisecondsSinceEpoch.toString(), todoText: todo));
    });
    _todocontroller.clear();

  }

  void _runfilter(String enteredkeyword){
    List<ToDo> result = [];
    if(enteredkeyword.isEmpty){
      result = todolist;
    }
    else{
      result = todolist.where((item) => item.todoText!.toLowerCase().contains(enteredkeyword.toLowerCase())).toList();
    }
    setState(() {
      _founttodo = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                SearchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50,bottom: 20),
                        child: Text('All ToDOs',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 30,
                        ),),
                      ),
                      for(ToDo todoo in _founttodo)
                      todo_item(todo: todoo,onToDochanged: _handleTodoChange,
                      onDeleteItem: _deleteTodochange),

                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                    left: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow:[BoxShadow(color: Colors.grey, offset:Offset(0.0,0.0),
                    blurRadius: 10.0,
                    spreadRadius: 0.0),],
                  borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller : _todocontroller,
                    decoration: InputDecoration(
                      hintText: 'Add a new ToDo item',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  child: ElevatedButton(
                    onPressed: (){
                        _addTodoItem(_todocontroller.text);
                    },
                    child: Text('+',style:TextStyle(
                      fontSize: 40,
                    ) ,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tdBlue,
                      minimumSize: Size(60, 60),
                      elevation: 10,

                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }


    Widget SearchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runfilter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(Icons.search,color:tdBlack,size: 20,),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'search',
          hintStyle: TextStyle(color: tdGrey)
        ),
      ),
    );
  }
}


AppBar _buildAppBar() {
  return AppBar(
    elevation: 0,
    backgroundColor:tdBGColor,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(Icons.menu,
          color: tdBlack,
          size: 30,),
        Container(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset('assets/images/avatar.jpeg'),
          ),
        )
      ],
    ),
  );

}

