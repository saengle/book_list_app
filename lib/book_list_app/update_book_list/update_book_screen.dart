import 'package:book_list_app/book_list_app/delete_book_list/delete_book_view_model.dart';
import 'package:book_list_app/book_list_app/update_book_list/update_book_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateBookScreen extends StatefulWidget {
  final DocumentSnapshot document;

  const UpdateBookScreen(this.document, {Key? key}) : super(key: key);

  @override
  State<UpdateBookScreen> createState() => _UpdateBookScreen();
}

class _UpdateBookScreen extends State<UpdateBookScreen> {
  final _titleTextController = TextEditingController();
  final _authorTextController = TextEditingController();

  final updateViewModel = UpdateBookViewModel();
  final deleteViewModel = DeleteBookViewModel();

  Map<String, dynamic> data = {};

  @override
  void initState() {
    data = widget.document.data()! as Map<String, dynamic>;
    super.initState();
  }

  @override
  void dispose() {
    _titleTextController.dispose();
    _authorTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('도서 관리'),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (_) {
              setState(() {});
            },
            controller: _titleTextController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: data['title'],
            ),
          ),
          TextField(
            onChanged: (_) {
              setState(() {});
            },
            controller: _authorTextController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: data['author'],
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              try {
                updateViewModel.updateBook(
                  document: widget.document,
                  title: _titleTextController.text,
                  author: _authorTextController.text,
                );
                Navigator.pop(context);
              } catch (e) {
                //에러가 났을 때
                final snackBar = SnackBar(
                  content: Text(e.toString()),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } finally {
                //옵션
                //에러가 나거나, 안 나거나 무조건 마지막에 수행 하는 블럭.
              }
            },
            child: const Icon(Icons.save),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              deleteViewModel.deleteBook(document: widget.document);
              Navigator.pop(context);
            },
            child: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
