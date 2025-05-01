import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import '../../controller/number_checker_controller.dart';
import '../../controller/settings_controller.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  final NumberController _numberController = NumberController();
  Map<String, String> _numberInfo = {};

  void _fetchNumberInfo() {
  final input = _controller.text.trim();
  debugPrint("User entered: '$input'");

  if (input.isEmpty) {
    setState(() {
      _numberInfo = {"Error": "Please enter a number!"};
    });
    return;
  }

  final number = int.tryParse(input);
  if (number == null) {
    setState(() {
      _numberInfo = {"Error": "Invalid input! Please enter a valid integer."};
    });
    return;
  }

  setState(() {
    _numberInfo = _numberController.getNumberInfo(number);
  });
}


  // void _fetchNumberInfo() {
  //   final input = _controller.text;
  //   if (input.isEmpty) {
  //     setState(() {
  //       _numberInfo = {"Error" : "Please enter a number!"};
  //     });
  //     return;
  //   }
  //   final number = int.tryParse(input);
  //   if (number == null) {
  //     setState(() {
  //       _numberInfo = {"Error" : "Invalid input! Please enter a valid integer."};
  //     });
  //     return;
  //   }
  //   setState(() {
  //     _numberInfo = _numberController.getNumberInfo(number);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Number Checker"),
        centerTitle: true,
        backgroundColor: const Color(0xFFADD8E6),
        titleTextStyle: TextStyle(
          fontSize: settings.fontSize,

          color: settings.fontColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Enter a number:",
                style: TextStyle(
                  fontSize: settings.fontSize,
        
                  color: settings.fontColor, 
                ),
              ),

              const SizedBox(height: 10),

              TextField(
  controller: _controller,
  keyboardType: const TextInputType.numberWithOptions(signed: true),
  decoration: InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    hintText: "Enter a number",
    filled: true,
    fillColor: Colors.grey[200],
  ),
),

              // TextField(
              //   controller: _controller,
              //   keyboardType: TextInputType.number,
              //   inputFormatters: [
              //     FilteringTextInputFormatter.allow(RegExp(r'^-?\d*$')),
              //   ],
              //   decoration: InputDecoration(
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(8),
              //     ),
              //     hintText: "Enter a number",
              //     filled: true,
              //     fillColor: Colors.grey[200],
              //   ),
              // ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _fetchNumberInfo,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFADD8E6),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: TextStyle(
                    fontSize: settings.fontSize,
          
                  ),
                  foregroundColor: settings.fontColor,
                ),
                child: const Text("Check"),
              ),
              const SizedBox(height: 20),
              _numberInfo.isEmpty
                  ? const Center(
                      child: Text(
                        "Enter a number to see its details",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Number Details",
                              style: TextStyle(
                                fontSize: settings.fontSize,
                                fontWeight: FontWeight.bold,
                                color: settings.fontColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            ..._numberInfo.entries.map((entry) {
                              return ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  entry.key,
                                  style: TextStyle(
                                    fontSize: settings.fontSize,
                                    fontWeight: FontWeight.bold,
                                    color: settings.fontColor, 
                                  ),
                                ),
                                subtitle: Text(
                                  entry.value,
                                  style: TextStyle(
                                    fontSize: settings.fontSize,
                                    color: settings.fontColor,
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
