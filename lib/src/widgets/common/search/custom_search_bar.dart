import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:stud_advice/src/controllers/search/custom_search_controller.dart';
import 'package:stud_advice/stud_advice.dart';

class CustomSearchBar extends StatelessWidget {
  final CustomSearchController controller;
  final String hintText;
  final stt.SpeechToText _speech = stt.SpeechToText();

  CustomSearchBar(
      {super.key, required this.controller, required this.hintText});

  void _startListening() async {
    bool available = await _speech.initialize(
      onStatus: (val) => debugPrint('onStatus: $val'),
      onError: (val) => debugPrint('onError: $val'),
    );

    if (available) {
      _speech.listen(
        onResult: (val) {
          controller.textEditingController.text = val.recognizedWords;
          controller.update();
          _speech.stop();
        },
      );
    } else {
      debugPrint("The user has denied the use of speech recognition.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return
      ClassicTextField(
      onChanged: (value) {
        controller.change();
      },
      controller: controller.textEditingController,
      hintText: hintText,
      backgroundColor: Colors.transparent,
      borderColor: AppColors.primaryColor,
      focusedBorderColor: AppColors.primaryColor,
      inputDecoration: InputDecoration(
        focusColor: AppColors.primaryColor,
        prefixIcon: const Icon(
          Icons.search,
          color: AppColors.primaryColor,
          size: 26,
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            _startListening();
          },
          child: const Icon(
            Icons.mic,
            color: AppColors.primaryColor,
            size: 26,
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelText: hintText,
        labelStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Theme.of(context).canvasColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(90),
          borderSide: const BorderSide(color: AppColors.primaryColor),
        ),
        isDense: true,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(40),
        ),
      ),
    );
  }
}
