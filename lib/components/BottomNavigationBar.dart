import 'package:flutter/material.dart';
import 'package:flutter_p/pages/StartingPage.dart';

class BottomNaviatiobBar extends StatelessWidget {
  const BottomNaviatiobBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          label: 'Back',
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        BottomNavigationBarItem(

          label: 'Home',
          icon: Icon(
            Icons.home,
            color: Colors.white,
          ),
        ),
        BottomNavigationBarItem(
          label: 'Add',
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
        )
      ],
      backgroundColor: Colors.red,
      currentIndex: 0,
      onTap: (int value) {
        // Handle navigation here
         switch (value) {
          case 0:
            // Navigator.pushNamed(context, '/'); // Navigate to the first screen
            break;
          case 1:
             Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return const StartingPage();
                })); // Navigate to the second screen
            break;
          // Add cases for more items if needed
        }
      },
    );
  }
}