import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_app_redux/models/todo.dart';
import 'package:flutter_app_redux/screens/todo_list/state.dart';
import 'package:flutter_app_redux/screens/todo_list/todo_component/component.dart';

class TodoListAdapter extends DynamicFlowAdapter<TodoListState> {
  TodoListAdapter()
      : super(
          pool: <String, Component<Object>>{
            'todo': TodoComponent(),
          },
          connector: _TodoListConnector(),
        );
}

class _TodoListConnector implements Connector<TodoListState, List<ItemBean>> {
  @override
  List<ItemBean> get(TodoListState state) {
    if (state.todoList?.isNotEmpty == true) {
      return state.todoList
          .map<ItemBean>((Todo data) => ItemBean('todo', data))
          .toList(growable: true);
    } else {
      return <ItemBean>[];
    }
  }

  @override
  void set(TodoListState state, List<ItemBean> todoList) {
    if (todoList?.isNotEmpty == true) {
      state.todoList = List<Todo>.from(
          todoList.map<Todo>((ItemBean bean) => bean.data).toList());
    } else {
      state.todoList = <Todo>[];
    }
  }
}
