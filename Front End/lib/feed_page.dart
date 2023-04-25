import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_tutorials/hyperlinks/hyperlinks.dart';
import 'package:flutter_tutorials/login.dart';
import 'package:flutter_tutorials/my_profile.dart';
import 'package:flutter_tutorials/view_user_profile.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'helper_functions/create_posts_processing.dart';
import 'package:http/http.dart' as http;

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  // controllers for the post content
  TextEditingController email = TextEditingController();
  TextEditingController content = TextEditingController();

  // controller for the search bar
  final TextEditingController _searchBar = TextEditingController();

  // stream for the post display
  final StreamController<List<dynamic>> _postDisplay = StreamController();

  void endStream() {
    _postDisplay.close();
  }

  void displayPosts() async {
    String url = 'https://us-central1-social-media-api-383221.cloudfunctions.net/social-media-api/posts';
    final uri = Uri.parse(url);

    final response = await http.get(uri);
    if(response.statusCode == 200) {
      final jsonFormat = '[${response.body}]';

      List<dynamic> listOfPosts = jsonDecode(jsonFormat);
      _postDisplay.sink.add(listOfPosts);

    }
    else {
      throw Exception("Error. Failed to load data");
    }
  }

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(seconds: 3), (timer) {
      displayPosts();
    });


  }
  @override
  Widget build(BuildContext context) {
    final String userID = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: MediaQuery.of(context).size.width*0.2,
            height: MediaQuery.of(context).size.height,

            color: const Color(0xFFAD3537),
            child: Column(
              children:  [
                const SizedBox(height: 150),
                const Center(
                  child: Text(
                    'TEATIME',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,

                    ),
                  ),
                ),
                const SizedBox(height: 100),
                Image.asset('images/ashesi-logo.png',
                  width: 200,
                  height: 200,
                ),

                const SizedBox(height: 100),
                Row(
                  children:  [
                    const SizedBox(width:77 ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (
                                context) => const MyProfileForm(),
                              settings: RouteSettings(
                                arguments: userID,
                              ), // Navigate to the ny profile page
                            ));
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.person,
                            size: 40,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
                          Text('My profile',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height:30),
                Row(
                  children: [
                    const SizedBox(width:80),
                    InkWell(
                      onTap: () {
                        QuickAlert.show(
                            context: context,
                            type: QuickAlertType.success,
                            width: 200,
                            text: 'Successfully logged out!',
                            onConfirmBtnTap: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (
                                    context) => const LoginForm()), // Navigate to the feed page on clicking okay
                              );
                            }
                        );
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.logout,
                            size: 40,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
                          Text('Logout',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 70,
                      child: Row(
                        children:  [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: _searchBar,
                                onFieldSubmitted: (searchBar) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (
                                          context) => const ViewProfileForm(),
                                        settings: RouteSettings(
                                          arguments: {"arg1":userID,"arg2":searchBar},
                                        ), // Navigate to the feed page on clicking okay
                                      ));
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Search User by student ID',
                                  suffixIcon: Icon(Icons.search),

                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: StreamBuilder<List<dynamic>>(
                        stream: _postDisplay.stream,
                        builder: (context,snapdata){
                          switch(snapdata.connectionState){
                            case ConnectionState.waiting: return const Center(child: CircularProgressIndicator(),);
                            default: if(snapdata.hasData){
                              List<dynamic> posts = snapdata.data as List<dynamic>;
                              Map<String,dynamic> postMap = posts[0];
                              List<dynamic> listPost = [];

                              for ( final post in postMap.values){listPost.add(post);}
                              listPost = listPost.reversed.toList();
                              return ListView.builder(
                                itemCount: listPost.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                      margin: const EdgeInsets.all(8),
                                      padding: const EdgeInsets.all(8),
                                      color: Colors.white, child: ListTile(
                                    // POST
                                    title: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          listPost[index]['email']!,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Chirp"
                                          ),
                                        )
                                    ),

                                    subtitle: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          listPost[index]['content']!,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Chirp"
                                          ),
                                        )
                                    ),

                                  )
                                  );
                                },
                              );

                            }if (snapdata.hasError) {
                              print(snapdata.error.toString());
                              return const Text('error');
                            }
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 40,
                  right: 40,
                  child: IconButton(
                    icon: const Icon(
                      Icons.add_circle,
                      size: 60.0,
                      color: Color(0xFFAD3537),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              'New post',
                              textAlign: TextAlign.center,
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  controller: email,
                                  decoration: const InputDecoration(
                                    labelText: 'Email',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: content,
                                  maxLines: 5,
                                  cursorWidth: 20,
                                  decoration: const InputDecoration(
                                    labelText: 'Type something...',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                child: const Text('CANCEL'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text('POST'),
                                onPressed: () async {
                                  await createPost(context, email.text, content.text);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ),


          Container(
            width: MediaQuery.of(context).size.width*0.2,
            height: MediaQuery.of(context).size.height,

            color: const Color(0xFFAD3537),
            child: Column(
              children:  [
                const SizedBox(height: 150),
                const Center(
                  child: Text(
                    'Essentials',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,

                    ),
                  ),
                ),
                const SizedBox(height: 100),
                InkWell(
                  onTap: () => launchAppServer(),

                  child: Row(
                    children: const [
                      SizedBox(width: 60),
                      Icon(Icons.account_balance_sharp,
                        size: 40,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text('App Server',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height:40),
                InkWell(
                    onTap: () => launchASC(),
                    child: Row(

                      children: const [
                        SizedBox(width:60),
                        Icon(Icons.school_rounded,
                          size: 40,
                          color: Colors.white,

                        ),
                        SizedBox(width: 10),
                        Text('ASC Content',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,

                          ),
                        ),
                      ],
                    )
                ),
                const SizedBox(height:40),

                InkWell(
                  onTap: () => launchLibrarySite(),
                  child: Row(
                    children: const [
                      SizedBox(width:60),
                      Icon(Icons.local_library,
                        size: 40,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text('Warren Library',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

