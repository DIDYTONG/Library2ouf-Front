import 'package:http/http.dart' as http;

Future<void> updateBookStatus(
    String libraryId, String bookId, String status) async {
  final url = Uri.parse(
      'http://localhost:3000/library/$libraryId/book/$bookId/$status');
  try {
    final response = await http.post(url);

    if (response.statusCode != 200) {
      throw Exception(
          'Failed to update book status. Status code: ${response.statusCode}');
    }

    print('Book status updated successfully');
  } catch (error) {
    print('Error while updating book status: $error');
    rethrow;
  }
}
