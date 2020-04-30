import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter WebSocket Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Flutter Demo Home Page',
        channel: IOWebSocketChannel.connect(
          'wss://echo.websocket.org/',
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, @required this.title, @required this.channel})
      : super(key: key);
  final String title;
  final WebSocketChannel channel;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController textEditingController = new TextEditingController();
  List list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: TextFormField(
                controller: textEditingController,
                decoration: InputDecoration(
                  labelText: 'Enter a message',
                ),
              ),
            ),
          ),
          FlatButton(
            color: Colors.orange,
            onPressed: _sendmsg,
            child: Icon(Icons.send),
          ),
          StreamBuilder(
            stream: widget.channel.stream,
            builder: (context, snapshot) {
              print("connection state ${snapshot.connectionState}");
              print("data ${snapshot.data}");
              print("error ${snapshot.error}");
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 24.0,
                ),
                child: Text(snapshot.hasData ? '${snapshot.data}' : ''),
              );
            },
          ),
        ],
      ),
    );
  }

  void _sendmsg() {
    if (textEditingController.text.isNotEmpty) {
      widget.channel.sink.add(textEditingController.text);
      textEditingController.text = '';
    }
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }
}
