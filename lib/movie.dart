import 'package:http/http.dart'as http;
import 'dart:async';
import 'dart:convert';
void main(){
  //Fetchmovie();
}
class ListOfMovies{
  int page ;
  int total_results;
  int total_pages;
  List results;
  ListOfMovies(
  {this.page , this.total_pages , this.total_results, this.results}
      );
  factory ListOfMovies.fromjson(Map<String, dynamic> json){
    return ListOfMovies(
      page:json['page'],
      total_results:json['total_results'],
      total_pages: json['total_pages'],
      results: json['results'].cast<Map<String,dynamic>>().map<movie>((json)=>movie.fromjson(json)).toList(),
    );
  }
}

class movie {
  int vote_count;
  int id ;
  bool video ;
  num vote_Avg;
  String title ;
  double popularity;
  String poster_path;
  String Original_language;
  String Original_title;
  List genre_ids;
  String back_drop;
  bool Adult;
  String over_view;
  String release_date;

  movie({
    this.vote_count,this.id , this.video, this.vote_Avg, this.title, this.popularity,
    this.poster_path, this.Original_language, this.Original_title, this.genre_ids, this.back_drop,
    this.Adult,this.over_view,  this.release_date
});
  factory movie.fromjson(Map<String, dynamic> json){
    return movie(
      vote_count:json['vote_count'],
      id:json['id'],
      video: json['video'],
      vote_Avg: json['vote_average'],
      title: json['title'],
      popularity: json['popularity'],
      poster_path: json['poster_path'],
      Original_language: json['original_language'],
      Original_title: json['original_title'],
      genre_ids: json['genre_ids'],
      back_drop: json['backdrop_path'],
      Adult: json['adult'],
      over_view: json['overview'],
      release_date: json['release_date'],

    );
  }

}
Future<ListOfMovies> Fetchmovie(String URL)async{
 // String QueruUrl = 'https://api.themoviedb.org/3/discover/movie?api_key=107ed75bf9e25ec06bfe9fd33d042579&fbclid=IwAR2bmTQ6uKI8yRNQAPH0fuTdDe9fptOcH76BGulfsDQKn76dAMc46tkMfRM';
  final response = await http.get(URL);
  if (response.statusCode==200){
    print('Success');
    return ListOfMovies.fromjson(json.decode(response.body));
  }
  else{
    throw Exception ('failed to load post');
  }
}
