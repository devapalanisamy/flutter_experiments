import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

enum Actions { Increment }

int counterReducer(int state, dynamic action) {
  if (action == Actions.Increment) {
    return state + 1;
  }
  return state;
}

void main() {
  final store =  Store<int>(counterReducer, initialState: 0);
  runApp(MyApp(
    title: 'Great',
    store: store,
  ));
}

class MyApp extends StatelessWidget {
  final Store<int> store;
  final String title;

  MyApp({Key key, this.store, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreProvider<int>(
        store: store,
        child: new MaterialApp(
          theme: ThemeData.dark(),
          title: 'Great',
          home: new Scaffold(
            appBar: AppBar(
              title: Text('Great1'),
            ),
            body: Center(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('You clicked the button these many times:'),
                  StoreConnector<int, String>(
                    converter: (store) => store.state.toString(),
                    builder: (context, count) => Text(
                          count,
                          style: Theme.of(context).textTheme.display1,
                        ),
                  )
                ],
              ),
            ),
            floatingActionButton: StoreConnector<int, VoidCallback>(
                builder: (context, callback) {
                  return FloatingActionButton(
                    onPressed: callback,
                    tooltip: 'Increment count',
                    child: Icon(Icons.add),
                  );
                },
                converter: (store) {
                      return () => store.dispatch(Actions.Increment);
                } ),
          ),
        )
    );
  }
}

