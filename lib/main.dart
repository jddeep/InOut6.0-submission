import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:inout6/botanist_list_page.dart';
import 'package:inout6/shopping_cart.dart';

import 'plantslist.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.green),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(androidFusedLocation: true),
    );
  }
}

class DrawerItem {
  String title;
  DrawerItem(this.title);
}

class MyHomePage extends StatefulWidget {
  final bool androidFusedLocation;

  MyHomePage({
    Key key,

    /// If set, enable the FusedLocationProvider on Android
    @required this.androidFusedLocation,
  }) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  Position _lastKnownPosition;
  Position _currentPosition;
  static int _cartItems = 0;

  void updateItems() {
    setState(() {
      _cartItems++;
    });
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);

    setState(() {
      _lastKnownPosition = null;
      _currentPosition = null;
    });

    _initLastKnownLocation();
    _initCurrentLocation();
  }

  final drawerItems = [
    new DrawerItem("Plants to grow"),
    new DrawerItem(
      "Fertilizers",
    ),
    new DrawerItem("Talk to experts"),
    new DrawerItem("AR mode")
  ];

  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(vsync: this, length: 3);
    super.initState();
    _initLastKnownLocation();
    _initCurrentLocation();
  }

  int _selectedDrawerIndex = 0;

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < drawerItems.length; i++) {
      var d = drawerItems[i];
      drawerOptions.add(
        new ListTile(
            title: new Text(d.title),
            selected: i == _selectedDrawerIndex,
            onTap: () {
              _onSelectItem(i);
              if (i == 2) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BotanistList()));
              }
            }),
      );
      drawerOptions.add(Divider(
        height: 5.0,
        color: Colors.grey,
      ));
    }

    Widget navdrawer() {
      return Drawer(
        child: Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(
                accountName: new Text("Welcome to Augmented Gardens"),
                accountEmail: null),
            new Column(children: drawerOptions)
          ],
        ),
      );
    }

    //   Drawer navdrawer = new Drawer(
    //   child: Column(
    //     children: <Widget>[
    //           new UserAccountsDrawerHeader(
    //               accountName: new Text("John Doe"), accountEmail: null),
    //           new Column(children: drawerOptions)
    //     ],
    //   ),
    // );
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    return Scaffold(
        key: _scaffoldKey,
        drawer: navdrawer(),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => _scaffoldKey.currentState.openDrawer(),
          ),
          title: Text('Augmented Gardens'),
        ),
        body: ListView(
          children: <Widget>[
            SizedBox(height: 15.0),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  // IconButton(
                  //   icon: Icon(Icons.menu),
                  //   onPressed: () {
                  //     navdrawer();
                  //   },
                  // ),
                  Stack(
                    children: <Widget>[
                      Align(
                        alignment: AlignmentDirectional.topEnd,
                        child: FloatingActionButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ShoppingCart()));
                            },
                            backgroundColor: Colors.grey.withOpacity(0.3),
                            mini: true,
                            elevation: 0.0,
                            child: Icon(Icons.shopping_cart,
                                color: Colors.black, size: 17.0)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 4.0, left: 30.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.amber,
                          radius: 10.0,
                          child: Text('$_cartItems'),
                        ),
                      )
                    ],
                    //           child: FloatingActionButton(
                    // onPressed: () {
                    //   Navigator.push(context, MaterialPageRoute(builder: (context)=>ShoppingCart()));
                    // },
                    // backgroundColor: Colors.grey.withOpacity(0.3),
                    // mini: true,
                    // elevation: 0.0,
                    // child: Icon(Icons.shopping_cart,
                    //     color: Colors.black, size: 17.0)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(
                'Top Picks',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 40.0,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: TabBar(
                controller: tabController,
                indicatorColor: Colors.transparent,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey.withOpacity(0.5),
                isScrollable: true,
                tabs: <Widget>[
                  Tab(
                    child: Text(
                      'Vegetables',
                      style: TextStyle(
                          fontSize: 17.0,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Fruits',
                      style: TextStyle(
                          fontSize: 17.0,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Flowers',
                      style: TextStyle(
                          fontSize: 17.0,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 200.0,
              child: TabBarView(
                controller: tabController,
                children: <Widget>[
                  PlantList(updateItems),
                  PlantList(updateItems),
                  PlantList(updateItems),
                ],
              ),
            )
          ],
        ));
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> _initLastKnownLocation() async {
    Position position;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final Geolocator geolocator = Geolocator()
        ..forceAndroidLocationManager = !widget.androidFusedLocation;
      position = await geolocator.getLastKnownPosition(
          desiredAccuracy: LocationAccuracy.best);
    } on PlatformException {
      position = null;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return;
    }

    setState(() {
      _lastKnownPosition = position;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  _initCurrentLocation() {
    Geolocator()
      ..forceAndroidLocationManager = !widget.androidFusedLocation
      ..getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      ).then((position) {
        if (mounted) {
          setState(() => _currentPosition = position);
        }
      }).catchError((e) {
        //
      });
  }
}
