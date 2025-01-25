import 'package:flutter/material.dart';
import 'package:furniture_app/main.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  void _openGoogleMaps() async {
    const String googleMapsUrl =
        "https://maps.app.goo.gl/aZM7uH8uPqfHU8uD6?g_st=com.google.maps.preview.copy";
    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not open Google Maps';
    }
  }

  void _openWhatsApp() async {
    const String whatsappUrl = "https://wa.me/+201068811722";
    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Could not open WhatsApp';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey[900], // Background color for footer
      padding: const EdgeInsets.all(20), // Padding inside the footer
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// Logo or Website Name
          const Text(
            'Faramawysuez',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 20),

          /// Location Link
          TextButton.icon(
            onPressed: _openGoogleMaps,
            icon: const Icon(
              Icons.location_on,
              color: Colors.white,
            ),
            label: const Text(
              'Our Location',
              style: TextStyle(color: Colors.white),
            ),
          ),

          const SizedBox(height: 20),

          /// Social Media Links (WhatsApp)
          // IconButton(
          //   icon: Image.asset("assets/icons/whatsapp.png"),
          //   color: Colors.white,
          //   iconSize: 30,
          //   onPressed: _openWhatsApp,
          // ),

          InkWell(
            onTap: _openWhatsApp,
            child: Ink(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Contact us",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize:
                              getResponsiveFontSize(context, fontSize: 16))),
                  const SizedBox(
                    width: 5,
                  ),
                  Image.asset(
                    "assets/icons/whatsapp.png",
                    height: 30,
                    width: 30,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          /// Copyright Text
          Text(
            '© 2024 Faramawysuez. All Rights Reserved.',
            style:
                TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14),
          ),
        ],
      ),
    );
  }
}
