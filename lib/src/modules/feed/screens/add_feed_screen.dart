import 'package:bounce_patient_app/src/modules/dashboard/screens/dashboard_view.dart';
import 'package:bounce_patient_app/src/modules/feed/controllers/feed_controller.dart';
import 'package:bounce_patient_app/src/modules/feed/models/feed.dart';
import 'package:bounce_patient_app/src/shared/models/app_session.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/messenger.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:bounce_patient_app/src/shared/widgets/appbars/custom_appbar.dart';
import 'package:bounce_patient_app/src/shared/widgets/bottomsheet/custom_bottomsheet.dart';
import 'package:bounce_patient_app/src/shared/widgets/buttons/app_button.dart';
import 'package:bounce_patient_app/src/shared/widgets/input/custom_textfield.dart';
import 'package:bounce_patient_app/src/shared/widgets/others/default_app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddFeedScreen<T extends FeedController> extends StatefulWidget {
  const AddFeedScreen({super.key});

  @override
  State<AddFeedScreen<T>> createState() => _AddFeedScreenState<T>();
}

class _AddFeedScreenState<T extends FeedController> extends State<AddFeedScreen<T>> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController messageController;

  @override
  void initState() {
    super.initState();
    messageController = TextEditingController();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void send() async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();

      final controller = context.read<T>();
      final selectedFeedGroup = controller.selectedFeedGroup;

      if (selectedFeedGroup == null) {
        return;
      }

      try {
        await controller.create(
          message: messageController.text,
          feedGroupId: selectedFeedGroup.id,
        );
        AppNavigator.to(
            context,
            DashboardView(
              selectedIndex: 3,
              feedInitialIndex: selectedFeedGroup.tabIndex,
            ));
        worker();
        Messenger.success(message: 'New message added successfully');
      } on Failure catch (e) {
        Messenger.error(message: e.message);
      }
    }
  }

  void worker() async {
    final controller = context.read<T>();

    try {
      await controller.getFeedList();
    } on Failure catch (e) {
      Messenger.error(message: e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = AppSession.user;

    if (user == null) {
      return const SizedBox.shrink();
    }

    final userProfilePicture = user.image;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ChooseGroupSection<T>(),
                SizedBox(height: 20.h),
                CustomTextField(
                  controller: messageController,
                  hintText: 'What is wrong?',
                  filled: false,
                  textInputType: TextInputType.multiline,
                  maxLines: null,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: AppPadding.horizontal, vertical: 14.h),
          child: Row(
            children: [
              userProfilePicture != null
                  ? CustomCacheNetworkImage(image: userProfilePicture, size: 48.h)
                  : DefaultAppImage(size: 48.h),
              SizedBox(width: 12.w),
              Expanded(
                child: Consumer<T>(
                  builder: (context, controller, _) {
                    return AppButton(
                      label: 'Send',
                      isLoading: controller.isLoading,
                      onTap: send,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChooseGroupSection<T extends FeedController> extends StatefulWidget {
  const _ChooseGroupSection();

  @override
  State<_ChooseGroupSection<T>> createState() => _ChooseGroupSectionState<T>();
}

class _ChooseGroupSectionState<T extends FeedController>
    extends State<_ChooseGroupSection<T>> {
  String label = 'Choose Group';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final controller = context.read<T>();
        final result = await _chooseGroupBottomsheet(
          context: context,
          selectedFeedGroup: controller.selectedFeedGroup,
        );

        if (result != null) {
          final feedGroup = result as FeedGroup;
          label = feedGroup.name;
          controller.selectedFeedGroup = feedGroup;
          setState(() {});
        }
      },
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        width: 135.w,
        margin: EdgeInsets.only(left: AppPadding.horizontal),
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: AppText.bold500(context).copyWith(
                  fontSize: 12.sp,
                  color: AppColors.primary,
                ),
              ),
            ),
            SizedBox(width: 5.w),
            Icon(
              Icons.keyboard_arrow_down_outlined,
              color: AppColors.primary,
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }
}

Future<dynamic> _chooseGroupBottomsheet({
  required BuildContext context,
  required FeedGroup? selectedFeedGroup,
}) {
  return showCustomBottomSheet(context,
      body: _ChooseGroupView(selectedFeedGroup: selectedFeedGroup));
}

class _ChooseGroupView extends StatefulWidget {
  const _ChooseGroupView({required this.selectedFeedGroup});

  final FeedGroup? selectedFeedGroup;

  @override
  State<_ChooseGroupView> createState() => _ChooseGroupViewState();
}

class _ChooseGroupViewState extends State<_ChooseGroupView> {
  FeedGroup? selectedFeedGroup;

  @override
  void initState() {
    super.initState();
    selectedFeedGroup = widget.selectedFeedGroup;
  }

  void select(FeedGroup feedGroup) {
    selectedFeedGroup = feedGroup;
    Navigator.pop(context, selectedFeedGroup);
  }

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheetBody(
      body: [
        const BottomSheetDragger(),
        SizedBox(height: 5.h),
        const BottomSheetTitle('Choose Group'),
        SizedBox(height: 30.h),
        Column(
          children: List.generate(feedGroups.length, (index) {
            final feedGroup = feedGroups[index];
            return tile(
              label: feedGroup.name,
              isSelected: selectedFeedGroup == feedGroup,
              onTap: () => select(feedGroup),
            );
          }),
        ),
        SizedBox(height: 50.h),
      ],
    );
  }

  Widget tile({
    required String label,
    required bool isSelected,
    required Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: AppColors.primary,
              size: 20.sp,
            ),
            SizedBox(width: 26.4.w),
            Text(
              label,
              style: AppText.bold300(context).copyWith(
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
