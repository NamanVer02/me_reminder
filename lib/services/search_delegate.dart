import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:me_reminder/models/birthday.dart';
import 'package:me_reminder/services/birthday_data.dart';

class CustomSearchClass extends SearchDelegate {
  CustomSearchClass({required this.searchTerms});
  
  List<Birthday> searchTerms;
  BirthdayDB db = BirthdayDB();
  final DateFormat formatter = DateFormat('d MMM');

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Birthday> matchQuery = [];
    for (var birthday in searchTerms) {
      if (birthday.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(birthday);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result.name),
          onTap: (){},
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Birthday> matchQuery = [];
    for (var birthday in searchTerms) {
      if (birthday.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(birthday);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];

        return ListTile(
          title: Text(result.name),
          trailing: Text(formatter.format(result.date)),
        );
      },
    );
  }
}
