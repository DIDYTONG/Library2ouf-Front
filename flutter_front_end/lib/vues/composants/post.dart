import 'package:flutter/material.dart';
import 'package:flutter_front_end/controllers/library/addBooksLib.dart';
import 'package:flutter_front_end/env.dart';

import '../../controllers/books/agreg.dart';

class Post extends StatefulWidget {
  final String imgUrl;
  final String titre;
  final String tome;
  final int index;
  final String description;
  final String id;
  final String status;

  const Post(
      {super.key,
      required this.imgUrl,
      required this.titre,
      required this.tome,
      required this.index,
      required this.description,
      required this.id,
      required this.status});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () => popUpOption(context, widget.index, widget.imgUrl,
          widget.titre, widget.tome, widget.description, widget.id),
      child: Container(
        width: width * 0.8,
        height: height * 0.4,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(64, 68, 75, 100),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              width: width * 0.5,
              child: Image.network(widget.imgUrl),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  widget.titre,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  widget.tome,
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

void popUpOption(BuildContext context, int index, String imgUrl, String titre,
    String tome, String description, String id) {
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
                    IconButton(
                      iconSize: 50,
                      color: Colors.green,
                      icon: const Icon(Icons.add),
                      onPressed: () async {
                        attribuerLivreUtilisateur(USER, id);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Votre livre a été ajouté avec succès.',
                              style: TextStyle(color: Colors.green),
                            ),
                            duration: Duration(seconds: 3),
                          ),
                        );
                        for (int i = 0; i < 10; i++) {
                          await Future.delayed(Duration(seconds: 10));
                          addBookToLibrary(LIBRARY, USER);
                        }
                      },
                    ),
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
