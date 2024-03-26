import 'package:flutter/material.dart';

class BranchCreationPage extends StatelessWidget {
  const BranchCreationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Branch'),
        backgroundColor: Colors.red,
      ),
      body: BranchCreationForm(),
      bottomNavigationBar: BottomNavigationBar(
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
        },
      ),
    );
  }
}

class BranchCreationForm extends StatefulWidget {
  const BranchCreationForm({Key? key}) : super(key: key);

  @override
  _BranchCreationFormState createState() => _BranchCreationFormState();
}

class _BranchCreationFormState extends State<BranchCreationForm> {
  final TextEditingController _branchCodeController = TextEditingController();
  final TextEditingController _branchNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0), // Adjust padding as needed
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 120.0,
                child: Text(
                  'Branch Code:',
                  style: TextStyle(fontSize: 12.0), // Decrease font size
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: SizedBox(
                  height: 30.0,
                  child: TextField(
                    controller: _branchCodeController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8.0),
                      hintText: 'Enter branch code',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 120.0,
                child: Text(
                  'Branch Name:',
                  style: TextStyle(fontSize: 12.0), // Decrease font size
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: SizedBox(
                  height: 30.0,
                  child: TextField(
                    controller: _branchNameController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8.0),
                      hintText: 'Enter branch name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 120.0,
                child: Text(
                  'Address:',
                  style: TextStyle(fontSize: 12.0), // Decrease font size
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: SizedBox(
                  height: 30.0,
                  child: TextField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8.0),
                      hintText: 'Enter address',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 120.0,
                child: Text(
                  'Contact Number:',
                  style: TextStyle(fontSize: 12.0), // Decrease font size
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: SizedBox(
                  height: 30.0,
                  child: TextField(
                    controller: _contactNumberController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8.0),
                      hintText: 'Enter contact number',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 120.0,
                child: Text(
                  'Branch:',
                  style: TextStyle(fontSize: 12.0), // Decrease font size
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: SizedBox(
                  height: 10,
                  width: double.infinity,
                    child: DropdownMenu(
                      menuHeight: 20,
                      menuStyle: MenuStyle(),
                      dropdownMenuEntries: [
                        
                        DropdownMenuEntry(
                            value: "2001 - Hello", 
                            label: "Hellooo",
                            style: ButtonStyle(
                              
                            )
                        )
                      ],
                    )
                    // TextField(
                    //   controller: _contactNumberController,
                    //   decoration: InputDecoration(
                    //     contentPadding: EdgeInsets.all(8.0),
                    //     hintText: 'Enter contact number',
                    //     border: OutlineInputBorder(),
                    //   ),
                    // ),
                    ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              // Perform action on button press (e.g., create branch)
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.red, // Set button color to red
              minimumSize: Size(double.infinity, 40.0), // Set full width
            ),
            child: Text('Create Branch'),
          ),
        ],
      ),
    );
  }
}
