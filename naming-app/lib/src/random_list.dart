import 'package:english_words/english_words.dart';
import 'package:english_words/english_words.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:flutter_app/src/bloc/bloc.dart';
import 'package:flutter_app/src/saved.dart';

class RandomList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RandomListState();
}

class _RandomListState extends State<RandomList> {
  final List<WordPair> _suggestions = <WordPair>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Naming app")),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.list),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SavedList()));
              },
            )
          ],
        ),
        body: _buildList());
  }

  Widget _buildList() {
    return StreamBuilder<Set<WordPair>>(
      stream: bloc.savedStream,
      builder: (context, snapshot) {
        return ListView.builder(itemBuilder: (context, index) {
          if (index.isOdd) return Divider();

          var realIndex = index ~/ 2;

          if (realIndex >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }

          return _buildRow(snapshot.data, _suggestions[realIndex]);
        });
      }
    );
  }

  Widget _buildRow(Set<WordPair> saved, WordPair wordPair) {
    final bool alreadSaved = saved == null ? false : saved.contains(wordPair);

    return ListTile(
      title: Text(
        wordPair.asPascalCase,
        textScaleFactor: 1.5,
      ),
      trailing: Icon(alreadSaved ? Icons.favorite : Icons.favorite_border,
          color: Colors.pink),
      onTap: () {
        bloc.addToOrRemoveFromSavedList(wordPair);
      },
    );
  }
}
