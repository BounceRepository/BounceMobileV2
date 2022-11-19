import 'package:bounce_patient_app/src/modules/journal/controllers/journal_list_controller.dart';
import 'package:bounce_patient_app/src/modules/journal/models/journal.dart';
import 'package:bounce_patient_app/src/shared/helper_functions/helper_functions.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/messenger.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_appbar.dart';
import 'package:bounce_patient_app/src/shared/widgets/input/custom_textfield.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class EditJournalScreen extends StatefulWidget {
  const EditJournalScreen({super.key, this.journal});

  final Journal? journal;

  @override
  State<EditJournalScreen> createState() => _EditJournalScreenState();
}

class _EditJournalScreenState extends State<EditJournalScreen> {
  late final TextEditingController titleController;
  late final TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    final journal = widget.journal;

    if (journal != null) {
      titleController = TextEditingController(text: journal.title);
      contentController = TextEditingController(text: journal.content);
    } else {
      titleController = TextEditingController();
      contentController = TextEditingController();
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  void submit() async {
    if (titleController.text.isNotEmpty || contentController.text.isNotEmpty) {
      try {
        final journal = widget.journal;

        if (journal != null) {
          await update(journal.id);
        } else {
          await create();
        }
      } on Failure catch (e) {
        Messenger.error(message: e.message);
      }
    }
  }

  Future<void> create() async {
    final controller = context.read<JournalController>();
    final journal = Journal(
      id: Utils.getGuid(),
      title: titleController.text,
      content: contentController.text,
      createdAt: DateTime.now(),
    );

    try {
      await controller.create(journal);
      Messenger.success(message: 'Created successfully');
    } on Failure {
      rethrow;
    }
  }

  Future<void> update(String id) async {
    final controller = context.read<JournalController>();
    final journal = Journal(
      id: id,
      title: titleController.text,
      content: contentController.text,
      createdAt: DateTime.now(),
    );

    try {
      await controller.update(journal);
      Messenger.success(message: 'Updated successfully');
    } on Failure {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () {
        submit();
        return Future.value(true);
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: CustomAppBar(
            label: 'My Journal',
            actions: [
              AppBarIcon(
                Icons.check,
                onTap: () {
                  submit();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.journal != null
                    ? Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 20.h, left: 20.w),
                            child: Text(
                              widget.journal!.date,
                              style: AppText.bold500(context).copyWith(
                                fontSize: 10.sp,
                              ),
                            ),
                          ),
                          SizedBox(height: 8.h),
                        ],
                      )
                    : const SizedBox.shrink(),
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    height: size.height,
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
                            textInputType: TextInputType.multiline,
                            maxLines: 2,
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
                            controller: contentController,
                            contentPadding: EdgeInsets.zero,
                            hintText: 'Content',
                            fillColor: Colors.transparent,
                            textInputType: TextInputType.multiline,
                            maxLines: null,
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
      ),
    );
  }
}
