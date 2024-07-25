import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
//import 'package:goalkit/l10n/localization_provider.dart';
import 'package:goalkit/resources/managers/string_manager.dart';
import 'package:goalkit/resources/managers/styles_manager.dart';


class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringManager.lang),
        centerTitle: true,
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Gap(40),
              GestureDetector(
                onTap: () {
                  //Provider.of<LocalizationProvider>(context, listen: false).setLocale(Locale('en'));
                  Navigator.pop(context);
                },
                child: const Text(
                  StringManager.eng,
                  style: AppTextStyle.bodyStyle18,
                ),
              ),
              const Gap(20),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  StringManager.hin,
                  style: AppTextStyle.bodyStyle18,
                ),
              ),
              const Gap(20),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  StringManager.french,
                  style: AppTextStyle.bodyStyle18,
                ),
              ),
              const Gap(20),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  StringManager.spanish,
                  style: AppTextStyle.bodyStyle18,
                ),
              ),
              const Gap(20),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  StringManager.arab,
                  style: AppTextStyle.bodyStyle18,
                ),
              ),
            ],
          )),
    );
  }
}
