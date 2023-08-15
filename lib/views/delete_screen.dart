import 'package:flutter/material.dart';
import 'package:flutter_sql_lite_crud/model/movie.dart';
import 'package:flutter_sql_lite_crud/sql_lite/database_service.dart';

class DeleteScreen extends StatefulWidget {
  const DeleteScreen({super.key});

  @override
  _DeleteScreenState createState() => _DeleteScreenState();
}

class _DeleteScreenState extends State<DeleteScreen> {
  final DatabaseService _databaseService = DatabaseService();
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

  Future<void> _deleteMovie(int id) async {
    await _databaseService.deleteMovie(id);
    _loadMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Movie'),
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
            trailing: IconButton(
              icon: const Icon(
                Icons.delete,
                size: 25,
                color: Colors.white,
              ),
              onPressed: () => _deleteMovie(movie.id),
            ),
          );
        },
      ),
    );
  }
}
