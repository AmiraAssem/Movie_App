import 'package:flutter/material.dart';
import 'package:movieapp/movie.dart'as movie;
import 'dart:ui' as ui;
import 'package:carousel_slider/carousel_slider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  String MostPopular = '&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1';
  double height =  0;
  movie.ListOfMovies list;
  int _selectedIndex = 0;
  static const double IconSize = 200;
  static List<Widget> _widgetOptions = <Widget>[
    MyHomePage (),
    _MostPopular(),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
        appBar: AppBar(
          title: TextField(decoration: new InputDecoration(
              contentPadding:
              const EdgeInsets.only(left: 30.0, bottom: 10.0, top: 10.0 , right: 30.0),
              prefixIcon: Icon(Icons.search , color: Colors.grey,),
              border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(100.0),
                ),
              ),
              filled: true,
              hintStyle: new TextStyle(color: Colors.grey),
              hintText: "  Search...",
              fillColor: Color(0xffb263859)),

          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.notifications, color: Colors.grey,), onPressed: null)
          ],
          
          backgroundColor: Color(0xffb17223b),
          bottom: TabBar(
           isScrollable: true,
           indicatorColor: Color(0xffb93b5b3),
           indicatorWeight: 6.0,

            tabs: <Widget>[
              Tab(
                child: Container(
                  child: Text('In Theaters' , style: TextStyle(color: Colors.grey, fontSize: 12.0),),
                ),

              ),
              Tab(
                child: Container(
                child: Text('Popular' , style: TextStyle(color: Colors.grey, fontSize: 12.0),),
    ),
    ),
              Tab(
               child: Container(

                child: Text('Recent' , style: TextStyle(color: Colors.grey , fontSize: 12.0),),
    ),
    ),
              Tab(
               child: Container(
                child: Text('Genres' , style: TextStyle(color: Colors.grey , fontSize: 12.0),),
    ),
    ),
              Tab(
                child: Container(
                  child: Text('Collections' , style: TextStyle(color: Colors.grey , fontSize: 12.0),),
                ),
              ),
            ],

          ),
        ),
        drawer: new Drawer(
        child: new Container(
          height: MediaQuery.of(context).size.height*0.25 ,
          padding: EdgeInsets.all(20.0),
          color: Color(0xffb17223b),
          child: new Column(
          children: <Widget>[
           Icon (Icons.supervised_user_circle , color:Colors.grey , size:  MediaQuery.of(context).size.height*0.25 , ),
           ButtonTheme(
             height:MediaQuery.of(context).size.height*0.10 ,
             child :  new FlatButton(onPressed: null, child: new Row(
             children: <Widget>[
              Icon(Icons.home , color:Colors.grey), Text ("Home", style: TextStyle(color:Colors.grey , fontSize: 15.0,))],),
               ),
           ),
            ButtonTheme(
             height:MediaQuery.of(context).size.height*0.10 ,
             child :  new FlatButton(onPressed: null, child: new Row(
             children: <Widget>[
              Icon(Icons.timer , color:Colors.grey), Text ("Recent", style: TextStyle(color:Colors.grey , fontSize: 15.0,))],),
               ),
           ),
            ButtonTheme(
             height:MediaQuery.of(context).size.height*0.10 ,
             child :  new FlatButton(onPressed: null, child: new Row(
             children: <Widget>[
              Icon(Icons.account_circle , color:Colors.grey), Text ("My Account", style: TextStyle(color:Colors.grey , fontSize: 15.0,))],),
               ),
           ),
            ButtonTheme(
             height:MediaQuery.of(context).size.height*0.10 ,
             child :  new FlatButton(onPressed: null, child: new Row(
             children: <Widget>[
              Icon(Icons.favorite , color:Colors.grey), Text ("Favorite", style: TextStyle(color:Colors.grey , fontSize: 15.0,))],),
               ),
           ),
            ButtonTheme(
             height:MediaQuery.of(context).size.height*0.10 ,
             child :  new FlatButton(onPressed: null, child: new Row(
             children: <Widget>[
              Icon(Icons.settings, color:Colors.grey), Text ("Settings", style: TextStyle(color:Colors.grey , fontSize: 15.0,))],),
               ),
           ),
   
            
          ],

          ),
        ),
      ),
        body: new TabBarView(
          children: <Widget>[
            Container(
              height: 800,
              color: Color(0xffb17223b),
              child: ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.02,
                  ),
                  _Top10(),
                  //    ImageContainer(snapshot.data.results),
                  SizedBox(
                      height: MediaQuery.of(context).size.height*0.08,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 25.0),
                            child: Text('Most Popular' , style: TextStyle(fontSize: 18.0 , color: Colors.grey)),
                          ),
                          Padding(
                              padding: EdgeInsets.only(right: 10.0),
                              child:  IconButton(icon: Icon(Icons.clear_all , color: Colors.grey), onPressed:(){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => view_mostPopular())
                                );
                              })
                          ),
                        ],
                      )
                  ),
                  _MostPopular(),
                 
                ],
              ),
            ),
            new  _Recent(),
            new mostPopularWidget(),
            new Geners(),
            new Collections(),
          ],
        ),
        )
    );
  }
}


