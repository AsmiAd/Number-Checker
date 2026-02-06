import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/settings_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(
            fontSize: settings.fontSize,
            color: settings.fontColor,
          ),
        ),
        backgroundColor: const Color(0xFFADD8E6),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [

          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: ListTile(
              title: Text(
                "Background Color",
                style: TextStyle(
                  fontSize: settings.fontSize,
                  color: settings.fontColor,
                ),
              ),
              trailing: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: CircleAvatar(
                  backgroundColor: settings.backgroundColor,
                  radius: 12,
                ),
              ),
              onTap: () {
                _showColorPicker(context, settings.changeBackgroundColor);
              },
            ),
          ),

          const SizedBox(height: 16),

          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: ListTile(
              title: Text(
                "Font Size",
                style: TextStyle(
                  fontSize: settings.fontSize,
                  color: settings.fontColor,
                ),
              ),
              subtitle: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.blue[700],
                  inactiveTrackColor: Colors.blue[100],
                  thumbColor: Colors.blue,
                  overlayColor: Colors.blue.withAlpha(32),
                  valueIndicatorColor: Colors.blue,
                ),
                child: Slider(
                  min: 12,
                  max: 30,
                  divisions: 9,
                  value: settings.fontSize,
                  label: settings.fontSize.toString(),
                  onChanged: (newSize) {
                    settings.changeFontSize(newSize);
                  },
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: ListTile(
              title: Text(
                "Font Color",
                style: TextStyle(
                  fontSize: settings.fontSize,
                  color: settings.fontColor,
                ),
              ),
              trailing: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: CircleAvatar(
                  backgroundColor: settings.fontColor,
                  radius: 12,
                ),
              ),
              onTap: () {
                _showColorPicker(context, settings.changeFontColor);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showColorPicker(BuildContext context, Function(Color) onColorSelected) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Pick a Color"),
          content: Wrap(
            spacing: 10,
            children: [
              _colorCircle(Colors.white, onColorSelected, context),
              _colorCircle(Colors.black, onColorSelected, context),
              _colorCircle(Colors.blue, onColorSelected, context),
              _colorCircle(Colors.red, onColorSelected, context),
              _colorCircle(Colors.green, onColorSelected, context),
              _colorCircle(Colors.purple, onColorSelected, context),
              _colorCircle(Colors.orange, onColorSelected, context),
              _colorCircle(Colors.teal, onColorSelected, context),
            ],
          ),
        );
      },
    );
  }

  Widget _colorCircle(Color color, Function(Color) onColorSelected, BuildContext context) {
    return GestureDetector(
      onTap: () {
        onColorSelected(color);
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey, width: 1),
        ),
        child: CircleAvatar(
          backgroundColor: color,
          radius: 20,
        ),
      ),
    );
  }
}
