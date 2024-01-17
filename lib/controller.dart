import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;
import 'model.dart';

class FacultyController {
  Future<String> fetchDataAsJson(String urlString) async {
    Uri uri = Uri.parse(urlString);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final document = htmlParser.parse(response.body);

      final elements = document.querySelectorAll('.fak_link');
      List<Map<String, dynamic>> facultyList = [];

      for (var element in elements) {
        final facultyName = element.text;
        final liInfo = element.querySelectorAll('.spoiler_body');
        List<Map<String, dynamic>> departmentList = [];

        liInfo.forEach((li) {
          var link = li.querySelector('a')?.attributes['href'];
          var name = li.text;

          if (link != null && name.isNotEmpty) {
            departmentList.add({
              'name': name,
              'link': link,
              'teachers': [], // Placeholder for teachers, you can modify this based on the actual structure
            });
          }
        });

        facultyList.add({
          'facultyName': facultyName,
          'facultyInfo': '', // Add faculty information if available
          'departments': departmentList,
        });
      }

      // Convert facultyList to JSON
      String jsonData = facultyList.toString();
      print(jsonData);
      return jsonData;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
