import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:developer' as developer;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Result>> lstPhim;
  int _selectedIndex = 0;

  Future<List<Result>> _listPhimPhoBien() async {
    Dio dio = Dio();
    dio.options.headers["Authorization"] = token;

    try {
      Response response = await dio.get(
          'https://api.themoviedb.org/3/movie/popular?language=en-US&page=1');
      if (response.statusCode == 200) {
        // var data = jsonDecode(response.data);
        var data = response.data;
        var movies = data['results'];

        List<Result> movieList =
            movies.map<Result>((json) => Result.fromJson(json)).toList();
        return movieList;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<Result>> _listPhimHay() async {
    Dio dio = Dio();
    dio.options.headers["Authorization"] = token;

    try {
      Response response = await dio.get(
          'https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1');
      if (response.statusCode == 200) {
        developer.log(response.data.toString());
        var data = response.data;
        var movies = data['results'];

        List<Result> movieList =
            movies.map<Result>((json) => Result.fromJson(json)).toList();
        return movieList;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  void initState() {
    lstPhim = _listPhimPhoBien();
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      MyListPhim(
        lstPhim: _listPhimPhoBien(),
      ),
      MyListPhim(
        lstPhim: _listPhimHay(),
      )
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Phim'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Phổ biến',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flag),
            label: 'Hay',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

const token =
    'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2MmQ2ZDg5ZDYwZWJmMmZjZDY5MjQ3NjI5M2Y2YTI5MyIsInN1YiI6IjY2MWRlYzAxMjBhZjc3MDE3ZDNkNjQ0OCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ._whHU6TQvXpXyk4pe5yhA96U6wW1nsD9oApPmY36_BM';

// ignore: must_be_immutable
class MyListPhim extends StatefulWidget {
  Future<List<Result>> lstPhim;
  MyListPhim({super.key, required this.lstPhim});
  //const MyListPhim({super.key});

  @override
  State<MyListPhim> createState() => _MyListPhimState();
}

class _MyListPhimState extends State<MyListPhim> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.lstPhim,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Lỗi: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final results = snapshot.data!;
          return ListView.separated(
              itemBuilder: (context, index) {
                final movie = results[index];
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://image.tmdb.org/t/p/w500${movie.backdroppath ?? ""}'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.brown, width: 0.5)),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            movie.title ?? "",
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            movie.overview ?? "",
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(height: 2, fontSize: 15),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: results.length);
        } else {
          return Text("Không có dữ liệu");
        }
      },
    );
  }
}

class Result {
  // bool? adult;
  String? backdroppath;

  // int? id;
  // String? originallanguage;
  // String? originaltitle;
  String? overview;
  // double? popularity;
  // String? posterpath;
  // String? releasedate;
  String? title;
  // bool? video;
  // double? voteaverage;
  // int? votecount;

  Result({
    // this.adult,
    this.backdroppath,
    // this.id,
    // this.originallanguage,
    // this.originaltitle,
    this.overview,
    // this.popularity,
    // this.posterpath,
    // this.releasedate,
    this.title,
    // this.video,
    // this.voteaverage,
    // this.votecount
  });

  Result.fromJson(Map<String, dynamic> json) {
    // adult = json['adult'];
    backdroppath = json['backdrop_path'];

    // id = json['id'];
    // originallanguage = json['original_language'];
    // originaltitle = json['original_title'];
    overview = json['overview'];
    // popularity = json['popularity'];
    // posterpath = json['poster_path'];
    // releasedate = json['release_date'];
    title = json['title'];
    // video = json['video'];
    // voteaverage = json['vote_average'];
    // votecount = json['vote_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    // data['adult'] = adult;
    data['backdrop_path'] = backdroppath;

    // data['id'] = id;
    // data['original_language'] = originallanguage;
    // data['original_title'] = originaltitle;
    data['overview'] = overview;
    // data['popularity'] = popularity;
    // data['poster_path'] = posterpath;
    // data['release_date'] = releasedate;
    data['title'] = title;
    // data['video'] = video;
    // data['vote_average'] = voteaverage;
    // data['vote_count'] = votecount;
    return data;
  }
}

class Root {
  // int? page;
  List<Result?>? results;
  // int? totalpages;
  // int? totalresults;

  Root({
    // this.page,
    this.results,
    // this.totalpages, this.totalresults
  });

  Root.fromJson(Map<String, dynamic> json) {
    // page = json['page'];
    if (json['results'] != null) {
      results = <Result>[];
      json['results'].forEach((v) {
        results!.add(Result.fromJson(v));
      });
    }
    // totalpages = json['total_pages'];
    // totalresults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    // data['page'] = page;
    data['results'] =
        results != null ? results!.map((v) => v?.toJson()).toList() : null;
    // data['total_pages'] = totalpages;
    // data['total_results'] = totalresults;
    return data;
  }
}
