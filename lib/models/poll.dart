class Poll {
  int id;
  String question;
  DateTime onCreated;
  DateTime endDate;
  List<dynamic> votes;
  List<dynamic> options;

  Poll({
    required this.onCreated,
    required this.id,
    required this.votes,
    required this.options,
    required this.question,
    required this.endDate,
  });
}

// {
//                 "onCreated": DateTime.now(),
//                 'id': 2,
//                 'votes': [
//                   // {"uid": "jehat", "option": 1},
//                   // {"uid": "deniz", "option": 1}
//                 ],
//                 'question': 'Do you think Oranguntans have the ability speak?',
//                 'end_date': DateTime(2022, 12, 25),
//                 'options': [
//                   {'id': 1, 'text': 'Yes, they definitely do', 'votes': 40},
//                   {'id': 2, 'text': 'No, they do not', 'votes': 0},
//                   {'id': 3, 'text': 'I do not know', 'votes': 10},
//                   {'id': 4, 'text': 'Why should I care?', 'votes': 30}
//                 ],
//               },