Widget MostPopularContainer(List <movie.movie> list){
  String URL = 'http://image.tmdb.org/t/p/w185/';
  String URL1 = 'http://image.tmdb.org/t/p/w300/';
  return  ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Container(
               padding: EdgeInsets.all(10.0),
               height: MediaQuery.of(context).size.height*0.99,
                width: MediaQuery.of(context).size.width*0.50,
                margin: const EdgeInsets.symmetric(horizontal: 1.0),
                color: Color(0xffb17223b),
                    child: Column(
                     // mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, new MaterialPageRoute(builder: (context){
                              return new MovieDetail(list[index]);
                            }));
                          },
                          child: Image.network(URL + list[index].poster_path ),
                        ),
                        //  Image(image: AssetImage(list[index].poster_path),),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(list[index].title, style: TextStyle(
                              fontSize: 14.0, color: Colors.grey),),

                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(
                                left: 10.0, right: 5.0),
                                child: Icon(
                                  Icons.star, color: Colors.cyanAccent,size: 15.0,)),
                            Text(list[index].vote_Avg.toString()+'/10',
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.grey)),

                          ],

                        )


                      ]
                      ,
                    )
                
            );
          }
      

  );
} //Done
Widget ImageContainer(List <movie.movie >moviee){
  String image_url = 'http://image.tmdb.org/t/p/w300/';
  String url ='https://api.themoviedb.org/3/trending/movie/week?api_key=107ed75bf9e25ec06bfe9fd33d042579&fbclid=IwAR2bmTQ6uKI8yRNQAPH0fuTdDe9fptOcH76BGulfsDQKn76dAMc46tkMfRM';
  return CarouselSlider(
      height: 350,
      aspectRatio: 16/9,
      viewportFraction: 0.8,
      initialPage: 0,
      enableInfiniteScroll: true,
      reverse: false,
      autoPlay: true,
      autoPlayInterval: Duration(seconds: 3),
      autoPlayAnimationDuration: Duration(milliseconds: 800),
      // autoPlayCurve: Curve.fastOutSlowIn,
      pauseAutoPlayOnTouch: Duration(seconds: 10),
      enlargeCenterPage: true,
      //onPageChanged: callbackFunction,
      scrollDirection: Axis.horizontal,
      items: moviee.map((moviee) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                    color: Color(0xffb17223b),
                  borderRadius: new BorderRadius.circular(
                      10.0),
                //  color: Colors.grey,
                  image: new DecorationImage(
                      image: new NetworkImage(
                          image_url + moviee.poster_path),
                      fit: BoxFit.fill),
                  boxShadow: [
                    new BoxShadow(
                        color: Colors.blue,
                        blurRadius: 5.0,
                        offset: new Offset(2.0, 5.0))
                  ],
                ),
              //  child: Text(moviee.title, style: TextStyle(fontSize: 16.0 , ),)
            );
          },
        );
      }).toList(),

    
  );
}
class view_mostPopular extends StatelessWidget {
  List<movie.movie> list;
  String url = 'https://api.themoviedb.org/3/discover/movie?api_key=107ed75bf9e25ec06bfe9fd33d042579&fbclid=IwAR2bmTQ6uKI8yRNQAPH0fuTdDe9fptOcH76BGulfsDQKn76dAMc46tkMfRM&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1';
  String image_url = 'http://image.tmdb.org/t/p/w300/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.grey,),
                  onPressed: (){
                    Navigator.pop(context);
                    // MaterialPageRoute(builder: (context) => MyApp());
                  }),
              title: Center (child :Text ("most Popular" , style: TextStyle(color: Colors.grey),)),
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.notifications, color: Colors.grey,), onPressed: null)
              ],
              backgroundColor: Color(0xffb17223b),
            ),
            body:FutureBuilder<movie.ListOfMovies>(
            future: movie.Fetchmovie(url),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                list =snapshot.data.results;
                return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: new Column(
                          children: <Widget>[
                            new Row(
                              children: <Widget>[
                                new Padding(
                                  padding: const EdgeInsets.only(left: 30.0),
                                  child: new Container(
                                    margin: const EdgeInsets.all(16.0),
                                    child: new Container(
                                      width: 120.0,
                                      height: 160.0,
                                    ),
                                    decoration: new BoxDecoration(
                                      borderRadius: new BorderRadius.circular(
                                          10.0),
                                      color: Colors.grey,
                                      image: new DecorationImage(
                                          image: new NetworkImage(
                                              image_url +
                                                  list[index].poster_path),
                                          fit: BoxFit.cover),
                                      boxShadow: [
                                        new BoxShadow(
                                            color: Colors.blue,
                                            blurRadius: 5.0,
                                            offset: new Offset(2.0, 5.0))
                                      ],
                                    ),
                                  ),
                                ),
                                new Expanded(
                                    child: new Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          16.0, 0.0, 16.0, 0.0),
                                      child: new Column(children: [
                                        new Text(
                                          list[index].title,
                                          style: new TextStyle(
                                              fontSize: 20.0,
                                              fontFamily: 'Arvo',
                                              fontWeight: FontWeight.bold,
                                              color: Colors.indigo),
                                        ),
                                        new Padding(
                                            padding: const EdgeInsets.all(
                                                10.0)),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: <Widget>[
                                            new Text('release date : ' +
                                                list[index].release_date,
                                              maxLines: 3,
                                              style: new TextStyle(
                                                  color: const Color(
                                                      0xff8785A4),
                                                  fontFamily: 'Arvo'
                                              ),),
                                            Padding(padding: EdgeInsets.only(
                                                right: 30.0),
                                                child: Icon(Icons.info_outline,
                                                  color: Colors.grey,
                                                  size: 30.0,)
                                            )
                                          ],
                                        ),
                                        new Padding(
                                            padding: const EdgeInsets.all(
                                                10.0)),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: <Widget>[
                                            Padding(padding: EdgeInsets.only(
                                                left: 10.0, right: 5.0),
                                                child: Icon(
                                                  Icons.star,
                                                  color: Colors.cyanAccent,
                                                  size: 15.0,)),
                                            Text(
                                              list[index].vote_Avg.toString() +
                                                  '/10',
                                              style: new TextStyle(
                                                  color: const Color(
                                                      0xff8785A4),
                                                  fontFamily: 'Arvo'
                                              ),)
                                            ,

                                          ],

                                        ),

                                      ],
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,),
                                    )
                                ),
                              ],
                            ),
                            new Container(
                              width: 300.0,
                              height: 0.5,
                              color: const Color(0xD2D2E1ff),
                              margin: const EdgeInsets.all(16.0),
                            )
                          ],
                        ),
                        onTap: () {
                          Navigator.push(context,
                              new MaterialPageRoute(builder: (context) {
                                return new MovieDetail(list[index]);
                              }));
                        },
                      );
                    }
                );

            }
              else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return Text('loading');
            }
            ),
            backgroundColor: Color(0xffb17223b),
        );
  }
}

