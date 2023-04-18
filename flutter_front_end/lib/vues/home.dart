import 'package:flutter/material.dart';
import 'package:flutter_front_end/controllers/books/readBooks.dart';
import 'package:flutter_front_end/models/Books/readAllBooks.dart';
import 'package:flutter_front_end/vues/composants/bottomAppBar.dart';
import 'package:flutter_front_end/vues/composants/post.dart';
import 'package:flutter_front_end/vues/userLibrary.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Books>> _bookFuture;

  @override
  void initState() {
    super.initState();
    _bookFuture = fetchBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Books',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromRGBO(32, 34, 37, 1),
      ),
      body: Container(
        color: const Color.fromRGBO(32, 34, 37, 1),
        child: FutureBuilder<List<Books>>(
          future: _bookFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final books = snapshot.data!;
              return ListView.builder(
                itemCount: books.length,
                itemBuilder: (BuildContext context, int index) {
                  final book = books[index];
                  return Column(
                    children: [
                      Post(
                        id: book.id,
                        imgUrl: book.imageUrl,
                        titre: book.title,
                        tome: book.issueNumber,
                        description: book.description,
                        index: index,
                        status: book.status,
                      ),
                      const SizedBox(height: 20),
                    ],
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            // Afficher un indicateur de chargement lorsque les données sont en train d'être chargées
            return const CircularProgressIndicator();
          },
        ),
      ),
      bottomNavigationBar: MyBottomAppBar(context: context),
    );
  }
}
