import 'package:url_launcher/url_launcher.dart';

const List<String> algorithms = [
  "Insertion",
  "Bubble",
  "Merge",
];

const dataTypes = <String, (Type, bool)>{
  'Number': (int, false),
  'Alphabets': (String, false),
};
Future<void> _launchUrl(Uri _url) async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}
