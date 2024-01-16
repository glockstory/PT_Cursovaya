// view.dart
import 'package:flutter/material.dart';
import 'controller.dart';
import 'model.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Faculty> faculties = [];
  FacultyController _facultyController = FacultyController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    String urlString = 'https://www.vstu.ru/university/fakultety-i-kafedry/';

    try {
      List<Faculty> data = await _facultyController.fetchData(urlString);
      setState(() {
        faculties = data;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Faculty List'),
      ),
      body: faculties.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: faculties.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(faculties[index].name),
                  onTap: () {
                    // Handle tap on .fak_link
                    // You can navigate to a new page or show more details
                    // about the selected faculty.
                    print('Tapped on ${faculties[index].name}');
                  },
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        faculties[index].liData.map((li) => Text(li)).toList(),
                  ),
                );
              },
            ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}
