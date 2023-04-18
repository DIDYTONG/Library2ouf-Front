import 'dart:convert';
import 'package:flutter_front_end/models/Books/readAllBooks.dart';
import 'package:http/http.dart' as http;

Future<List<Books>> fetchBooks() async {
  final response = await http.get(Uri.parse('http://localhost:3000/books'));

  if (response.statusCode == 200) {
    final List<dynamic> booksJson = jsonDecode(response.body);
    return booksJson.map((json) => Books.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load books');
  }
}
