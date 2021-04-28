import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
//import 'do_reflect.dart';
//import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:iu_bus_schedule/requests/google_maps_requests.dart';
import 'package:iu_bus_schedule/states/app_state.dart';
import 'package:iu_bus_schedule/utils/core.dart';
import 'package:http/http.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';





class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  Future<Timer> loadData() async{
    return new Timer(Duration(seconds:  2), onDoneLoading);
  }
  onDoneLoading() async{
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> FirstScreen(),),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.lightBlue),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50.0,
                        child: Icon(
                          Icons.directions_bus,
                          color: Colors.blueAccent[700],
                          size: 50.0,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 10.0),),
                      Text(
                        "Silver Bus",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(padding: EdgeInsets.only(top: 20.0),),
                    Text("Loading",style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}




class FirstScreen extends StatelessWidget {


  @override
  CarouselSlider carouselSlider;
  int _current = 0;
  List imgList = [
    'https://upload.wikimedia.org/wikipedia/commons/6/6a/Iub_mainGate.jpg',
    'https://media.licdn.com/dms/image/C511BAQH1nKuLGC7LQA/company-background_10000/0?e=2159024400&v=beta&t=8UmkkratuferxfCoBl2lgPdZ6IAtGYIdP2mM7NKCX4k',
    'https://nu-edu-bd.net/wp-content/uploads/2018/02/public_uni_images/Islamic-University-Photo.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/0/0b/Kushtia_Islamic_University_Auditorium%2C_Kushtia%2C_Bangladesh.jpg',
    'https://i.ytimg.com/vi/Tsxap-hVXoU/hqdefault.jpg'
  ];




  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  Widget build(BuildContext context) {

    var carouselSlider;
    return Scaffold(
        drawer:
        Container(
          color: Colors.blueGrey[800],
          child: Drawer(
            child:ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  color: Colors.blueGrey,
                  height: 260,

                  child: Container(
                    height: 100,
                    width: 60,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 60.0,right: 60.0,bottom: 20.0,top: 20.0,),
                      child: DrawerHeader(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("images/iu.png",
                              ),

                              fit: BoxFit.contain),
                        ),
                      ),
                    ),
                  ),
                ),

                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),

                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Setting'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  leading: Icon(Icons.feedback),
                  title: Text('Feedback'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  leading: Icon(Icons.rate_review),
                  title: Text('Rate us'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),

              ],
            ), // Populate the Drawer in the next step.
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[600],
          title: Text('IU Bus Schedule'),
        ),
        body: Container(

          alignment: Alignment.topCenter,
          margin: EdgeInsets.all(2.0),
          color: Colors.white,
          child: new ListView(
            padding: const EdgeInsets.all(2.0),
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  carouselSlider = CarouselSlider(
                    height: 400.0,
                    initialPage: 0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    reverse: false,
                    enableInfiniteScroll: true,
                    autoPlayInterval: Duration(seconds: 2),
                    autoPlayAnimationDuration: Duration(milliseconds: 2000),
                    pauseAutoPlayOnTouch: Duration(seconds: 10),
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index) {
                      setState(() {
                        _current = index;
                      });
                    },
                    items: imgList.map((imgUrl) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            margin: EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                              color: Colors.green,
                            ),
                            child: Image.network(
                              imgUrl,
                              fit: BoxFit.fill,
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  SizedBox(
                    height: 20.0,
                  ),

                ],
              ),





              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                      child: new GestureDetector(

                        child: new Container(
                          alignment: Alignment.center,
                          height: 60.0,

                          decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                          child: new Text("Track Your Bus",style: new TextStyle(fontSize: 35.0,color: Colors.white),),
                        ),
                        onTap: () {
                          //Use`Navigator` widget to push the second screen to out stack of screens
                          Navigator.of(context)
                              .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                            return new  MyHomePage ();
                          }));
                        },
                      ),),),
                ],
              ),

              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                      child: new GestureDetector(

                        child: new Container(
                          alignment: Alignment.center,
                          height: 60.0,

                          decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                          child: new Text("Teacher's",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                        ),
                        onTap: () {
                          //Use`Navigator` widget to push the second screen to out stack of screens
                          Navigator.of(context)
                              .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                            return new SecondScreen();
                          }));
                        },
                      ),),),
                  Expanded(
                    child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                      child: new GestureDetector(

                        child: new Container(
                          alignment: Alignment.center,
                          height: 60.0,

                          decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                          child: new Text("Student's",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                        ),
                        onTap: () {
                          //Use`Navigator` widget to push the second screen to out stack of screens
                          Navigator.of(context)
                              .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                            return new ThirdScreen();
                          }));
                        },
                      ),),),

                ],


              ),



              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                      child: new GestureDetector(

                        child: new Container(
                          alignment: Alignment.center,
                          height: 60.0,

                          decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                          child: new Text("Stuff's",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                        ),
                        onTap: () {
                          //Use`Navigator` widget to push the second screen to out stack of screens
                          Navigator.of(context)
                              .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                            return new FourthScreen();
                          }));
                        },
                      ),),),

                  Expanded(
                    child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                      child: new GestureDetector(

                        child: new Container(
                          alignment: Alignment.center,
                          height: 60.0,

                          decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                          child: new Text("Search",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                        ),
                        onTap: () {
                          //Use`Navigator` widget to push the second screen to out stack of screens
                          Navigator.of(context)
                              .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                            return new FifthScreen();
                          }));
                        },
                      ),),),

                ],



              )
            ],
          ),
        )
    );



  }

  void setState(Null Function() param0) {}
}
class SecondScreen  extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[600],
        title: Text("Teacher's Bus Schedule"),
      ),
      body: new Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        child: new ListView(
            padding: const EdgeInsets.all(2.0),
            children: <Widget>[

              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Padding(
                    padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new Text("Schedule",style: TextStyle(fontSize: 40.0),),
                  )
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Padding(padding: const EdgeInsets.all(10.0),
                      child: new GestureDetector(

                        child: new Container(
                          alignment: Alignment.center,
                          height: 60.0,


                          decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                          child: new Text("IU to Kushtia",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                        ),
                        onTap: () {
                          //Use`Navigator` widget to push the second screen to out stack of screens
                          Navigator.of(context)
                              .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                            return new SixthScreen();
                          }));
                        },
                      ),
                    ),
                  ),
                ],
              ),


              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Expanded(
                    child: Padding(padding: const EdgeInsets.all(10.0),
                      child: new GestureDetector(

                        child: new Container(
                          alignment: Alignment.center,
                          height: 60.0,


                          decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                          child: new Text("Kushtia to IU",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                        ),
                        onTap: () {
                          //Use`Navigator` widget to push the second screen to out stack of screens
                          Navigator.of(context)
                              .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                            return new SeventhScreen();
                          }));
                        },
                      ),
                    ),
                  ),


                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Expanded(
                    child: Padding(padding: const EdgeInsets.all(10.0),
                      child: new GestureDetector(

                        child: new Container(
                          alignment: Alignment.center,
                          height: 60.0,


                          decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                          child: new Text("IU to Jhenaidah",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                        ),
                        onTap: () {
                          //Use`Navigator` widget to push the second screen to out stack of screens
                          Navigator.of(context)
                              .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                            return new EighthScreen();
                          }));
                        },
                      ),
                    ),
                  ),



                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Expanded(
                    child: Padding(padding: const EdgeInsets.all(10.0),
                      child: new GestureDetector(

                        child: new Container(
                          alignment: Alignment.center,
                          height: 60.0,


                          decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                          child: new Text("Jhenaidah to IU",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                        ),
                        onTap: () {
                          //Use`Navigator` widget to push the second screen to out stack of screens
                          Navigator.of(context)
                              .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                            return new NinethScreen();
                          }));
                        },
                      ),
                    ),
                  ),



                ],
              ),
            ]
        ),

      ),

    );
  }
}
class ThirdScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[600],
        title: Text("Student's Bus Schedule"),
      ),
      body: new Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        child: new ListView(
            padding: const EdgeInsets.all(2.0),
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Padding(padding: const EdgeInsets.all(10.0),
                      child: new GestureDetector(

                        child: new Container(
                          alignment: Alignment.center,
                          height: 60.0,


                          decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                          child: new Text("IU to Kushtia",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                        ),
                        onTap: () {
                          //Use`Navigator` widget to push the second screen to out stack of screens
                          Navigator.of(context)
                              .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                            return new TenthScreen();
                          }));
                        },
                      ),
                    ),
                  ),
                ],
              ),


              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Expanded(
                    child: Padding(padding: const EdgeInsets.all(10.0),
                      child: new GestureDetector(

                        child: new Container(
                          alignment: Alignment.center,
                          height: 60.0,


                          decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                          child: new Text("Kushtia to IU",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                        ),
                        onTap: () {
                          //Use`Navigator` widget to push the second screen to out stack of screens
                          Navigator.of(context)
                              .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                            return new EleventhScreen();
                          }));
                        },
                      ),
                    ),
                  ),


                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Expanded(
                    child: Padding(padding: const EdgeInsets.all(10.0),
                      child: new GestureDetector(

                        child: new Container(
                          alignment: Alignment.center,
                          height: 60.0,


                          decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                          child: new Text("IU to Jhenaidah",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                        ),
                        onTap: () {
                          //Use`Navigator` widget to push the second screen to out stack of screens
                          Navigator.of(context)
                              .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                            return new TwelvethScreen();
                          }));
                        },
                      ),
                    ),
                  ),



                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Expanded(
                    child: Padding(padding: const EdgeInsets.all(10.0),
                      child: new GestureDetector(

                        child: new Container(
                          alignment: Alignment.center,
                          height: 60.0,


                          decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                          child: new Text("Jhenaidah to IU",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                        ),
                        onTap: () {
                          //Use`Navigator` widget to push the second screen to out stack of screens
                          Navigator.of(context)
                              .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                            return new ThirteenthScreeen();
                          }));
                        },
                      ),
                    ),
                  ),



                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Padding(padding: const EdgeInsets.all(10.0),
                      child: new GestureDetector(

                        child: new Container(
                          alignment: Alignment.center,
                          height: 60.0,


                          decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                          child: new Text("IU to Shailkupa",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                        ),
                        onTap: () {
                          //Use`Navigator` widget to push the second screen to out stack of screens
                          Navigator.of(context)
                              .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                            return new  MyHomePage ();
                          }));
                        },
                      ),
                    ),
                  ),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Padding(padding: const EdgeInsets.all(10.0),
                      child: new GestureDetector(

                        child: new Container(
                          alignment: Alignment.center,
                          height: 60.0,


                          decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                          child: new Text("Shailkupa to IU",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                        ),
                        onTap: () {
                          //Use`Navigator` widget to push the second screen to out stack of screens
                          Navigator.of(context)
                              .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                            return new TwentySixScreen();
                          }));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ]
        ),

      ),
    );
  }

}



class FourthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[600],
        title: Text("Stuff's Bus Schedule"),
      ),
      body: new Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        child: new RaisedButton(
          color: Colors.cyanAccent,
          child: Text('Go back to First Screen',
            textAlign: TextAlign.center,
          ),

          onPressed: () {
            //Use`Navigator` widget to pop oir go back to previous route / screen
            Navigator.pop(context);
          },

        ),

      ),
    );
  }
}
class FifthScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[600],
        title: Text('Fifth Screen'),
      ),
      body: new Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        child:new RaisedButton(
          color: Colors.cyanAccent,
          child: Text('Go back to Previous Screen',
            textAlign: TextAlign.center,
          ),

          onPressed: () {
            //Use`Navigator` widget to pop oir go back to previous route / screen
            Navigator.pop(context);


          },

        ),
      ),
    );
  }
}

class SixthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[600],
        title: Text('Sixth Screen'),
      ),

      body: new Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        child: new ListView(
          padding: const EdgeInsets.all(2.0),
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(padding: const EdgeInsets.all(10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,
                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("ইবি ==>>বক চত্ত্বর",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),
                      onTap: () {
                        //Use`Navigator` widget to push the second screen to out stack of screens
                        Navigator.of(context)
                            .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                          return new FourteenScreen();
                        }));
                      },
                    ),
                  ),
                ),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(padding: const EdgeInsets.all(10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,
                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("ইবি ==>> কাষ্টম মোড়",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),
                      onTap: () {
                        //Use`Navigator` widget to push the second screen to out stack of screens
                        Navigator.of(context)
                            .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                          return new FiftheenScreen();
                        }));
                      },
                    ),
                  ),
                ),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(padding: const EdgeInsets.all(10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,
                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("ইবি ==>> পেয়ারাতলা",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),
                      onTap: () {
                        //Use`Navigator` widget to push the second screen to out stack of screens
                        Navigator.of(context)
                            .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                          return new SixteenScreen();
                        }));
                      },
                    ),
                  ),
                ),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(padding: const EdgeInsets.all(10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,
                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("ইবি ==>> মজমপুর",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),
                      onTap: () {
                        //Use`Navigator` widget to push the second screen to out stack of screens
                        Navigator.of(context)
                            .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                          return new SeventeenScreen();
                        }));
                      },
                    ),
                  ),
                ),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(padding: const EdgeInsets.all(10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,
                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("ইবি ==>> বজলুড়মোড়",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),
                      onTap: () {
                        //Use`Navigator` widget to push the second screen to out stack of screens
                        Navigator.of(context)
                            .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                          return new EighteenScreen();
                        }));
                      },
                    ),
                  ),
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }
}
class SeventhScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[600],
        title: Text('Seventh Screen'),
      ),
      body: new Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        child: new ListView(
          padding: const EdgeInsets.all(2.0),
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(padding: const EdgeInsets.all(10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,
                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Bok-Cottor to IU",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),
                      onTap: () {
                        //Use`Navigator` widget to push the second screen to out stack of screens
                        Navigator.of(context)
                            .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                          return new NineteenScreen();
                        }));
                      },
                    ),
                  ),
                ),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(padding: const EdgeInsets.all(10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,
                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Custom-Moor to IU",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),
                      onTap: () {
                        //Use`Navigator` widget to push the second screen to out stack of screens
                        Navigator.of(context)
                            .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                          return new TwentyScreen();
                        }));
                      },
                    ),
                  ),
                ),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(padding: const EdgeInsets.all(10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,
                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Peyaratola to IU",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),
                      onTap: () {
                        //Use`Navigator` widget to push the second screen to out stack of screens
                        Navigator.of(context)
                            .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                          return new TwentyOneScreen();
                        }));
                      },
                    ),
                  ),
                ),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(padding: const EdgeInsets.all(10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,
                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Mojompur to IU",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),
                      onTap: () {
                        //Use`Navigator` widget to push the second screen to out stack of screens
                        Navigator.of(context)
                            .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                          return new TwentyOneScreen();
                        }));
                      },
                    ),
                  ),
                ),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(padding: const EdgeInsets.all(10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,
                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Boojlur-Moor to IU",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),
                      onTap: () {
                        //Use`Navigator` widget to push the second screen to out stack of screens
                        Navigator.of(context)
                            .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                          return new TwentyThreeScreen();
                        }));
                      },
                    ),
                  ),
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }
}
class EighthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[600],
        title: Text('Eighth Screen'),
      ),
      body: new Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        child: new RaisedButton(
          color: Colors.cyanAccent,
          child: Text('Go back to Previous Screen',
            textAlign: TextAlign.center,
          ),

          onPressed: () {
            //Use`Navigator` widget to pop oir go back to previous route / screen
            Navigator.pop(context);


          },

        ),
      ),
    );
  }
}
class NinethScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[600],
        title: Text('Nineth Screen'),
      ),
      body: new Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        child: new RaisedButton(
          color: Colors.cyanAccent,
          child: Text('Go back to Previous Screen',
            textAlign: TextAlign.center,
          ),

          onPressed: () {
            //Use`Navigator` widget to pop oir go back to previous route / screen
            Navigator.pop(context);


          },

        ),
      ),
    );
  }
}
class TenthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[600],
        title: Text('Tenth Screen'),
      ),
      body: new Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        child: new ListView(
          padding: const EdgeInsets.all(2.0),
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(padding: const EdgeInsets.all(10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,
                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Corportion",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),
                      onTap: () {
                        //Use`Navigator` widget to push the second screen to out stack of screens
                        Navigator.of(context)
                            .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                          return new FourteenScreen();
                        }));
                      },
                    ),
                  ),
                ),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(padding: const EdgeInsets.all(10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,
                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Trimohoni",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),
                      onTap: () {
                        //Use`Navigator` widget to push the second screen to out stack of screens
                        Navigator.of(context)
                            .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                          return new FiftheenScreen();
                        }));
                      },
                    ),
                  ),
                ),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(padding: const EdgeInsets.all(10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,
                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Mojompur",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),
                      onTap: () {
                        //Use`Navigator` widget to push the second screen to out stack of screens
                        Navigator.of(context)
                            .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                          return new SixteenScreen();
                        }));
                      },
                    ),
                  ),
                ),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(padding: const EdgeInsets.all(10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,
                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Dodhi Vandar",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),
                      onTap: () {
                        //Use`Navigator` widget to push the second screen to out stack of screens
                        Navigator.of(context)
                            .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                          return new SeventeenScreen();
                        }));
                      },
                    ),
                  ),
                ),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(padding: const EdgeInsets.all(10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,
                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Boojlur Moor",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),
                      onTap: () {
                        //Use`Navigator` widget to push the second screen to out stack of screens
                        Navigator.of(context)
                            .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                          return new EighteenScreen();
                        }));
                      },
                    ),
                  ),
                ),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(padding: const EdgeInsets.all(10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,
                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Nishan Moor",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),
                      onTap: () {
                        //Use`Navigator` widget to push the second screen to out stack of screens
                        Navigator.of(context)
                            .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                          return new NineteenScreen();
                        }));
                      },
                    ),
                  ),
                ),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(padding: const EdgeInsets.all(10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,
                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Custom Moor",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),
                      onTap: () {
                        //Use`Navigator` widget to push the second screen to out stack of screens
                        Navigator.of(context)
                            .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                          return new TwentyScreen();
                        }));
                      },
                    ),
                  ),
                ),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(padding: const EdgeInsets.all(10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,
                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("P.T.I Road",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),
                      onTap: () {
                        //Use`Navigator` widget to push the second screen to out stack of screens
                        Navigator.of(context)
                            .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                          return new TwentyOneScreen();
                        }));
                      },
                    ),
                  ),
                ),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(padding: const EdgeInsets.all(10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,
                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Saddam Bazar",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),
                      onTap: () {
                        //Use`Navigator` widget to push the second screen to out stack of screens
                        Navigator.of(context)
                            .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                          return new TwentyTwo();
                        }));
                      },
                    ),
                  ),
                ),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(padding: const EdgeInsets.all(10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,
                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Raine Bot Tola",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),
                      onTap: () {
                        //Use`Navigator` widget to push the second screen to out stack of screens
                        Navigator.of(context)
                            .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                          return new TwentyThreeScreen();
                        }));
                      },
                    ),
                  ),
                ),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(padding: const EdgeInsets.all(10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,
                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Molla Teguria",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),
                      onTap: () {
                        //Use`Navigator` widget to push the second screen to out stack of screens
                        Navigator.of(context)
                            .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                          return new TwentyFourScreen();
                        }));
                      },
                    ),
                  ),
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }
}
class EleventhScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[600],
        title: Text('Eleven Screen'),
      ),
      body: new Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        child: new RaisedButton(
          color: Colors.cyanAccent,
          child: Text('Go back to Previous Screen',
            textAlign: TextAlign.center,
          ),

          onPressed: () {
            //Use`Navigator` widget to pop oir go back to previous route / screen
            Navigator.pop(context);


          },

        ),
      ),
    );
  }
}
class TwelvethScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[600],
        title: Text('Twelveth Screen'),
      ),
      body: new Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        child: new RaisedButton(
          color: Colors.cyanAccent,
          child: Text('Go back to Previous Screen',
            textAlign: TextAlign.center,
          ),

          onPressed: () {
            //Use`Navigator` widget to pop oir go back to previous route / screen
            Navigator.pop(context);


          },

        ),
      ),
    );
  }
}
class ThirteenthScreeen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[600],
        title: Text('Thirteenth Screen'),
      ),
      body: new Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        child: new RaisedButton(
          color: Colors.cyanAccent,
          child: Text('Go back to Previous Screen',
            textAlign: TextAlign.center,
          ),

          onPressed: () {
            //Use`Navigator` widget to pop oir go back to previous route / screen
            Navigator.pop(context);


          },

        ),
      ),
    );
  }
}
class FourteenScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[600],
        title: Text('Fourteen Screen'),
      ),
      body: new Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        child:new ListView(
          padding: const EdgeInsets.all(2.0),
          children: <Widget>[

            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Up",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Down",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],


            ),



            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Ma(3),Fe(2)",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Ma(3),Fe(2)",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],



            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("8.00 am",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("9.00 am",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],



            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("10.00 am",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("2.00 am",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],



            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("N/R)",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("4.35 pm",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],



            )
          ],
        ),
      ),



    );
  }
}
class FiftheenScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[600],
        title: Text('FIftheen Screen'),
      ),
      body: new Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        child: new ListView(
          padding: const EdgeInsets.all(2.0),
          children: <Widget>[

            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Up",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Down",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],


            ),



            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Ma &Fe (1)",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Ma &Fe (1)",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],



            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("8.00 am",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("9.00 am",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],



            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("10.00 am",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("2.00 am",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],



            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("N/R)",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("4.35 pm",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],



            )
          ],
        ),
      ),
    );
  }
}
class SixteenScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[600],
        title: Text('Sixteen Screen'),
      ),
      body: new Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        child: new ListView(
          padding: const EdgeInsets.all(2.0),
          children: <Widget>[

            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Up",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Down",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],


            ),



            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Ma &Fe (1)",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Ma &Fe (1)",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],



            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("8.00 am",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("9.00 am",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],



            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("10.00 am",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("2.00 am",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],



            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("N/R)",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("4.35 pm",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],



            )
          ],
        ),
      ),
    );
  }
}
class SeventeenScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[600],
        title: Text('Seventeen Screen'),
      ),
      body: new Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        child:new ListView(
          padding: const EdgeInsets.all(2.0),
          children: <Widget>[

            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Up",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Down",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],


            ),



            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Ma &Fe (1)",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Ma &Fe (1)",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],



            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("8.00 am",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("9.00 am",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],



            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("10.00 am",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("2.00 am",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],



            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("N/R)",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("4.35 pm",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],



            )
          ],
        ),
      ),
    );
  }
}
class EighteenScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[600],
        title: Text('Eighteen Screen'),
      ),
      body: new Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        child: new ListView(
          padding: const EdgeInsets.all(2.0),
          children: <Widget>[

            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Up",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Down",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],


            ),



            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Ma(1),Fe(2)",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Ma(1),Fe(2)",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],



            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("8.00 am",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("9.00 am",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],



            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("10.00 am",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("2.00 am",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],



            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("N/R)",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("4.35 pm",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],



            )
          ],
        ),
      ),
    );
  }
}
class NineteenScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[600],
        title: Text('Nineteen Screen'),
      ),
      body: new Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        child: new ListView(
          padding: const EdgeInsets.all(2.0),
          children: <Widget>[

            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Up",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Down",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],


            ),



            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Ma &Fe (1)",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Ma &Fe (1)",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],



            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("8.00 am",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("9.00 am",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],



            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("10.00 am",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("2.00 am",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],



            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("N/R)",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("4.35 pm",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],



            )
          ],
        ),
      ),
    );
  }
}
class TwentyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[600],
        title: Text('Twenty Screen'),
      ),
      body: new Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        child: new ListView(
          padding: const EdgeInsets.all(2.0),
          children: <Widget>[

            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Up",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Down",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],


            ),



            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Ma (1)",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Ma (1)",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],



            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("8.00 am",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("9.00 am",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],



            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("10.00 am",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("2.00 am",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],



            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("N/R)",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("4.35 pm",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],



            )
          ],
        ),
      ),
    );
  }
}
class TwentyOneScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[600],
        title: Text('TwentyOne Screen'),
      ),
      body: new Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        child: new ListView(
          padding: const EdgeInsets.all(2.0),
          children: <Widget>[

            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Up",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Down",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],


            ),



            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Ma (1)",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Ma (1)",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],



            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("8.00 am",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("9.00 am",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],



            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("10.00 am",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("2.00 am",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],



            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("N/R)",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("4.35 pm",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],



            )
          ],
        ),
      ),
    );
  }
}
class TwentyTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[600],
        title: Text('TwentyTwo Screen'),
      ),
      body: new Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        child: new ListView(
          padding: const EdgeInsets.all(2.0),
          children: <Widget>[

            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Up",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Down",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],


            ),



            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Ma(1),Fe(2)",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Ma(1),Fe(2)",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],



            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("8.00 am",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("9.00 am",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],



            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("10.00 am",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("2.00 am",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],



            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("N/R)",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("4.35 pm",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],



            )
          ],
        ),
      ),
    );
  }
}

class TwentyThreeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[600],
        title: Text('TwentyThree Screen'),
      ),
      body: new Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        child: new ListView(
          padding: const EdgeInsets.all(2.0),
          children: <Widget>[

            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Up",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Down",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],


            ),



            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Ma(1)",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Ma(1)",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],



            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("8.00 am",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("9.00 am",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],



            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("10.00 am",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("2.00 am",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],



            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("N/R)",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

                Expanded(
                  child:Padding(padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(color: Colors.blueGrey[600],borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("4.35 pm",style: new TextStyle(fontSize: 30.0,color: Colors.white),),
                      ),

                    ),),),

              ],



            )
          ],
        ),
      ),
    );
  }
}
class TwentyFourScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[600],
        title: Text('TwentyFour Screen'),
      ),
      body: new Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        child: new ListView(
          padding: const EdgeInsets.all(2.0),
          children: <Widget>[

            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(padding: const EdgeInsets.only(
                      left: 20.0, right: 10.0, top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(
                          color: Colors.blueGrey[600],
                          borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Up", style: new TextStyle(
                            fontSize: 30.0, color: Colors.white),),
                      ),

                    ),),),
                Expanded(
                  child: Padding(padding: const EdgeInsets.only(
                      left: 20.0, right: 10.0, top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(
                          color: Colors.blueGrey[600],
                          borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Down", style: new TextStyle(
                            fontSize: 30.0, color: Colors.white),),
                      ),

                    ),),),

              ],


            ),


            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(padding: const EdgeInsets.only(
                      left: 20.0, right: 10.0, top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(
                          color: Colors.blueGrey[600],
                          borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Ma(1)", style: new TextStyle(
                            fontSize: 30.0, color: Colors.white),),
                      ),

                    ),),),

                Expanded(
                  child: Padding(padding: const EdgeInsets.only(
                      left: 20.0, right: 10.0, top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(
                          color: Colors.blueGrey[600],
                          borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("Ma(1)", style: new TextStyle(
                            fontSize: 30.0, color: Colors.white),),
                      ),

                    ),),),

              ],


            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(padding: const EdgeInsets.only(
                      left: 20.0, right: 10.0, top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(
                          color: Colors.blueGrey[600],
                          borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("8.00 am", style: new TextStyle(
                            fontSize: 30.0, color: Colors.white),),
                      ),

                    ),),),

                Expanded(
                  child: Padding(padding: const EdgeInsets.only(
                      left: 20.0, right: 10.0, top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(
                          color: Colors.blueGrey[600],
                          borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("9.00 am", style: new TextStyle(
                            fontSize: 30.0, color: Colors.white),),
                      ),

                    ),),),

              ],


            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(padding: const EdgeInsets.only(
                      left: 20.0, right: 10.0, top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(
                          color: Colors.blueGrey[600],
                          borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("10.00 am", style: new TextStyle(
                            fontSize: 30.0, color: Colors.white),),
                      ),

                    ),),),

                Expanded(
                  child: Padding(padding: const EdgeInsets.only(
                      left: 20.0, right: 10.0, top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(
                          color: Colors.blueGrey[600],
                          borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("2.00 am", style: new TextStyle(
                            fontSize: 30.0, color: Colors.white),),
                      ),

                    ),),),

              ],


            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(padding: const EdgeInsets.only(
                      left: 20.0, right: 10.0, top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(
                          color: Colors.blueGrey[600],
                          borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("N/R)", style: new TextStyle(
                            fontSize: 30.0, color: Colors.white),),
                      ),

                    ),),),

                Expanded(
                  child: Padding(padding: const EdgeInsets.only(
                      left: 20.0, right: 10.0, top: 10.0),
                    child: new GestureDetector(

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,

                        decoration: new BoxDecoration(
                          color: Colors.blueGrey[600],
                          borderRadius: new BorderRadius.circular(10.0),),
                        child: new Text("4.35 pm", style: new TextStyle(
                            fontSize: 30.0, color: Colors.white),),
                      ),

                    ),),),

              ],


            )
          ],
        ),
      ),
    );
  }
}
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Map());
  }
}

