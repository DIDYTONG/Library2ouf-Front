import 'package:http/http.dart' as http;

Future<void> addBookToLibrary(String libraryId, String userId) async {
  try {
    final response = await http.post(
        Uri.parse('http://localhost:3000/library/$libraryId/user/$userId'));

    if (response.statusCode == 200) {
      print('// Livres ajoutés avec succès.');
      print(response.body);
    } else {
      // La requête a échoué.
      throw Exception('Erreur ${response.statusCode} : ${response.body}');
    }
  } catch (error) {
    // La requête a échoué.
    print(error.toString());
  }
}
