import 'dart:math';

import 'package:farmapp/model/core/FamilyData.dart';
import 'package:farmapp/utils/AppColorCode.dart';
import 'package:farmapp/utils/Utils.dart';
import 'package:farmapp/views/screens/sevicese/widgets/PopUps/NewRecord.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:sizer/sizer.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseStorage? _storage;

  String? _selectedNodeKey;

  Map<String, dynamic> _familyMapNodes = {};

  final Graph graph = Graph()..isTree = true;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();
  Random r = Random();
  @override
  void initState() {
    _storage = FirebaseStorage.instance;

    SystemChrome.setSystemUIOverlayStyle(Utils.lightNavbar);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColorCode.pureWhite,
      body: ListView(children: [
        // Wrap(
        //   children: [
        //     Container(
        //       width: 100,
        //       child: TextFormField(
        //         initialValue: builder.levelSeparation.toString(),
        //         decoration: InputDecoration(labelText: "Level Separation"),
        //         onChanged: (text) {
        //           builder.levelSeparation = int.tryParse(text) ?? 100;
        //           this.setState(() {});
        //         },
        //       ),
        //     ),
        //     Container(
        //       width: 100,
        //       child: TextFormField(
        //         initialValue: builder.subtreeSeparation.toString(),
        //         decoration: InputDecoration(labelText: "Subtree separation"),
        //         onChanged: (text) {
        //           builder.subtreeSeparation = int.tryParse(text) ?? 100;
        //           this.setState(() {});
        //         },
        //       ),
        //     ),
        //     Container(
        //       width: 100,
        //       child: TextFormField(
        //         initialValue: builder.orientation.toString(),
        //         decoration: InputDecoration(labelText: "Orientation"),
        //         onChanged: (text) {
        //           builder.orientation = int.tryParse(text) ?? 100;
        //           this.setState(() {});
        //         },
        //       ),
        //     ),
        //     ElevatedButton(
        //       onPressed: () {
        //         final node12 = Node.Id(r.nextInt(100));
        //         var edge =
        //             graph.getNodeAtPosition(r.nextInt(graph.nodeCount()));
        //         print(edge);
        //         graph.addEdge(edge, node12);
        //         setState(() {});
        //       },
        //       child: Text("Add"),
        //     )
        //   ],
        // ),
        // Expanded(
        //   child: InteractiveViewer(
        //       constrained: false,
        //       boundaryMargin: EdgeInsets.all(100),
        //       minScale: 0.01,
        //       maxScale: 5.6,
        //       child: GraphView(
        //         graph: graph,
        //         algorithm:
        //             BuchheimWalkerAlgorithm(builder, TreeEdgeRenderer(builder)),
        //         paint: Paint()
        //           ..color = Colors.green
        //           ..strokeWidth = 1
        //           ..style = PaintingStyle.stroke,
        //         builder: (Node node) {
        //           // I can decide what widget should be shown here based on the id
        //           var a = node.key!.value as int;
        //           return rectangleWidget(a);
        //         },
        //       )),
        // ),
        Container(
          height: 100.h,
          child: (_familyMapNodes.isEmpty)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Image.asset('assets/images/logo.png'),
                      height: 25.h,
                      width: 25.w,
                    ),
                    Text(
                      'Empty Family Tree',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text('Please add members using floating button below')
                  ],
                )
              : InteractiveViewer(
                  constrained: false,
                  boundaryMargin: EdgeInsets.all(100),
                  minScale: 0.1,
                  maxScale: 5.6,
                  child: GraphView(
                    graph: graph,
                    algorithm: BuchheimWalkerAlgorithm(
                        builder, TreeEdgeRenderer(builder)),
                    paint: Paint()
                      ..color = Colors.green
                      ..strokeWidth = 1
                      ..style = PaintingStyle.stroke,
                    builder: (Node node) {
                      return getWidget(node.key!.value);
                    },
                  )),
        ),
      ]),
      floatingActionButton: (_familyMapNodes.length != 0)
          ? SizedBox()
          : FloatingActionButton(
              onPressed: () async {
                Utils.familyData = null;
                await showDialog(
                  context: context,
                  builder: (_) => NewRecord(),
                ).then((onValue) {
                  if (Utils.familyData != null) {
                    _addMemberToList(Utils.familyData!);
                  }
                });
              },
              child: const Icon(Icons.add),
              backgroundColor: Colors.green,
            ),
    ));
  }

  Widget rectangleWidget(int a) {
    return InkWell(
      onTap: () {
        print('clicked');
      },
      child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(color: Colors.blue, spreadRadius: 1),
            ],
          ),
          child: Text('Node ${a}')),
    );
  }

  Widget getWidget(key) {
    FamilyData _data = _familyMapNodes[key]['data'];

    return InkWell(
      onTap: () {
        _selectedNodeKey = _data.id;
      },
      child: GestureDetector(
        onTap: () async {
          _selectedNodeKey = key;
          Utils.familyData = null;
          await showDialog(
            context: context,
            builder: (_) => NewRecord(),
          ).then((onValue) {
            if (Utils.familyData != null) {
              _addMemberToList(Utils.familyData!);
            }
          });
        },
        onLongPress: () {},
        child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: AppColorCode.black),
            child: Column(
              children: [
                SizedBox(
                  height: 50.0,
                  width: 50.0,
                  child: (_data.imgType == 1)
                      ? Image.asset(_data.img)
                      : Image.memory(_data.img),
                ),
                Text(
                  _data.name,
                  style: TextStyle(color: AppColorCode.pureWhite),
                )
              ],
            )),
      ),
    );
  }

  _addMemberToList(FamilyData _member) {
    _member.id = _getKey();
    _member.selectedId = _selectedNodeKey;

    graph.graphObserver.clear();

    _familyMapNodes[_member.id] = {
      'node': Node.Id(_member.id),
      'data': _member
    };

    _familyMapNodes.forEach((key, record) {
      if (record['data'].selectedId == null) {
        graph.addNode(record['node']);
      } else {
        if (record['data'].type == 1 || record['data'].type == 2) {
          graph.addEdge(_familyMapNodes[record['data'].selectedId]['node'],
              record['node']);
        } else {
          graph.addEdge(record['node'],
              _familyMapNodes[record['data'].selectedId]['node']);
        }
      }
    });

    if (_familyMapNodes.length == 1) {
      builder
        ..siblingSeparation = (50)
        ..levelSeparation = (50)
        ..subtreeSeparation = (50)
        ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_BOTTOM_TOP);
    }

    setState(() {});
  }

  _getKey() {
    return "node" + DateTime.now().millisecondsSinceEpoch.toString();
  }
}