//class Map extends StatefulWidget {
//  @override
//  _MapState createState() => _MapState();
//}
//
//class _MapState extends State<Map> {
//
//
//
//  @override
//  Widget build(BuildContext context) {
//    final appState = Provider.of<AppState>(context);
//    return SafeArea(
//      child: appState.initialPosition == null
//        ?
//        Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Row(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                SpinKitRotatingCircle(
//                  color: Colors.black,
//                  size: 50.0,
//                )
//              ],
//            ),
//            SizedBox(height: 10,),
//          Visibility(
//              visible: appState.locationServiceActive == false,
//              child: Text("Please enable location services!", style: TextStyle(color: Colors.grey, fontSize: 18),),
//            )
//          ],
//        )
//
//
//     :Stack(
//    //overflow: Overflow.visible,
//
//     children: <Widget>[
//       Location == null?
//           SpinKitRipple(
//             color: Colors.black,
//             size: 50.0,
//           )
//       : GoogleMap(initialCameraPosition: CameraPosition(target:LatLng(23.9088,-89.1220),zoom: 10.0),
//        onMapCreated: appState.onCreated ,
//        myLocationEnabled: true,
//        mapType: MapType.normal,
//        compassEnabled: true,
//        markers: appState.markers,
//        onCameraMove: appState.onCameraMove,
//          polylines: appState.polylines,
//        ),
//        Positioned(
//          top: 50.0,
//          right: 15.0,
//          left: 15.0,
//          child: Container(
//            height: 50.0,
//            width: double.infinity,
//            decoration: BoxDecoration(
//              borderRadius: BorderRadius.circular(3.0),
//              color: Colors.white,
//              boxShadow: [
//                BoxShadow(
//                    color: Colors.grey,
//                    offset: Offset(1.0, 5.0),
//                    blurRadius: 10,
//                    spreadRadius: 3)
//              ],
//            ),
//            child: TextField(
//              cursorColor: Colors.black,
//              controller: appState.locationController,
//              decoration: InputDecoration(
//                icon: Container(
//                  margin: EdgeInsets.only(left: 20, top: 5),
//                  width: 10,
//                  height: 10,
//                  child: Icon(
//                    Icons.location_on,
//                    color: Colors.black,
//                  ),
//                ),
//                hintText: "pick up",
//                border: InputBorder.none,
//                contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
//              ),
//            ),
//          ),
//        ),
//
//        Positioned(
//          top: 105.0,
//          right: 15.0,
//          left: 15.0,
//          child: Container(
//            height: 50.0,
//            width: double.infinity,
//            decoration: BoxDecoration(
//              borderRadius: BorderRadius.circular(3.0),
//              color: Colors.white,
//              boxShadow: [
//                BoxShadow(
//                    color: Colors.grey,
//                    offset: Offset(1.0, 5.0),
//                    blurRadius: 10,
//                    spreadRadius: 3)
//              ],
//            ),
//            child: TextField(
//              onTap: () async{
//                Prediction p = await PlacesAutocomplete.show(context: context, apiKey: "AIzaSyA8d6lh6-O_gAJI82fdjhOuCCGb9ENEw84",
//                language: "pt",components: [
//                  Component(Component.country,"mz"),
//                    ]);
//
//              },
//              cursorColor: Colors.black,
//              controller: appState.destinationController,
//              textInputAction: TextInputAction.go,
//              onSubmitted: (value) {
//
//                appState.sendRequest(value);
//              },
//              decoration: InputDecoration(
//                icon: Container(
//                  margin: EdgeInsets.only(left: 20, top: 5),
//                  width: 10,
//                  height: 10,
//                  child: Icon(
//                    Icons.local_taxi,
//                    color: Colors.black,
//                  ),
//                ),
//                hintText: "destination?",
//                border: InputBorder.none,
//                contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
//              ),
//            ),
//          ),
//        ),
//      ],
//      ),
//    );
//  }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//void _addMarker(LatLng destination, String intendedLocation) {
//}

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {



  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return    appState.initialPosition == null?
    Container(
      alignment: Alignment.center,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 20,),
            Text("Please enable location services!", style: TextStyle(color: Colors.grey, fontSize: 18),),
          ],
        ),
      ),
    ) :
    Stack(
      children: <Widget>[
        GoogleMap(
          initialCameraPosition: CameraPosition(target: appState.initialPosition,   zoom: 16.0,),
          onMapCreated: appState.onCreated,
          myLocationEnabled: true,
          mapType: MapType.normal,
          compassEnabled: true,
          markers: appState.markers,
          onCameraMove: appState.onCameraMove,
          polylines: appState.polylines,

        ),
        Visibility(
          visible: appState.autoCompleteContainer==true,
          child: Container(
            margin: EdgeInsets.fromLTRB(15, 180, 15, 0),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    offset: Offset(1.0, 5.0),
                    blurRadius: 10,
                    spreadRadius: 3)
              ],
            ),
            child: FutureBuilder(
              future: appState.getCountries(),
              initialData: [],
              builder: (context,snapshot){
                return  createCountriesListView(context, snapshot);
              },
            ),
          ),
        ),
        Positioned(
          top: 50.0,
          right: 15.0,
          left: 15.0,
          child: Container(
            height: 50.0,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    offset: Offset(1.0, 5.0),
                    blurRadius: 10,
                    spreadRadius: 3)
              ],
            ),
            child: TextField(
              cursorColor: Colors.black,
              controller: appState.locationController,
              decoration: InputDecoration(
                icon: Container(
                  margin: EdgeInsets.only(left: 20, top: 5),
                  width: 10,
                  height: 10,
                  child: Icon(
                    Icons.location_on,
                    color: Colors.black,
                  ),
                ),
                hintText: "pick up",
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
              ),
            ),
          ),
        ),

        Positioned(
          top: 105.0,
          right: 15.0,
          left: 15.0,
          child: Container(
            height: 50.0,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    offset: Offset(1.0, 5.0),
                    blurRadius: 10,
                    spreadRadius: 3)
              ],
            ),
            child: TextField(

              cursorColor: Colors.black,
              controller:  appState.destinationController,
              textInputAction: TextInputAction.go,
              onSubmitted: (value) {
                // appState.autoCompleteContainer = false;
                // appState.autoCompleteContainer = false;
                appState.visibilityAutoComplete(false);
                appState.sendRequest(value);
                // appState.autoCompleteContainer = false;
              },
              onChanged: (value){
                appState.increment();
                // appState.autoCompleteContainer = true;
                if(appState.destinationController.text!=null){
                  appState.autoCompleteContainer = true;
                }else{
                  appState.autoCompleteContainer = false;
                }
              },
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: (){
                    // appState.destinationControler.text="";
                    appState.clearDestination();
                    // GoogleMap

                  },
                ),
                icon: Container(
                  margin: EdgeInsets.only(left: 20, top: 5),
                  width: 10,
                  height: 10,
                  child: Icon(
                    Icons.local_taxi,
                    color: Colors.black,
                  ),
                ),
                hintText: "destination?",
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
              ),
            ),
          ),
        ),
        // Positioned(
        //   top: 40, right: 10,
        //   // child: FloatingActionButton(onPressed: _onAddMarkerPressed, tooltip: "Add Map",),
        //   child: FloatingActionButton(
        //     onPressed: _onAddMarkerPressed,
        //     backgroundColor: Black,
        //     child: Icon(Icons.add_location,color:White),
        //     ),
        // ),
      ],
    );

  }


