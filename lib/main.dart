// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:collection/collection.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OKARINA Page',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<void> _loadingFuture;
  final List<String> notes = [
    'G4.ogg',
    'G#4.ogg',
    'A4.ogg',
    'A#4.ogg',
    'B4.ogg',
    'C5.ogg',
    'C#5.ogg',
    'D5.ogg',
    'D#5.ogg',
    'E5.ogg',
    'F5.ogg',
    'F#5.ogg',
    'G5.ogg',
    'G#5.ogg',
    'A5.ogg',
    'A#5.ogg',
    'B5.ogg',
    'C6.ogg',
    'C#6.ogg',
    'D6.ogg',
    'D#6.ogg',
    'E6.ogg',
    'F6.ogg',
    'F#6.ogg',
    'G6.ogg',
    'G#6.ogg',
    'A6.ogg',
    'A#6.ogg',
    'B6.ogg',
    'C7.ogg',
    'C#7.ogg',
    'D7.ogg',
    'D#7.ogg',
  ];

  Map<int,List<int>> fingers = {
    5:   [0, 1, 1, 1, 1],
    7:   [0, 1, 1, 0, 1],
    9:   [0, 1, 1, 1, 0],
    10:  [0, 1, 1, 0, 0],

    11:  [0, 0, 1, 1, 1],
    12:  [0, 0, 1, 0, 1],
    13:  [0, 0, 1, 1, 0],
    14:  [0, 0, 1, 0, 0],

    4:   [0, 1, 0, 1, 1],
    20:  [0, 1, 0, 0, 1],
    8:   [0, 1, 0, 1, 0],
    19:  [0, 1, 0, 0, 0],

    0:   [0, 0, 0, 1, 1],
    15:  [0, 0, 0, 0, 1],
    16:  [0, 0, 0, 1, 0],

    17:  [1, 0, 0, 0, 0]
  };

  List<AudioPlayer> players = [];


  var color1 = Color(0xff82C2F1);
  var color2 = Color(0xffE65E5E);

  var clickedList = [0,0,0,0,0];
  var nowPlaying = 0;

  var settingOpened = false;

  var scaleList = ['C','C#','D','D#','E','F','F#','G','G#','A','A#','B'];
  var nowScale = 0;
  void _changeScale(int v){
    setState((){
      nowScale=v;
    });
  }

  double _volume = 70.0;
  void _changeVolume(double v){
    setState(() {
      _volume = v;
    });
  }



  void playSound() async{
    var exPlayed = nowPlaying;

    players[exPlayed].pause();

    for(var i in fingers.keys){
      bool equal = true;
      for(int j=1;j<5;j++){
        if(clickedList[j] != fingers[i]?[j]){
          equal = false;
        }
      }
      if(equal){
        nowPlaying = i+nowScale;
        players[nowPlaying].resume();
      }
    }


  }


  @override
  void initState() {
    super.initState();
    for (int i = 0; i < notes.length; i++) {
      players.add(AudioPlayer());
      players[i].setPlayerMode(PlayerMode.lowLatency);
    }
    _loadingFuture = _loadData();
  }

  Future<void> _loadData() async {
    try {
      var futures = List.generate(notes.length, (i) {
        return players[i].setSource(AssetSource(notes[i])).then((_) {
          print("############# ${notes[i]} Loaded");
        });
      });

      await Future.wait(futures);
      print("############## All Loaded");
    } catch (e) {
      print('##############$e');
    }
  }


    // Future<void> _loadData() async {
    //   try {
    //     var futures = List.generate(notes.length, (i) {
    //       return players[i].setSource(AssetSource(notes[i])).then((_) {
    //         print("############# ${notes[i]} Loaded");
    //       });
    //     });
    //
    //     await Future.wait(futures);
    //     print("############## All Loaded");
    //     await players[0].resume();
    //   } catch (e) {
    //     print('##############$e');
    //   }
    // }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _loadingFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error loading assets'),
            );
          } else {
            return buildMainContent(context);
          }
        },
      ),
    );
  }

  Widget buildMainContent(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 100,),
          Center(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 500,
                  color: Colors.black,
                ),


                Positioned(
                  left: 74,
                  top: 0,
                  width: 60,
                  height: 60,
                  child: GestureDetector(
                    onPanStart: (details) {
                      setState(() {
                        clickedList[0] = 1;
                      });
                      playSound();
                    },
                    onPanEnd: (details) {
                      setState(() {
                        clickedList[0] = 0;
                      });
                      playSound();
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Container(
                      decoration: BoxDecoration(
                        color: clickedList[0]==1 ? color2 : color1,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child:
                        Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            border: Border.all(
                              color: Colors.black,
                              width: 4,
                            )
                          ),
                        )
                    ),
                  ),
                ),
                Positioned(
                  left: 104,
                  top: 151,
                  width: 70,
                  height: 70,
                  child: GestureDetector(
                    onPanStart: (details) {
                      setState(() {
                        clickedList[1] = 1;
                      });
                      playSound();
                    },
                    onPanEnd: (details) {
                      setState(() {
                        clickedList[1] = 0;
                      });
                      playSound();
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Container(
                      decoration: BoxDecoration(
                        color: clickedList[1]==1 ? color2 : color1,
                        borderRadius: BorderRadius.all(Radius.circular(35)),
                      ),
                        child:Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              border: Border.all(
                                color: Colors.black,
                                width: 4,
                              )
                          ),
                        )
                    ),
                  ),
                ),
                Positioned(
                  left: 64,
                  top: 320,
                  width: 80,
                  height: 80,
                  child: GestureDetector(
                    onPanStart: (details) {
                      setState(() {
                        clickedList[2] = 1;
                      });
                      playSound();
                    },
                    onPanEnd: (details) {
                      setState(() {
                        clickedList[2] = 0;
                      });
                      playSound();
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Container(
                      decoration: BoxDecoration(
                        color: clickedList[2]==1 ? color2 : color1,
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                      ),
                      child:Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            border: Border.all(
                              color: Colors.black,
                              width: 4,
                            )
                        ),
                      )
                    ),
                  ),
                ),


                Positioned(
                  right: 78,
                  top: 50,
                  width: 70,
                  height: 70,
                  child: GestureDetector(
                    onPanStart: (details) {
                      setState(() {
                        clickedList[3] = 1;
                      });
                      playSound();
                    },
                    onPanEnd: (details) {
                      setState(() {
                        clickedList[3] = 0;
                      });
                      playSound();
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Container(
                      decoration: BoxDecoration(
                        color: clickedList[3]==1 ? color2 : color1,
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                      ),
                      child:Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              border: Border.all(
                                color: Colors.black,
                                width: 4,
                              )
                          ),
                        )
                    ),
                  ),
                ),
                Positioned(
                  right: 64,
                  top: 239,
                  width: 75,
                  height: 75,
                  child: GestureDetector(
                    onPanStart: (details) {
                      setState(() {
                        clickedList[4] = 1;
                      });
                      playSound();
                    },
                    onPanEnd: (details) {
                      setState(() {
                        clickedList[4] = 0;
                      });
                      playSound();
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Container(
                      decoration: BoxDecoration(
                        color: clickedList[4]==1 ? color2 : color1,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      child:Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              border: Border.all(
                                color: Colors.black,
                                width: 4,
                              )
                          ),
                        )
                    ),
                  ),
                ),


              settingWidget(
                settingOpened : settingOpened,
                volume : _volume,
                changeVolume : _changeVolume,
                scaleList: scaleList,
                nowScale: nowScale,
                changeScale: _changeScale,
              )

              ],
            ),
          ),
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(40))
            ),
            child: IconButton(
              icon: Icon(Icons.settings_outlined,
                size:30,
              ),
              onPressed: (){
                setState(() {
                  settingOpened = !settingOpened;
                });
                print('$settingOpened');
              },
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              
            ),
          )
        ],
      ),
    );
  }
}


