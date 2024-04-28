import 'package:flutter/material.dart';
import 'package:flutter_p/components/BottomNavigationBar.dart';
import 'package:flutter_p/pages/APICalling.dart';
import 'package:flutter_p/pages/SecondPage.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
      String buttonName = 'Click';

  int currentIndex = 0;
  bool isClicked = true;
  
    return Scaffold(
      appBar: AppBar(
        // title: const Text('App Title'),
        backgroundColor: Colors.red,
        // Theme.of(context).colorScheme.onPrimaryContainer,
        actions: [
          IconButton(
              onPressed: () {
                print('helloo');
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ))
        ],
      ),
      body: Center(
        child: currentIndex == 0
            ? Container(
                height: double.infinity,
                // width: double.infinity,
                // color: Colors.blueAccent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Color.fromARGB(255, 255, 255, 255),
                        backgroundColor: Color.fromARGB(255, 255, 0, 0),
                        // textStyle: TextStyle(color: Colors.white, backgroundColor: Colors.red)
                      ),
                      onPressed: () {
                        // int index;
                        // String
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return const SecondPage();
                        }));
                        // setState(() {
                        //   buttonName = 'Button Clicked';
                        // });
                      },
                      child: const Text('Generate QR Code'),
                      // style: ButtonStyle(backgroundColor: ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // setState(() {
                        //   buttonName = 'Button Clicked';
                        // });
                         Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return const APICalling();
                        }));
                      },
                      child: Text(buttonName),
                      // style: ButtonStyle(backgroundColor: ),
                    ),
                  ],
                ),
              )
            : currentIndex == 1
                ? GestureDetector(
                  onTap: (){
                    setState(() {
                      isClicked = !isClicked;
                    });
                  },
                  child: isClicked?  Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTEX9pl8af7Y7nzBN_8gY3XmGZKCzkUOqRcod9oXuBf4g&s')
                    : Image.asset('images/postPng.png'),
                ) 
                : Image.asset('images/postPng.png'),
      ),
      // bottomNavigationBar: BottomNaviatiobBar(),
    );
  }
}