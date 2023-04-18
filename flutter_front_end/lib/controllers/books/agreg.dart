import 'package:http/http.dart' as http;

Future<void> attribuerLivreUtilisateur(
    String idUtilisateur, String idLivre) async {
  try {
    final response = await http.post(Uri.parse(
        'http://localhost:3000/utilisateurs/$idUtilisateur/livres/$idLivre'));
    if (response.statusCode == 200) {
      print("// Le livre a été attribué à l'utilisateur avec succès");
    } else {
      // La requête a échoué.
      throw Exception('Erreur ${response.statusCode} : ${response.body}');
    }
  } catch (error) {
    // La requête a échoué.
    print(error.toString());
  }
}
