import 'package:url_launcher/url_launcher.dart';

void launchAppServer() async {
  const appServer = 'https://apps.ashesi.edu.gh/';
  final url = Uri.parse(appServer);
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

void launchASC() async {
  const ASC = 'https://www.instagram.com/ashesistudentcouncil/';
  final url = Uri.parse(ASC);
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

void launchLibrarySite() async {
  const library = 'https://opac.ashesi.edu.gh/#gsc.tab=0';
  final url = Uri.parse(library);
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}