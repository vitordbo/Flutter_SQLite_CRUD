import 'package:flutter/material.dart';
import 'package:flutter_sql_lite_crud/model/movie.dart';
import 'package:flutter_sql_lite_crud/sql_lite/database_service.dart';

class UpdateScreen extends StatefulWidget {
  final Movie movie;

  UpdateScreen({required this.movie});

  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final DatabaseService _databaseService = DatabaseService();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _directorController = TextEditingController();
  final TextEditingController _releaseYearController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.movie.title;
    _directorController.text = widget.movie.director;
    _releaseYearController.text = widget.movie.releaseYear.toString();
    _ratingController.text = widget.movie.rating.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Movie'),
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
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                String newTitle = _titleController.text;
                String newDirector = _directorController.text;
                int newReleaseYear =
                    int.tryParse(_releaseYearController.text) ?? 0;
                double newRating =
                    double.tryParse(_ratingController.text) ?? 0.0;

                if (newTitle.isNotEmpty &&
                    newDirector.isNotEmpty &&
                    newReleaseYear > 0) {
                  Movie updatedMovie = Movie(
                    id: widget.movie.id,
                    title: newTitle,
                    director: newDirector,
                    releaseYear: newReleaseYear,
                    rating: newRating,
                  );

                  await _databaseService.updateMovie(updatedMovie);

                  Navigator.pop(context); // Return to ReadScreen after update
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill in all fields')),
                  );
                }
              },
              child: Text('Update Movie'),
            ),
          ],
        ),
      ),
    );
  }
}
