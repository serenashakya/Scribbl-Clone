import 'package:flutter/material.dart';
import 'package:scribbl_clone/widget/custom_text_field.dart';

class CreateRoomScreen extends StatefulWidget {
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roomNameController = TextEditingController();
  late String? _maxRoundValue;
  late String? _roomSizeValue;

  // Add selected value for the dropdown
  String? _selectedRounds;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Create Room",
            style: TextStyle(color: Colors.black, fontSize: 30),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.08),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              controller: _nameController,
              hintText: "Enter your Name",
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              controller: _roomNameController,
              hintText: "Enter Room Name",
            ),
          ),
          SizedBox(height: 20),
          DropdownButton<String>(
            focusColor: Color(0xfff5f6fa),
            items:
                <String>["2", "5", "10", "15"]
                    .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    )
                    .toList(),
            hint: const Text(
              "Select Max Rounds",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            onChanged: (String? value) {
              setState(() {
                _maxRoundValue = value;
              });
            },
          ),
          SizedBox(height: 20),
          DropdownButton<String>(
            focusColor: Color(0xfff5f6fa),
            items:
                <String>["2", "3", "4", "5", "6", "7", "8"]
                    .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    )
                    .toList(),
            hint: const Text(
              "Select Room Size",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            onChanged: (String? value) {
              setState(() {
                _roomSizeValue = value;
              });
            },
          ),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.blue),
              textStyle: WidgetStateProperty.all(
                TextStyle(color: Colors.white),
              ),
              minimumSize: WidgetStateProperty.all(
                Size(MediaQuery.of(context).size.width / 2.5, 50),
              ),
            ),
            child: Text(
              "Create",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