class MovieDetail extends StatelessWidget{
  movie.movie moviee;
  String image_url = 'http://image.tmdb.org/t/p/w300/';
  Color mainColor = const Color(0xff3C3261);
  MovieDetail(this.moviee);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Stack(
            fit: StackFit.expand,
            children: [
              new Image.network(image_url+moviee.back_drop,fit: BoxFit.cover),
              new BackdropFilter(
                filter: new ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: new Container(
                  color: Colors.black.withOpacity(0.5),
                ),),
              new SingleChildScrollView(
                child: new Container(
                  margin: const EdgeInsets.all(20.0),
                  child: new Column(
                      children: <Widget>[
                        new Container(
                          alignment: Alignment.center,
                          child: new Container(width: 400.0,height: 400.0,),
                          decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(10.0),
                              image: new DecorationImage(image: new NetworkImage(image_url + moviee.poster_path),fit: BoxFit.fill),
                              boxShadow: [
                                new BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 20.0,
                                    offset: new Offset(0.0, 10.0)
                                )
                              ]
                          ),
                        ),
                        new Container(
                          margin: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 0.0),
                          child: new Row(

                            children: <Widget>[
                              new Expanded(child: new Text(moviee.title,style: new TextStyle(color: Colors.white,fontSize: 30.0,fontFamily: 'Arvo'),)),
                              new Text('${moviee.vote_Avg}/10',style: new TextStyle(color: Colors.white,fontSize: 20.0,fontFamily: 'Arvo'),)
                            ],
                          ),

                        ),
                  new Text(moviee.over_view,style: new TextStyle(color: Colors.white, fontFamily: 'Arvo' , fontSize: 18.0)),
                     Padding(padding: EdgeInsets.all(25),
                       child : new Text('release date : '+moviee.release_date,style: new TextStyle(color: Colors.white, fontFamily: 'Arvo' , fontSize: 18.0)),),
                  new Padding(padding: const EdgeInsets.all(10.0)),
                  new Row(
                      children: <Widget>[
                        new Padding(padding: const EdgeInsets.only(top:70),
                            child: new Container(
                              width: 150.0,
                              height: 60.0,
                              alignment: Alignment.center,
                              child: new FlatButton(
                               child: Text('Back' , style: TextStyle(color: Colors.white , fontSize: 25),),
                                onPressed: (){
                                 Navigator.pop(context);
                                },
                              ),
                              decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.circular(10.0),
                                  color: Colors.blueGrey,
                                  //color: const Color(0xaa3C3261)),
                            )),
                        )
                      ]

                  ),
                  ]
                ),
              ),
              )
        ]
    )
    );
  }
}
class _Top10 extends StatefulWidget{
   @override
   Top10 createState ()=> new Top10();
}
class Top10 extends State<_Top10> {
  String url = 'https://api.themoviedb.org/3/trending/movie/week?api_key=107ed75bf9e25ec06bfe9fd33d042579&fbclid=IwAR2bmTQ6uKI8yRNQAPH0fuTdDe9fptOcH76BGulfsDQKn76dAMc46tkMfRM';
  String URL = 'http://image.tmdb.org/t/p/w200/';
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<movie.ListOfMovies>(
        future: movie.Fetchmovie(url),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
             return Container(
               height: MediaQuery.of(context).size.height*0.50,
             child : ImageContainer(snapshot.data.results),
             );

          }
          else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Text('loading');
        }
    );
  }
}

