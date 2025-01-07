import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900], // Background color for footer
      padding: const EdgeInsets.all(20), // Padding inside the footer
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// Logo or Website Name
          const Text(
            'MyWebsite',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 10),

          /// Navigation Links
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 15, // Space between items
            children: [
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Home',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'About',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Services',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Contact',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          /// Social Media Links
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.facebook),
                color: Colors.white,
                onPressed: () {
                  // Add Facebook link
                },
              ),
              IconButton(
                icon: const Icon(Icons.facebook),
                color: Colors.white,
                onPressed: () {
                  // Add Twitter link
                },
              ),
              IconButton(
                icon: const Icon(Icons.facebook),
                color: Colors.white,
                onPressed: () {
                  // Add Instagram link
                },
              ),
              IconButton(
                icon: const Icon(Icons.facebook),
                color: Colors.white,
                onPressed: () {
                  // Add LinkedIn link
                },
              ),
            ],
          ),

          const SizedBox(height: 20),

          /// Copyright Text
          Text(
            '© 2024 MyWebsite. All Rights Reserved.',
            style:
                TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14),
          ),
        ],
      ),
    );
  }
}
