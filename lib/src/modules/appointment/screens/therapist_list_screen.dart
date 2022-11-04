import 'package:bounce_patient_app/src/modules/appointment/controllers/therapist_list_controller.dart';
import 'package:bounce_patient_app/src/modules/appointment/models/therapist.dart';
import 'package:bounce_patient_app/src/modules/appointment/widgets/therapist_list_item.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_appbar.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_loading_indicator.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/empty_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      getAllTopTherapist();
      getAllTherapistNearYou();
    });
  }

  void getAllTopTherapist() async {
    final controller = context.read<TherapistListController>();

    if (controller.therapists.isEmpty) {
      try {
        await controller.getAllTopTherapist();
      } on Failure catch (e) {
        controller.setFailure(e);
      }
    }
  }

  void getAllTherapistNearYou() async {
    final controller = context.read<TherapistListController>();

    if (controller.therapists.isEmpty) {
      try {
        await controller.getAllTherapistNearYou();
      } on Failure catch (e) {
        controller.setFailure(e);
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

            if (controller.failure != null) {
              // show error view
            }

            if (controller.topTherapists.isEmpty &&
                controller.therapistsNearYou.isEmpty) {
              return const EmptyView();
            }

            return ListView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 20.h),
              children: [
                const _TopTherapistListSection(),
                SizedBox(height: 36.h),
                const _TherapistNearYouListSection(),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _TopTherapistListSection extends StatelessWidget {
  const _TopTherapistListSection();

  @override
  Widget build(BuildContext context) {
    return Consumer<TherapistListController>(
      builder: (context, controller, _) {
        if (controller.topTherapists.isEmpty) {
          return const SizedBox.shrink();
        }

        final therapists = controller.topTherapists;
        return _ListViewSectionView(
          title: 'Top Therapists',
          therapists: therapists,
        );
      },
    );
  }
}

class _TherapistNearYouListSection extends StatelessWidget {
  const _TherapistNearYouListSection();

  @override
  Widget build(BuildContext context) {
    return Consumer<TherapistListController>(
      builder: (context, controller, _) {
        if (controller.therapistsNearYou.isEmpty) {
          return const SizedBox.shrink();
        }

        final therapists = controller.therapistsNearYou;
        return _ListViewSectionView(
          title: 'Therapists Near You',
          therapists: therapists,
        );
      },
    );
  }
}

class _ListViewSectionView extends StatelessWidget {
  const _ListViewSectionView({
    Key? key,
    required this.title,
    required this.therapists,
  }) : super(key: key);

  final String title;
  final List<Therapist> therapists;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: AppPadding.horizontal),
          child: Text(
            title,
            style: AppText.bold500(context).copyWith(
              fontSize: 16.sp,
              color: AppColors.textBrown,
            ),
          ),
        ),
        SizedBox(height: 16.h),
        ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: AppPadding.symetricHorizontalOnly,
          shrinkWrap: true,
          itemCount: therapists.length,
          itemBuilder: (context, index) {
            final therapist = therapists[index];
            return TherapistListItem(therapist);
          },
        ),
      ],
    );
  }
}
