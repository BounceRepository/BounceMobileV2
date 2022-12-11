import 'package:bounce_patient_app/src/modules/dashboard/screens/dashboard_view.dart';
import 'package:bounce_patient_app/src/modules/journal/controllers/journal_list_controller.dart';
import 'package:bounce_patient_app/src/modules/journal/screens/edit_journal_screen.dart';
import 'package:bounce_patient_app/src/modules/journal/widgets/journal_list_item.dart';
import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_appbar.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_loading_indicator.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/empty_view.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/error_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JournalListScreen extends StatefulWidget {
  const JournalListScreen({super.key});

  @override
  State<JournalListScreen> createState() => _JournalListScreenState();
}

class _JournalListScreenState extends State<JournalListScreen> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getAllJournal();
    });
  }

  void getAllJournal() async {
    final controller = context.read<JournalController>();

    if (controller.journals.isEmpty || controller.failure != null) {
      try {
        setState(() => isLoading = true);
        await controller.getAllJournal();
        setState(() => isLoading = false);
      } on Failure catch (e) {
        setState(() => isLoading = false);
        controller.setFailure(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
       onWillPop: () {
        AppNavigator.to(context, const DashboardView(selectedIndex: 4));
        return Future.value(true);
      },
      child: Scaffold(
        appBar: CustomAppBar(
          label: 'My Journal',
          leading: BackButton(
            onPressed: () {
              AppNavigator.to(context, const DashboardView(selectedIndex: 4));
            },
          ),
        ),
        body: Consumer<JournalController>(
          builder: (context, controller, _) {
            if (isLoading) {
              return const CustomLoadingIndicator();
            }
    
            final error = controller.failure;
            if (error != null) {
              return ErrorScreen(error: error, retry: getAllJournal);
            }
    
            if (controller.journals.isEmpty) {
              return const EmptyListView(
                icon: AppIcons.emptyJournal,
                text: 'You have not made a journal',
              );
            }
    
            final journals = controller.journals.reversed.toList();
            return ListView.builder(
              padding: AppPadding.defaultPadding,
              physics: const BouncingScrollPhysics(),
              itemCount: journals.length,
              itemBuilder: (context, index) {
                final journal = journals[index];
                return JournalListItem(journal);
              },
            );
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
      ),
    );
  }
}