class _MostPopular extends StatefulWidget{
 @override
  _mostPopular createState() => _mostPopular();
}
class _mostPopular extends State<_MostPopular> {
  String url = 'https://api.themoviedb.org/3/discover/movie?api_key=107ed75bf9e25ec06bfe9fd33d042579&fbclid=IwAR2bmTQ6uKI8yRNQAPH0fuTdDe9fptOcH76BGulfsDQKn76dAMc46tkMfRM&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1';
  String URL = 'http://image.tmdb.org/t/p/w200/';

  @override
  Widget build(BuildContext context) {
    return
      FutureBuilder<movie.ListOfMovies>(
          future: movie.Fetchmovie(url),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
              
               height: MediaQuery.of(context).size.height*0.50,
               child:MostPopularContainer(snapshot.data.results),
              );
              //MostPopularContainer(snapshot.data.results);
            }
            else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return Center(child: CircularProgressIndicator(),);
          }
      );
  }
}
class ActionMovies extends StatelessWidget{
 String URL = 'https://api.themoviedb.org/3/discover/movie?api_key=107ed75bf9e25ec06bfe9fd33d042579&fbclid=IwAR2bmTQ6uKI8yRNQAPH0fuTdDe9fptOcH76BGulfsDQKn76dAMc46tkMfRM&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&primary_release_date.gte=1990-01-01&primary_release_date.lte=1999-12-31&vote_average.gte=6&with_genres=28';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<movie.ListOfMovies>(
        future: movie.Fetchmovie(URL),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MostPopularContainer(snapshot.data.results);
          }
          else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(child: CircularProgressIndicator(),);
        }
    );

  }

}
class RomanceMovies extends StatelessWidget{
  String URL = 'https://api.themoviedb.org/3/discover/movie?api_key=107ed75bf9e25ec06bfe9fd33d042579&fbclid=IwAR2bmTQ6uKI8yRNQAPH0fuTdDe9fptOcH76BGulfsDQKn76dAMc46tkMfRM&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&primary_release_date.gte=1990-01-01&primary_release_date.lte=1999-12-31&vote_average.gte=6&with_genres=	10749';

