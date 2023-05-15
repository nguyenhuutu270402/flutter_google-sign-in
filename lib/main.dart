import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WhatsApp Me',
      home: Scaffold(
        body: HomePage(),
      ),
    );
  }
}

final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GoogleSignInAccount? _currentUser;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((event) {
      setState(() {
        _currentUser = event;
      });
    });
    _googleSignIn.signInSilently();
  }

  Future<void> siginInGG() async {
    try {
      var value = await _googleSignIn.signIn();
      print(">>>uuuuu: ${value}");
    } catch (e) {
      print("Error sigin GG: $e");
    }
  }

  void siginOutGG() {
    _googleSignIn.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    GoogleSignInAccount? user = _currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Google Sign in"),
      ),
      body: Center(
        child: Container(
          child: user == null
              ? Column(
                  children: [
                    Text("Chưa đăng nhập"),
                    ElevatedButton(
                      onPressed: siginInGG,
                      child: Text("Sign in"),
                    ),
                  ],
                )
              : Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    children: [
                      ListTile(
                        leading: GoogleUserCircleAvatar(identity: user),
                        title: Text(user.displayName ?? ""),
                        subtitle: Text(user.email),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Signed in successfully!"),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: siginOutGG,
                        child: Text("Sign out"),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
