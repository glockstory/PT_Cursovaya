// controller.dart
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;
import 'model.dart';

class FacultyController {
  Future<List<Faculty>> fetchData(String urlString) async {
    Uri uri = Uri.parse(urlString);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final document = htmlParser.parse(response.body);

      final elements = document.querySelectorAll('.fak_link');
      List<Faculty> data = [];
      for (var element in elements) {
        final facultyName = element.text;
        final liInfo = document.getElementsByClassName('spoiler_body');
        print(liInfo);
        liInfo.forEach((element) {
          var inner = element.innerHtml.toString();
          print(inner);
          if (inner.contains('href')) {}
        });
        final liData = element
            .querySelectorAll('.spoiler_body')
            .map((li) => li.text)
            .toList();
        data.add(Faculty(facultyName, liData));
      }

      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
