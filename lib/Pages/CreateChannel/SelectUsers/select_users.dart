import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SelectUsers extends StatelessWidget {
  const SelectUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
              child: Column(
            children: [
              const SizedBox(height: 20),
              const Text("Select Users"),
              const SizedBox(height: 20),
              const Text("User 1"),
              const SizedBox(height: 20),
              const Text("User 2"),
              const SizedBox(height: 20),
              const Text("User 3"),
              const SizedBox(height: 20),
              const Text("User 4"),
              const SizedBox(height: 20),
              const Text("User 5"),
              const SizedBox(height: 20),
              const Text("User 6"),
              const SizedBox(height: 20),
              const Text("User 7"),
              const SizedBox(height: 20),
              const Text("User 8"),
              const SizedBox(height: 20),
              const Text("User 9"),
              const SizedBox(height: 20),
              const Text("User 10"),
              const SizedBox(height: 20),
              const Text("User 11"),
              const SizedBox(height: 20),
              const Text("User 12"),
              const SizedBox(height: 20),
              const Text("User 13"),
              const SizedBox(height: 20),
              const Text("User 14"),
              const SizedBox(height: 20),
              const Text("User 15"),
              const SizedBox(height: 20),
              const Text("User 16"),
              const SizedBox(height: 20),
              const Text("User 17"),
              const SizedBox(height: 20),
              const Text("User 18"),
              const SizedBox(height: 20),
              const Text("User 19"),
              const SizedBox(height: 20),
              const Text("User 20"),
              const SizedBox(height: 20),
            ],
          )),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text("Create Channel"),
        )
      ],
    );
  }
}
