import 'package:flutter/material.dart';
import 'package:flutter_front_end/controllers/library/readLibrary.dart';
import 'package:flutter_front_end/env.dart';
import 'package:flutter_front_end/models/Books/readAllBooks.dart';
import 'package:flutter_front_end/vues/composants/bottomAppBar.dart';
import 'package:flutter/widgets.dart';

import '../controllers/books/agreg.dart';
import '../controllers/library/filterController.dart';
import 'composants/postLibrary.dart';

class UserLibrary extends StatefulWidget {
  const UserLibrary({Key? key}) : super(key: key);

  @override
  _UserLibraryState createState() => _UserLibraryState();
}

class _UserLibraryState extends State<UserLibrary> {
  late Future<List<Books>> _bookFuture;
  String state = "Not read";

  @override
  void initState() {
    super.initState();
    _bookFuture = filter(LIBRARY, state);
  }

  void popUpOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final width = MediaQuery.of(context).size.width;
        final height = MediaQuery.of(context).size.height;
        return SimpleDialog(
          backgroundColor: const Color.fromRGBO(255, 255, 255, 0.8),
          children: [
            Container(
              width: width * 0.5,
              height: height * 0.11,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Column(
                  children: [
                    const Text(
                      'Filtre',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          iconSize: 50,
                          color: Colors.green,
                          icon: const Icon(Icons.check),
                          onPressed: () {
                            print(state);
                            setState(() {
                              state = "Read";
                              _bookFuture = filter(LIBRARY, state);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Filtre non lu affiché !',
                                  style: TextStyle(color: Colors.green),
                                ),
                                duration: Duration(seconds: 3),
                              ),
                            );
                            Navigator.pop(context);
                          },
                        ),
                        IconButton(
                          iconSize: 50,
                          color: Colors.orange,
                          icon: const Icon(Icons.hourglass_empty),
                          onPressed: () {
                            print("livre à " + state);
                            setState(() {
                              state = "In process";
                              _bookFuture = filter(LIBRARY, state);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Filtre en cours affiché !',
                                  style: TextStyle(color: Colors.orange),
                                ),
                                duration: Duration(seconds: 3),
                              ),
                            );
                            Navigator.pop(context);
                          },
                        ),
                        IconButton(
                          iconSize: 50,
                          color: Colors.red,
                          icon: Icon(Icons.block),
                          onPressed: () {
                            print(state);
                            setState(() {
                              state = "Not read";
                              _bookFuture = filter(LIBRARY, state);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Livres non lus affichés !',
                                  style: TextStyle(color: Colors.red),
                                ),
                                duration: Duration(seconds: 3),
                              ),
                            );
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Library ($state)',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromRGBO(32, 34, 37, 1),
      ),
      //App,
      body: Container(
        color: const Color.fromRGBO(32, 34, 37, 1),
        child: FutureBuilder<List<Books>>(
          future: _bookFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final books = snapshot.data!;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: books.length,
                itemBuilder: (BuildContext context, int index) {
                  final book = books[index];
                  return PostLibrary(
                    id: book.id,
                    imgUrl: book.imageUrl,
                    titre: book.title,
                    tome: book.issueNumber,
                    description: book.description,
                    index: index,
                    status: book.status,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => popUpOptions(context),
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.line_axis_outlined,
          color: Colors.black,
        ),
      ),
      bottomNavigationBar: MyBottomAppBar(context: context),
    );
  }
}
