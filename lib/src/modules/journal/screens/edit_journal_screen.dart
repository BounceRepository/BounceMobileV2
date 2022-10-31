import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_appbar.dart';
import 'package:bounce_patient_app/src/shared/widgets/input/custom_textfield.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditJournalScreen extends StatefulWidget {
  const EditJournalScreen({super.key});

  @override
  State<EditJournalScreen> createState() => _EditJournalScreenState();
}

class _EditJournalScreenState extends State<EditJournalScreen> {
  late final TextEditingController titleController;
  late final TextEditingController bodyTextController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    bodyTextController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    bodyTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(
        label: 'My Journal',
        actions: [
          AppBarIcon(
            Icons.check,
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20.h, left: 20.w),
                child: Text(
                  'October 17, 2022 10:17PM',
                  style: AppText.bold500(context).copyWith(
                    fontSize: 10.sp,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 28.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.r),
                      topRight: Radius.circular(12.r),
                    ),
                    color: const Color(0xffFCE7D8).withOpacity(.4),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: AppPadding.horizontal,
                          right: AppPadding.horizontal,
                          bottom: 20.h,
                        ),
                        child: CustomTextField(
                          controller: titleController,
                          hintText: 'Title',
                          fontSize: 18.sp,
                          contentPadding: EdgeInsets.zero,
                          fillColor: Colors.transparent,
                        ),
                      ),
                      const CustomDivider(),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 34.h,
                          left: AppPadding.horizontal,
                          right: AppPadding.horizontal,
                        ),
                        child: CustomTextField(
                          controller: bodyTextController,
                          contentPadding: EdgeInsets.zero,
                          fillColor: Colors.transparent,
                          maxLines: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