  @override
  Widget build(BuildContext context) {
   return  FutureBuilder<movie.ListOfMovies>(
        future: movie.Fetchmovie(URL),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MostPopularContainer(snapshot.data.results);
          }
          else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(child: CircularProgressIndicator(),);
        }
    );

  }

}
class DramaMovies extends StatelessWidget{
  String URL = 'https://api.themoviedb.org/3/discover/movie?api_key=107ed75bf9e25ec06bfe9fd33d042579&fbclid=IwAR2bmTQ6uKI8yRNQAPH0fuTdDe9fptOcH76BGulfsDQKn76dAMc46tkMfRM&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&primary_release_date.gte=1990-01-01&primary_release_date.lte=1999-12-31&vote_average.gte=6&with_genres=18';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<movie.ListOfMovies>(
        future: movie.Fetchmovie(URL),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MostPopularContainer(snapshot.data.results);
          }
          else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(child: CircularProgressIndicator(),);
        }
    );

  }

}
class Comedy extends StatelessWidget{
  String URL = 'https://api.themoviedb.org/3/discover/movie?api_key=107ed75bf9e25ec06bfe9fd33d042579&fbclid=IwAR2bmTQ6uKI8yRNQAPH0fuTdDe9fptOcH76BGulfsDQKn76dAMc46tkMfRM&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&primary_release_date.gte=1990-01-01&primary_release_date.lte=1999-12-31&vote_average.gte=6&with_genres=35';

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<movie.ListOfMovies>(
        future: movie.Fetchmovie(URL),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MostPopularContainer(snapshot.data.results);
          }
          else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(child: CircularProgressIndicator(),);
        }
    );

  }

}
class FamilyMovies extends StatelessWidget{
  String URL = 'https://api.themoviedb.org/3/discover/movie?api_key=107ed75bf9e25ec06bfe9fd33d042579&fbclid=IwAR2bmTQ6uKI8yRNQAPH0fuTdDe9fptOcH76BGulfsDQKn76dAMc46tkMfRM&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&primary_release_date.gte=1990-01-01&primary_release_date.lte=1999-12-31&vote_average.gte=6&with_genres=10751';

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<movie.ListOfMovies>(
        future: movie.Fetchmovie(URL),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MostPopularContainer(snapshot.data.results);
          }
          else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(child: CircularProgressIndicator(),);
        }
    );

  }

}
class AnimatedMovies extends StatelessWidget{
  String URL = 'https://api.themoviedb.org/3/discover/movie?api_key=107ed75bf9e25ec06bfe9fd33d042579&fbclid=IwAR2bmTQ6uKI8yRNQAPH0fuTdDe9fptOcH76BGulfsDQKn76dAMc46tkMfRM&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&primary_release_date.gte=1990-01-01&primary_release_date.lte=1999-12-31&vote_average.gte=6&with_genres=16';

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<movie.ListOfMovies>(
        future: movie.Fetchmovie(URL),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MostPopularContainer(snapshot.data.results);
          }
          else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(child: CircularProgressIndicator(),);
        }
    );

  }

}
class HorrorMovies extends StatelessWidget{
  String URL = 'https://api.themoviedb.org/3/discover/movie?api_key=107ed75bf9e25ec06bfe9fd33d042579&fbclid=IwAR2bmTQ6uKI8yRNQAPH0fuTdDe9fptOcH76BGulfsDQKn76dAMc46tkMfRM&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&primary_release_date.gte=1990-01-01&primary_release_date.lte=1999-12-31&vote_average.gte=6&with_genres=27';

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<movie.ListOfMovies>(
        future: movie.Fetchmovie(URL),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MostPopularContainer(snapshot.data.results);
          }
          else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(child: CircularProgressIndicator(),);
        }
    );

  }

}
class mostPopularWidget extends StatelessWidget {
  String url = 'https://api.themoviedb.org/3/discover/movie?api_key=107ed75bf9e25ec06bfe9fd33d042579&fbclid=IwAR2bmTQ6uKI8yRNQAPH0fuTdDe9fptOcH76BGulfsDQKn76dAMc46tkMfRM&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1';
  String URL = 'http://image.tmdb.org/t/p/w200/';

