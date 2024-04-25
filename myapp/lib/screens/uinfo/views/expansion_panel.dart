import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';

class AccordionApp extends StatelessWidget {
  const AccordionApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AccordionPage(),
      debugShowCheckedModeBanner: false
    );
  }
}

class AccordionPage extends StatelessWidget {
  static const headerStyle = TextStyle(
    color: Color(0xffffffff),
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const contentStyleHeader = TextStyle(
    color: Color(0xff999999),
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  static const contentStyle = TextStyle(
    color: Color(0xffffa500), // Orange color
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  static const loremIpsum =
      '''Lorem ipsum is typically a corrupted version of 'De finibus bonorum et malorum', a 1st century BC text by the Roman statesman and philosopher Cicero, with words altered, added, and removed to make it nonsensical and improper Latin.''';

  const AccordionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Get the current theme

    return Scaffold(
      backgroundColor: Colors.white,
      body: Accordion(
        headerBorderColor: Colors.blueGrey,
        headerBorderColorOpened: Color(0xFFFFE7C4),
        headerBackgroundColor: Colors.white, // Initially set to purple
        headerBackgroundColorOpened: Color(0xFFFFE7C4), // Change to green when opened
        contentBackgroundColor: Color(0xFFFFE7C4),
        contentBorderColor: Colors.black,
        contentBorderWidth: 0,
        contentHorizontalPadding: 20,
        scaleWhenAnimating: true,
        openAndCloseAnimation: true,
        headerPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
        sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
        sectionClosingHapticFeedback: SectionHapticFeedback.light,
        children: [
          AccordionSection(
            isOpen: true,
            contentVerticalPadding: 20,
            leftIcon: null, // Remove the icon
            header: Text(
              'Agreement',
              style: theme.textTheme.titleMedium!, // Use theme style
            ),
            content: Text(loremIpsum, style: theme.textTheme.bodyMedium!),
          ),
          AccordionSection(
            isOpen: true,
            contentVerticalPadding: 20,
            leftIcon: null,
            header: Text(
              'Faculty',
              style: theme.textTheme.titleMedium!, // Use theme style
            ),
            content: Text(loremIpsum, style: theme.textTheme.bodyMedium!),
          ),
          AccordionSection(
            isOpen: true,
            contentVerticalPadding: 20,
            leftIcon: null,
            header: Text(
              'Academic Program',
              style: theme.textTheme.titleMedium!, // Use theme style
            ),
            content: Text(loremIpsum, style: theme.textTheme.bodyMedium!),
          ),
          AccordionSection(
            isOpen: true,
            contentVerticalPadding: 20,
            leftIcon: null,
            header: Text(
              'Fees',
              style: theme.textTheme.titleMedium!, // Use theme style
            ),
            content: Text(loremIpsum, style: theme.textTheme.bodyMedium!),
          ),
          AccordionSection(
            isOpen: true,
            contentVerticalPadding: 20,
            leftIcon: null,
            header: Text(
              'Content',
              style: theme.textTheme.titleMedium!, // Use theme style
            ),
            content: Text(loremIpsum, style: theme.textTheme.bodyMedium!),
          ),
        ],
      ),
    );
  }
}