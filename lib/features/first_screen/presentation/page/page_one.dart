import 'package:flutter/material.dart';
import 'package:km_test/features/first_screen/presentation/widgets/custom_dialog.dart';
import 'package:km_test/features/first_screen/presentation/widgets/custom_input_field.dart';
import 'package:km_test/core/bases/widgets/primary_button.dart';

import '../../../../core/constants/assets.dart';
import '../../../second_screen/presentation/page/page_two.dart';

class PageOne extends StatefulWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _palindrome = TextEditingController();

  @override
  void dispose() {
    _username.dispose();
    _palindrome.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.background),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32),
          child: ListView(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.18),
              Image.asset(Assets.profileIcon, height: 116),
              const SizedBox(height: 64),
              CustomInputField(controller: _username, hintText: "Name"),
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),
              CustomInputField(controller: _palindrome, hintText: "Palindrome"),
              SizedBox(height: MediaQuery.of(context).size.height * 0.075),
              PrimaryButton(
                  text: "CHECK",
                  onPressed: () {
                    // show dialog
                    String text = _palindrome.text;
                    if (text.isEmpty) {
                      _showDialog("Palindrome field is empty");
                      return;
                    }
                    _showDialog(isPanlindrome(text)
                        ? "$text is a Palindrome"
                        : "$text is not a Palindrome");
                  }),
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),
              PrimaryButton(
                  text: "NEXT",
                  onPressed: () {
                    String username = _username.text;
                    if (username.isEmpty) {
                      _showDialog("Username field is empty");
                      return;
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PageTwo(
                                  username: username,
                                )));
                  }),
            ],
          ),
        ),
      ),
    );
  }

  bool isPanlindrome(String input) {
    return input == input.split('').reversed.join();
  }

  Future<void> _showDialog(String content) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => CustomDialog(
        content: content,
      ),
    );
  }
}
