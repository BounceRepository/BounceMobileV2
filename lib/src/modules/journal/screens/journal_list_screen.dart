import 'package:bounce_patient_app/src/modules/journal/screens/edit_journal_screen.dart';
import 'package:bounce_patient_app/src/modules/journal/widgets/journal_list_item.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_appbar.dart';
import 'package:flutter/material.dart';

class JournalListScreen extends StatelessWidget {
  const JournalListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(label: 'My Journal'),
      body: ListView.builder(
        padding: AppPadding.defaultPadding,
        physics: const BouncingScrollPhysics(),
        itemCount: 30,
        itemBuilder: (context, index) {
          return const JournalListItem();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppNavigator.to(context, const EditJournalScreen());
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
