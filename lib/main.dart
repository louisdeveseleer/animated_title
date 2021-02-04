import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        appBarTheme: AppBarTheme(
          color: Colors.yellow,
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool keyboardIsVisible = false;

  @override
  void initState() {
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        setState(() {
          keyboardIsVisible = visible;
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            elevation: 0,
            floating: false,
            pinned: true,
            stretch: true,
            flexibleSpace: Column(
              children: [
                Expanded(
                  child: Container(),
                ),
                Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 30,
                          color: Theme.of(context).appBarTheme.color,
                        ),
                        Container(
                            height: 30,
                            color: Theme.of(context).scaffoldBackgroundColor),
                      ],
                    ),
                    Positioned(
                      top: 12,
                      width: MediaQuery.of(context).size.width,
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 300),
                        child: Text(
                          'test',
                          style: keyboardIsVisible
                              ? Theme.of(context).textTheme.bodyText2
                              : Theme.of(context).textTheme.headline4,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            expandedHeight: 200,
          ),
          SliverFillRemaining(
            child: Column(
              children: [
                if (!keyboardIsVisible)
                  Expanded(
                    child: Container(),
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Hint text',
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
