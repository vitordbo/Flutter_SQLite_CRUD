import 'package:flutter/material.dart';
import 'package:flutter_sql_lite_crud/model/movie.dart';
import 'package:flutter_sql_lite_crud/sql_lite/database_service.dart';
import 'package:flutter_sql_lite_crud/views/update_screen.dart';

class ReadScreen extends StatefulWidget {
  const ReadScreen({super.key});

  @override
  _ReadScreenState createState() => _ReadScreenState();
}

class _ReadScreenState extends State<ReadScreen> {
  DatabaseService _databaseService = DatabaseService();
  List<Movie> movies = [];

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    List<Movie> fetchedMovies = await _databaseService.getMovies();
    setState(() {
      movies = fetchedMovies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Read Movies'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          Movie movie = movies[index];
          return ListTile(
            title: Text(
              movie.title,
              style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              '${movie.director} - ${movie.releaseYear}',
              style: const TextStyle(fontSize: 15),
            ),
            trailing: Text(
              '${movie.rating.toStringAsFixed(1)}',
              style: const TextStyle(fontSize: 25),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UpdateScreen(movie: movie)),
              ).then((_) {
                _loadMovies(); // Refresh the list after returning from UpdateScreen
              });
            },
          );
        },
      ),
    );
  }
}