  @override
  Widget build(BuildContext context) {
    return
      FutureBuilder<movie.ListOfMovies>(
          future: movie.Fetchmovie(url),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(child : Popular(snapshot.data.results),
                  color: Color(0xffb17223b),
              );
            }
            else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return Center(child: CircularProgressIndicator(),);
          }
      );
  }
}
Widget Popular (List <movie.movie> list) {
  String url = 'https://api.themoviedb.org/3/discover/movie?api_key=107ed75bf9e25ec06bfe9fd33d042579&fbclid=IwAR2bmTQ6uKI8yRNQAPH0fuTdDe9fptOcH76BGulfsDQKn76dAMc46tkMfRM&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1';
  String image_url = 'http://image.tmdb.org/t/p/w300/';
  return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: new Column(
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: new Container(
                      margin: const EdgeInsets.all(15.0),
                      child: new Container(
                        width: MediaQuery.of(context).size.width*0.26,
                        height: 160.0,
                      ),
                      decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.circular(
                            10.0),
                        color: Colors.grey,
                        image: new DecorationImage(
                            image: new NetworkImage(
                                image_url +
                                    list[index].poster_path),
                            fit: BoxFit.cover),
                        boxShadow: [
                          new BoxShadow(
                              color: Colors.blue,
                              blurRadius: 5.0,
                              offset: new Offset(2.0, 5.0))
                        ],
                      ),
                    ),
                  ),
                   new Container(
                        width: MediaQuery.of(context).size.width*0.58,
                        margin: const EdgeInsets.fromLTRB(
                            0.5, 0.0, 0.5, 0.0),
                        child: new Column(children: [
                          new Text(
                            list[index].title,
                            style: new TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'Arvo',
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo),
                          ),
                          new Padding(
                              padding: const EdgeInsets.all(
                                  5.0)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween,
                            children: <Widget>[
                              new Text('release date : ' +
                                  list[index].release_date,
                                maxLines: 3,
                                style: new TextStyle(
                                    color: const Color(
                                        0xff8785A4),
                                    fontFamily: 'Arvo'
                                ),),
                              Padding(padding: EdgeInsets.only(
                                  right: 30.0),
                                  child: Icon(Icons.info_outline,
                                    color: Colors.grey,
                                    size: 20.0,)
                              )
                            ],
                          ),
                          new Padding(
                              padding: const EdgeInsets.all(
                                  10.0)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment
                                .start,
                            crossAxisAlignment: CrossAxisAlignment
                                .start,
                            children: <Widget>[
                              Padding(padding: EdgeInsets.only(
                                  left: 10.0, right: 5.0),
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.cyanAccent,
                                    size: 15.0,)),
                              Text(
                                list[index].vote_Avg.toString() +
                                    '/10',
                                style: new TextStyle(
                                    color: const Color(
                                        0xff8785A4),
                                    fontFamily: 'Arvo'
                                ),)
                              ,

                            ],

                          ),

                        ],
                          crossAxisAlignment: CrossAxisAlignment
                              .start,),
                      )
                  
                ],
              ),
              
            ],


        ),
          onTap: () {
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) {
                  return new MovieDetail(list[index]);
                }));
          },
        );
      }
  );

}
class Geners extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffb17223b),
        child :ListView.builder(
       // scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (context, index) {
          return new Column(
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                    height: 40.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 25.0),
                          child: Text('Action Movies' , style: TextStyle(fontSize: 25.0 , color: Colors.grey)),
                        ),
                        Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child:  IconButton(icon: Icon(Icons.clear_all , color: Colors.grey), onPressed:(){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => view_mostPopular())
                              );
                            })
                        ),

                      ],
                    )
                ),
                new Container(
                    height: 370,
                  color: Color(0xffb17223b),
                  child:ActionMovies(),

          ),
                SizedBox(
                    height: 40.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 25.0),
                          child: Text('Drama' , style: TextStyle(fontSize: 25.0 , color: Colors.grey)),
                        ),
                        Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child:  IconButton(icon: Icon(Icons.clear_all , color: Colors.grey), onPressed:(){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => view_mostPopular())
                              );
                            })
                        ),

                      ],
                    )
                ),
                new Container(
                  height: 370,
                  color: Color(0xffb17223b),
                  child:DramaMovies(),

                ),
                SizedBox(
                    height: 40.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 25.0),
                          child: Text('Family' , style: TextStyle(fontSize: 25.0 , color: Colors.grey)),
                        ),
                        Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child:  IconButton(icon: Icon(Icons.clear_all , color: Colors.grey), onPressed:(){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => view_mostPopular())
                              );
                            })
                        ),

                      ],
                    )
                ),
                new Container(
                  height: 370,
                  color: Color(0xffb17223b),
                  child:FamilyMovies(),

                ),
                SizedBox(
                    height: 40.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 25.0),
                          child: Text('Romance ' , style: TextStyle(fontSize: 25.0 , color: Colors.grey)),
                        ),
                        Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child:  IconButton(icon: Icon(Icons.clear_all , color: Colors.grey), onPressed:(){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => view_mostPopular())
                              );
                            })
                        ),

                      ],
                    )
                ),
                new Container(
                  height: 370,
                  color: Color(0xffb17223b),
                  child:RomanceMovies(),

                ),
                SizedBox(
                    height: 40.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 25.0),
                          child: Text('Animated' , style: TextStyle(fontSize: 25.0 , color: Colors.grey)),
                        ),
                        Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child:  IconButton(icon: Icon(Icons.clear_all , color: Colors.grey), onPressed:(){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => view_mostPopular())
                              );
                            })
                        ),

                      ],
                    )
                ),
                new Container(
                  height: 370,
                  color: Color(0xffb17223b),
                  child:AnimatedMovies(),

                ),
                SizedBox(
                    height: 40.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 25.0),
                          child: Text('Horror' , style: TextStyle(fontSize: 25.0 , color: Colors.grey)),
                        ),
                        Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child:  IconButton(icon: Icon(Icons.clear_all , color: Colors.grey), onPressed:(){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => view_mostPopular())
                              );
                            })
                        ),

                      ],
                    )
                ),
                new Container(
                  height: 370,
                  color: Color(0xffb17223b),
                  child:HorrorMovies(),

                ),
                SizedBox(
                    height: 40.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 25.0),
                          child: Text('Comedy' , style: TextStyle(fontSize: 25.0 , color: Colors.grey)),
                        ),
                        Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child:  IconButton(icon: Icon(Icons.clear_all , color: Colors.grey), onPressed:(){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => view_mostPopular())
                              );
                            })
                        ),

                      ],
                    )
                ),
                new Container(
                  height: 370,
                  color: Color(0xffb17223b),
                  child:Comedy(),

                ),
          ]
          );


        }
    ),
    );
  }

}
class Collections extends StatelessWidget {
  String URL = 'https://api.themoviedb.org/3/movie/top_rated?api_key=107ed75bf9e25ec06bfe9fd33d042579&fbclid=IwAR2bmTQ6uKI8yRNQAPH0fuTdDe9fptOcH76BGulfsDQKn76dAMc46tkMfRM';
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffb17223b),
      child :FutureBuilder<movie.ListOfMovies>(
          future: movie.Fetchmovie(URL),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Popular(snapshot.data.results);
            }
            else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return Center(child: CircularProgressIndicator(),);
          }
      )
    );
  }
}

class _Recent extends StatefulWidget{
  @override
  Recent createState ()=> new Recent();
}

class Recent extends State<_Recent> {
  String URL = 'https://api.themoviedb.org/3/trending/movie/week?api_key=107ed75bf9e25ec06bfe9fd33d042579&fbclid=IwAR2bmTQ6uKI8yRNQAPH0fuTdDe9fptOcH76BGulfsDQKn76dAMc46tkMfRM';
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xffb17223b),
        child :FutureBuilder<movie.ListOfMovies>(
            future: movie.Fetchmovie(URL),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                width: MediaQuery.of(context).size.width*90,  
                child : Popular(snapshot.data.results),
                );
              }
              else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return Center(child: CircularProgressIndicator(),);
            }
        )
    );
  }
}