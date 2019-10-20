import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'call.dart';

class BotanistList extends StatefulWidget {
  @override
  _BotanistListState createState() => _BotanistListState();
}

class _BotanistListState extends State<BotanistList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose a botanist to talk to',
            style: TextStyle(color: Colors.white)),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8.0),
            height: 90.0,
            child: Card(
              elevation: 10.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconTheme(
                    data: IconThemeData(color: Colors.green),
                    child: Icon(Icons.person),
                  ),
                  Text(
                    'Dr. Shiv Luthra',
                  ),
                  IconTheme(
                    data: IconThemeData(color: Colors.green),
                    child: IconButton(
                      icon: Icon(Icons.play_arrow),
                      onPressed: () {
                        onJoin();
                        // Navigator.pushReplacement(context,
                        // MaterialPageRoute(builder: (context)=>IndexPage())
                        // );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            height: 90.0,
            child: Card(
              elevation: 10.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconTheme(
                    data: IconThemeData(color: Colors.green),
                    child: Icon(Icons.person),
                  ),
                  Text(
                    'Dr. Narayan',
                  ),
                  IconTheme(
                    data: IconThemeData(color: Colors.green),
                    child: IconButton(
                      icon: Icon(Icons.play_arrow),
                      onPressed: () {
                        onJoin();
                        // Navigator.pushReplacement(context,
                        // MaterialPageRoute(builder: (context)=>IndexPage())
                        // );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            height: 90.0,
            child: Card(
              elevation: 10.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconTheme(
                    data: IconThemeData(color: Colors.green),
                    child: Icon(Icons.person),
                  ),
                  Text(
                    'Dr. Abhinav Paul',
                  ),
                  IconTheme(
                    data: IconThemeData(color: Colors.green),
                    child: IconButton(
                      icon: Icon(Icons.play_arrow),
                      onPressed: () {
                        onJoin();
                        // Navigator.pushReplacement(context,
                        // MaterialPageRoute(builder: (context)=>IndexPage())
                        // );
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  onJoin() async {
    // update input validation
    // setState(() {
    //   _channelController.text.isEmpty
    //       ? _validateError = true
    //       : _validateError = false;
    // });
    // await for camera and mic permissions before pushing video page
    await _handleCameraAndMic();
    // push video page with given channel name
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => new CallPage(
                // channelName: _channelController.text,
                )));
  }

  _handleCameraAndMic() async {
    await PermissionHandler().requestPermissions(
        [PermissionGroup.camera, PermissionGroup.microphone]);
  }
}
