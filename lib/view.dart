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
    _facultyController.fetchDataAsJson(urlString);
    try {
      //List<Faculty> data = await _facultyController.fetchData(urlString);
      setState(() {
        //faculties = data;
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
                    print(faculties[index].resourceLinks);
                Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FacultyDetailsPage(faculty: faculties[index], facultyIndex: index,),
                      ),);
                    print('Tapped on ${faculties[index].name}');
                  },
                );
              },
            ),
    );
  }
}

class FacultyDetailsPage extends StatelessWidget {
  final Faculty faculty;
  final int facultyIndex;
  FacultyDetailsPage({required this.faculty, required this.facultyIndex});

  @override
  Widget build(BuildContext context) {

  
    return Scaffold(
      appBar: AppBar(
        title: Text('${faculty.name}'),
      ),
      body: ListView.builder(
        itemCount: faculty.resourceLinks[facultyIndex].length,
        itemBuilder: (context, index) {
          return ListTile(  
            title: ElevatedButton(
              onPressed: () {

                print(faculty.resourceLinks[index].length);
                // Обработайте нажатие на ресурс по вашему усмотрению
                print('Tapped on ${faculty.resourceNames[index]}');
              },
              child: Text(faculty.resourceLinks[facultyIndex]),
          ));
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