Widget createCountriesListView(BuildContext context, AsyncSnapshot snapshot) {
  var values = snapshot.data;
  return ListView.builder(
    shrinkWrap: true,
    itemCount: values == null ? 0 : values.length,
    itemBuilder: (BuildContext context, int index) {
      final appState = Provider.of<AppState>(context);

      return GestureDetector(
        onTap: () {
          // setState(() {
          // selectedCountry = values[index].code;
          appState.selectedPlace = values[index].description;
          appState.sendRequest(values[index].description);
          appState.visibilityAutoComplete(false);
          // });

          appState.destinationController.text=appState.selectedPlace.toString();
          appState.sendRequest(appState.toString());
          //  appState.sendRequest(value);
          // print(values[index].code);
          print(appState.selectedPlace);
        },
        child: Column(
          children: <Widget>[
            new ListTile(
              title: Text(values[index].description),
            ),
            Divider(
              height: 2.0,
            ),
          ],
        ),
      );
    },
  );
}

}






class  TwentySixScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[600],
        title: Text('TwentySeven Screen'),
      ),
      body: new Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        child: new RaisedButton(
          color: Colors.cyanAccent,
          child: Text('Go back to Previous Screen',
            textAlign: TextAlign.center,
          ),

          onPressed: () {
            //Use`Navigator` widget to pop oir go back to previous route / screen
            Navigator.pop(context);


          },

        ),
      ),
    );
  }
}

class TwentySevenScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[600],
        title: Text('TwentySeven Screen'),
      ),
      body: new Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        child: new RaisedButton(
          color: Colors.cyanAccent,
          child: Text('Go back to Previous Screen',
            textAlign: TextAlign.center,
          ),

          onPressed: () {
            //Use`Navigator` widget to pop oir go back to previous route / screen
            Navigator.pop(context);


          },

        ),
      ),
    );
  }
}
class TwentyEightScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[600],
        title: Text('TwentyEight Screen'),
      ),
      body: new Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        child: new RaisedButton(
          color: Colors.cyanAccent,
          child: Text('Go back to Previous Screen',
            textAlign: TextAlign.center,
          ),

          onPressed: () {
            //Use`Navigator` widget to pop oir go back to previous route / screen
            Navigator.pop(context);


          },

        ),
      ),
    );
  }
}
class TwentyNineScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[600],
        title: Text('TwentyNine Screen'),
      ),
      body: new Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        child: new RaisedButton(
          color: Colors.cyanAccent,
          child: Text('Go back to Previous Screen',
            textAlign: TextAlign.center,
          ),

          onPressed: () {
            //Use`Navigator` widget to pop oir go back to previous route / screen
            Navigator.pop(context);


          },

        ),
      ),
    );
  }
}
class TrirtyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[600],
        title: Text('Thirty Screen'),
      ),
      body: new Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        child: new RaisedButton(
          color: Colors.cyanAccent,
          child: Text('Go back to Previous Screen',
            textAlign: TextAlign.center,
          ),

          onPressed: () {
            //Use`Navigator` widget to pop oir go back to previous route / screen
            Navigator.pop(context);


          },

        ),
      ),
    );
  }
}
class ThirtyOneScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[600],
        title: Text('ThirtyOne Screen'),
      ),
      body: new Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        child: new RaisedButton(
          color: Colors.cyanAccent,
          child: Text('Go back to Previous Screen',
            textAlign: TextAlign.center,
          ),

          onPressed: () {
            //Use`Navigator` widget to pop oir go back to previous route / screen
            Navigator.pop(context);


          },

        ),
      ),
    );
  }
}
class ThirtyTwoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[600],
        title: Text('TwentyTwo Screen'),
      ),
      body: new Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        child: new RaisedButton(
          color: Colors.cyanAccent,
          child: Text('Go back to Previous Screen',
            textAlign: TextAlign.center,
          ),

          onPressed: () {
            //Use`Navigator` widget to pop oir go back to previous route / screen
            Navigator.pop(context);


          },

        ),
      ),
    );
  }
}
class ThirtyThreeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[600],
        title: Text('ThirtyThree Screen'),
      ),
      body: new Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        child: new RaisedButton(
          color: Colors.cyanAccent,
          child: Text('Go back to Previous Screen',
            textAlign: TextAlign.center,
          ),

          onPressed: () {
            //Use`Navigator` widget to pop oir go back to previous route / screen
            Navigator.pop(context);


          },

        ),
      ),
    );
  }
}
class ThirtyFourScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[600],
        title: Text('ThirtyFour Screen'),
      ),
      body: new Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        child: new RaisedButton(
          color: Colors.cyanAccent,
          child: Text('Go back to Previous Screen',
            textAlign: TextAlign.center,
          ),

          onPressed: () {
            //Use`Navigator` widget to pop oir go back to previous route / screen
            Navigator.pop(context);


          },

        ),
      ),
    );
  }
}
class ThirtyFiveScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[600],
        title: Text('ThirtyFive Screen'),
      ),
      body: new Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        child: new RaisedButton(
          color: Colors.cyanAccent,
          child: Text('Go back to Previous Screen',
            textAlign: TextAlign.center,
          ),

          onPressed: () {
            //Use`Navigator` widget to pop oir go back to previous route / screen
            Navigator.pop(context);


          },

        ),
      ),
    );
  }
}


