class settingWidget extends StatefulWidget {
  const settingWidget({
    Key? key,
    required this.settingOpened,
    required this.volume,
    required this.changeVolume,
    required this.scaleList,
    required this.nowScale,
    required this.changeScale,

  }) : super(key: key);

  final bool settingOpened;
  final double volume;
  final Function changeVolume;
  final List scaleList;
  final int nowScale;
  final Function changeScale;


  @override
  State<settingWidget> createState() => _settingWidgetState();
}

class _settingWidgetState extends State<settingWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          AnimatedContainer(
              duration: Duration(milliseconds: 400),
              margin: EdgeInsets.only(top : widget.settingOpened ? 250 : 550),
              padding: EdgeInsets.fromLTRB(20,10, 20,10),
              width: widget.settingOpened ? 300 : 0,
              height: widget.settingOpened ? 230 : 0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30))
              ),
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Note',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  Container(
                    height: 70,
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    // color: Colors.red,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.scaleList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 50,
                          height: 50,
                          margin: EdgeInsets.only(left: 5, right: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: widget.nowScale==index ? Colors.black38 : Colors.black12,
                          ),
                          child: TextButton(
                            child: Text(widget.scaleList[index],style: TextStyle(color: Colors.black),),
                            // style: ButtonStyle(
                            //
                            // ),
                            onPressed: () {
                              widget.changeScale(index);
                            },
                          )
                        );
                      },
                    ),
                  ),
                  Text('Volume',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  Container(
                    height: 30,
                    width: double.infinity,
                    // color: Colors.red,
                    child: CupertinoSlider(
                      value: widget.volume,
                      max: 100,
                      activeColor: Colors.black,
                      thumbColor: Colors.black,
                      onChanged: (double value){
                        setState(() {
                          widget.changeVolume(value);
                        });
                      },
                    ),
                  )
                ],
              )
          ),
        ],
      ),
    );
  }
}
