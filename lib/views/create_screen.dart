import 'package:flutter/material.dart';
import 'package:flutter_sql_lite_crud/model/movie.dart';
import 'package:flutter_sql_lite_crud/sql_lite/database_service.dart';

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final DatabaseService _databaseService = DatabaseService();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _directorController = TextEditingController();
  final TextEditingController _releaseYearController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  int _lastId = 0;

  @override
  void initState() {
    super.initState();
    _getLastId();
  }

  Future<void> _getLastId() async {
    List<Movie> movies = await _databaseService.getMovies();
    if (movies.isNotEmpty) {
      _lastId = movies.last.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Movie'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _directorController,
              decoration: const InputDecoration(labelText: 'Director'),
            ),
            TextField(
              controller: _releaseYearController,
              decoration: const InputDecoration(labelText: 'Release Year'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _ratingController,
              decoration: const InputDecoration(labelText: 'Rating'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                String title = _titleController.text;
                String director = _directorController.text;
                int releaseYear =
                    int.tryParse(_releaseYearController.text) ?? 0;
                double rating = double.tryParse(_ratingController.text) ?? 0;

                if (title.isNotEmpty &&
                    director.isNotEmpty &&
                    releaseYear > 0) {
                  Movie newMovie = Movie(
                    id: _lastId + 1,
                    title: title,
                    director: director,
                    releaseYear: releaseYear,
                    rating: rating,
                  );

                  await _databaseService.createMovie(newMovie);

                  _titleController.clear();
                  _directorController.clear();
                  _releaseYearController.clear();
                  _ratingController.clear();

                  _lastId++; // Increment the last ID

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Movie created successfully')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill in all fields')),
                  );
                }
              },
              child: const Text('Create Movie'),
            ),
          ],
        ),
      ),
    );
  }
}
