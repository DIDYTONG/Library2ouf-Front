import 'package:flutter/material.dart';
import 'package:flutter_front_end/env.dart';
import '../../controllers/library/updateStatusBook.dart';
import '../../controllers/books/agreg.dart';

class PostLibrary extends StatefulWidget {
  final String imgUrl;
  final String titre;
  final String tome;
  final int index;
  final String description;
  final String id;
  final String status;

  const PostLibrary(
      {super.key,
      required this.imgUrl,
      required this.titre,
      required this.tome,
      required this.index,
      required this.description,
      required this.id,
      required this.status});

  @override
  State<PostLibrary> createState() => _PostLibraryState();
}

class _PostLibraryState extends State<PostLibrary> {
  void popUpRemove(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final width = MediaQuery.of(context).size.width;
        final height = MediaQuery.of(context).size.height;
        return SimpleDialog(
          backgroundColor: const Color.fromRGBO(255, 255, 255, 0.8),
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              width: width * 0.5,
              height: height * 0.20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Column(
                  children: [
                    const Text(
                      'Supprimer de la bibliothèque',
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
                          onPressed: () {},
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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onLongPress: () => popUpRemove(context),
      onTap: () => popUpOption(
          context,
          widget.index,
          widget.imgUrl,
          widget.titre,
          widget.tome,
          widget.description,
          widget.id,
          widget.status),
      child: Container(
        width: width * 0.45,
        height: height * 0.245,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(64, 68, 75, 100),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Container(
              padding: EdgeInsets.all(10),
              width: width * 0.40,
              child: Image.network(widget.imgUrl),
            )),
          ],
        ),
      ),
    );
  }
}

void popUpOption(BuildContext context, int index, String imgUrl, String titre,
    String tome, String description, String id, String status) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final width = MediaQuery.of(context).size.width;
      final height = MediaQuery.of(context).size.height;
      return SimpleDialog(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 0.8),
        children: [
          Container(
            width: width * 0.8,
            height: height * 0.55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      width: width * 0.5,
                      child: Image.network(imgUrl),
                    ),
                    SizedBox(
                      width: width / 16,
                    ),
                    Column(
                      children: [
                        Text(
                          status,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          iconSize: 50,
                          color: Colors.green,
                          icon: const Icon(Icons.check),
                          onPressed: () {
                            updateBookStatus(LIBRARY, id, "Read");

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Votre livre a été ajouté avec succès.',
                                  style: TextStyle(color: Colors.green),
                                ),
                                duration: Duration(seconds: 3),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          iconSize: 50,
                          color: Colors.orange,
                          icon: const Icon(Icons.menu_book_outlined),
                          onPressed: () {
                            updateBookStatus(LIBRARY, id, "In process");
                            print(id);
                            print(status);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Votre livre est en cours de lecture !.',
                                  style: TextStyle(color: Colors.orange),
                                ),
                                duration: Duration(seconds: 3),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          iconSize: 50,
                          color: Colors.red,
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            updateBookStatus(LIBRARY, id, "Not read");
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Le livre à été supprimé de votre bibliothèque',
                                  style: TextStyle(color: Colors.red),
                                ),
                                duration: Duration(seconds: 3),
                              ),
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      titre,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      tome,
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(description),
                )
              ],
            ),
          ),
        ],
      );
    },
  );
}
