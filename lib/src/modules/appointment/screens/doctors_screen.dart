import 'package:bounce_patient_app/src/modules/appointment/screens/doctor_detail_screen.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_appbar.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_star_rating.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/default_app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TherapistsScreen extends StatelessWidget {
  const TherapistsScreen({Key? key}) : super(key: key);

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
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: AppPadding.defaultPadding,
          itemBuilder: (context, index) {
            return const _DoctorTile();
          },
        ),
      ),
    );
  }
}

class _DoctorTile extends StatelessWidget {
  const _DoctorTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppNavigator.to(context, const DoctorDetailScreen());
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.symmetric(vertical: 15.4.h, horizontal: 14.75.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: const Color(0xffFEF3E7),
        ),
        child: Row(
          children: [
            const DefaultAppImage(),
            SizedBox(width: 17.13.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Alnetta Hooper, PsyD',
                    style: AppText.bold600(context).copyWith(
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    'Psychology • 15 Years Experience',
                    style: AppText.bold400(context).copyWith(
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      const CustomStarRating(),
                      SizedBox(width: 8.w),
                      Text(
                        '976 Reviews',
                        style: AppText.bold500(context).copyWith(
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
