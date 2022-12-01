import 'package:bounce_patient_app/src/modules/auth/controllers/health_level_controller.dart';
import 'package:bounce_patient_app/src/shared/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:bounce_patient_app/src/shared/widgets/bottomsheet/select_location_bottomsheet.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

Future<dynamic> showHealthLevelBottomsheet<T extends HealthLevelController>({
  required BuildContext context,
}) {
  return showCustomBottomSheet(
    context,
    body: _Body<T>(),
  );
}

class _Body<T extends HealthLevelController> extends StatefulWidget {
  const _Body();

  @override
  State<_Body<T>> createState() => _BodyState<T>();
}

class _BodyState<T extends HealthLevelController> extends State<_Body<T>> {
  @override
  void initState() {
    context.read<T>().init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheetBody(
      height: 400.h,
      body: [
        const BottomSheetDragger(),
        SizedBox(height: 30.h),
        SizedBox(
          height: 220.h,
          child: _OptionListView<T>(),
        ),
        SizedBox(height: 24.h),
        AppButton(
          label: 'Done',
          onTap: () {
            final selectedHealthLevel = context.read<T>().selectedHealthLevel;

            if (selectedHealthLevel != null) {
              Navigator.pop(context, selectedHealthLevel.title);
            } else {
              Navigator.pop(context);
            }
          },
        ),
        SizedBox(height: 40.h),
      ],
    );
  }
}

class _OptionListView<T extends HealthLevelController> extends StatelessWidget {
  const _OptionListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
      builder: (context, controller, _) {
        final levels = controller.healthLevelList;

        return Scrollbar(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: List.generate(levels.length, (index) {
              final healthLevel = levels[index];

              return InkWell(
                onTap: () => controller.select(healthLevel),
                child: OptionTile(
                  isSelected: healthLevel.isSelected,
                  title: healthLevel.title,
                  onChanged: (value) => controller.select(healthLevel),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
