import 'package:bounce_patient_app/src/modules/appointment/controllers/therapist_list_controller.dart';
import 'package:bounce_patient_app/src/modules/appointment/widgets/therapist_list_item.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/utils/notification_message.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_appbar.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_loading_indicator.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/empty_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TherapistListScreen extends StatefulWidget {
  const TherapistListScreen({Key? key}) : super(key: key);

  @override
  State<TherapistListScreen> createState() => _TherapistListScreenState();
}

class _TherapistListScreenState extends State<TherapistListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAllTherapist();
    });
  }

  void getAllTherapist() async {
    final controller = context.read<TherapistListController>();

    if (controller.therapists.isEmpty) {
      try {
        await controller.getAllTherapist();
      } on Failure catch (e) {
        Messenger.showError(context, message: e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        automaticallyImplyLeading: false,
        label: 'Therapists',
        centerTitle: false,
        removeActionsPadding: true,
        actions: [
          SearchButton(
            onTap: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Consumer<TherapistListController>(
          builder: (context, controller, _) {
            if (controller.isLoading) {
              return const CustomLoadingIndicator();
            }

            if (controller.therapists.isEmpty) {
              return const EmptyView();
            }

            final therapists = controller.therapists;
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: AppPadding.defaultPadding,
              itemCount: therapists.length,
              itemBuilder: (context, index) {
                final therapist = therapists[index];
                return TherapistListItem(therapist);
              },
            );
          },
        ),
      ),
    );
  }
}
