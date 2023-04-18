import 'dart:convert';
import 'package:flutter_front_end/models/Books/readAllBooks.dart';
import 'package:http/http.dart' as http;

Future<List<Books>> filter(String id, String filter) async {
  final response =
      await http.get(Uri.parse('http://localhost:3000/library/$id'));

  if (response.statusCode == 200) {
    final List<dynamic> booksJson = jsonDecode(response.body);
    final List<Books> readBooks = [];

    for (final json in booksJson) {
      final book = Books.fromJson(json);
      if (book.status == filter) {
        readBooks.add(book);
      }
    }

    return readBooks;
  } else {
    throw Exception('Failed to load books');
  }
}
