import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter_sql_lite_crud/model/movie.dart';

class DatabaseService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'cinema_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE movies(
            id INTEGER PRIMARY KEY,
            title TEXT,
            director TEXT,
            releaseYear INTEGER,
            rating REAL
          )
        ''');
      },
    );
  }

  Future<void> createMovie(Movie movie) async {
    final db = await database;
    await db.insert(
      'movies',
      movie.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Movie>> getMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('movies');

    return List.generate(maps.length, (i) {
      return Movie(
        id: maps[i]['id'],
        title: maps[i]['title'],
        director: maps[i]['director'],
        releaseYear: maps[i]['releaseYear'],
        rating: maps[i]['rating'],
      );
    });
  }

  Future<void> updateMovie(Movie movie) async {
    final db = await database;
    await db.update(
      'movies',
      movie.toMap(),
      where: 'id = ?',
      whereArgs: [movie.id],
    );
  }

  Future<void> deleteMovie(int id) async {
    final db = await database;
    await db.delete(
      'movies',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
