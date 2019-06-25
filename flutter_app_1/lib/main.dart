import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

void main()
{
  final store = Store<String>(updateTextReducer, initialState: 'Hello');
  runApp(MyApp(title: 'Great App',
      store: store));
}

class UpdateAction {
  final String item;

  UpdateAction(this.item);
}

//enum Actions {Update}

String updateTextReducer(String state, dynamic action)
{
  if(action is UpdateAction)
    {
      return action.item;
    }
  return state;
}

typedef OnStateChanged = Function(String item);

class MyApp extends StatelessWidget {
  final Store<String> store;
  final String title;

  MyApp({Key key, this.store, this.title}) : super(key: key);



  @override
  Widget build(BuildContext context) {

  return StoreProvider<String>(
    store: store,
    child: MaterialApp(
      title: 'Great2',
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text(title)
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                                StoreConnector<String,OnStateChanged>(
                                  converter: (store) {
                                    return (item) => store.dispatch(UpdateAction(item));
                                  },
                                  builder: (context, callback) {
                                    return TextField(
                                      onChanged: (text) => callback(text),
                                      style: Theme.of(context).textTheme.display2,
                                    );
                                  }
                                ),
                                StoreConnector<String,String>(
                                  converter: (store) => store.state,
                                  builder: (context, text) => Text(
                                    text,
                                    style: Theme.of(context).textTheme.display1,
                                  ),
                                )
            ],
          ),
        ),
      ),
    ),
  );
  }
}

