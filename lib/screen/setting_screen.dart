import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:submission2/provider/scheduling_provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Setting",
          style: GoogleFonts.poppins(),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ListView(
              children: [
                // ElevatedButton(
                //     onPressed: () {
                //       BackgroundService.callback();
                //     },
                //     child: Text("tes")),
                ListTile(
                  title: Text(
                    'Restaurant Notification',
                    style: GoogleFonts.poppins(),
                  ),
                  trailing: Consumer<SchedulingProvider>(
                    builder: (context, scheduled, _) {
                      return Switch.adaptive(
                        value: scheduled.isScheduled,
                        onChanged: (value) async {
                          scheduled.scheduledRestaurant(value);
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setBool('isScheduled', value);
                        },
                      );
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
