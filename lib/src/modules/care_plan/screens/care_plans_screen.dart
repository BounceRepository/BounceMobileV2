import 'package:bounce_patient_app/src/modules/care_plan/controllers/care_plan_controller.dart';
import 'package:bounce_patient_app/src/modules/care_plan/models/plan.dart';
import 'package:bounce_patient_app/src/modules/care_plan/screens/care_plan_bottomsheet.dart';
import 'package:bounce_patient_app/src/modules/care_plan/widgets/package_list_view.dart';
import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_appbar.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/app_button.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_child_scrollview.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_loading_indicator.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/empty_view.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CarePlansScreen extends StatefulWidget {
  const CarePlansScreen({super.key});

  @override
  State<CarePlansScreen> createState() => _CarePlansScreenState();
}

class _CarePlansScreenState extends State<CarePlansScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getAllPlan();
    });
  }

  void getAllPlan() async {
    final controller = context.read<CarePlanController>();

    if (controller.plans.isEmpty || controller.failure != null) {
      try {
        await controller.getAllPlan();
      } on Failure catch (e) {
        controller.setFailure(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(label: 'My Care Plans'),
      body: Consumer<CarePlanController>(
        builder: (context, controller, _) {
          if (controller.isBusy) {
            return const CustomLoadingIndicator();
          }

          final error = controller.failure;
          if (error != null) {
            return ErrorScreen(error: error, retry: getAllPlan);
          }

          if (controller.plans.isEmpty) {
            return const EmptyListView();
          }

          final plans = controller.plans;
          return CustomChildScrollView(
            child: Wrap(
              runSpacing: 28.h,
              children: List.generate(plans.length, (index) {
                final plan = plans[index];
                return PlanCard(plan);
              }),
            ),
          );
        },
      ),
    );
  }
}

class PlanCard extends StatelessWidget {
  const PlanCard(this.plan, {super.key});

  final Plan plan;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: 12.h, bottom: 8.h),
          decoration: BoxDecoration(
            color: AppColors.lightVersion,
            boxShadow: AppColors.boxshadow4,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 48.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plan.title,
                      style: AppText.bold600(context).copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    SubscriptionPackageListView(plan.subPlans.first),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 40.h,
                  width: 120.w,
                  child: AppButton(
                    label: 'View Pricing',
                    labelColor: AppColors.lightVersion,
                    backgroundColor: plan.color,
                    padding: EdgeInsets.symmetric(horizontal: 17.w),
                    borderRadius: BorderRadius.circular(20.r),
                    onTap: () {
                      showCarePlanBottomsheet(context: context, plan: plan);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(8.r)),
          child: SvgPicture.asset(
            AppIcons.triangle,
            width: 52.w,
            height: 48.h,
            fit: BoxFit.cover,
            color: plan.color,
          ),
        ),
      ],
    );
  }
}
