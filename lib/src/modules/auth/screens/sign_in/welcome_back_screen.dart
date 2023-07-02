import 'package:bounce_patient_app/src/local/local_storage_service.dart';
import 'package:bounce_patient_app/src/modules/auth/screens/sign_in/sign_in_controller.dart';
import 'package:bounce_patient_app/src/modules/auth/screens/sign_up/create_profile/create_profile_screen.dart';
import 'package:bounce_patient_app/src/modules/auth/screens/sign_up/confirmation/sign_up_confirmation_screen.dart';
import 'package:bounce_patient_app/src/modules/auth/screens/sign_in/sign_in_screen.dart';
import 'package:bounce_patient_app/src/modules/auth/screens/sign_up/sign_up_screen.dart';
import 'package:bounce_patient_app/src/modules/auth/screens/sign_in/components/social_auth_view.dart';
import 'package:bounce_patient_app/src/modules/auth/widgets/auth_body.dart';
import 'package:bounce_patient_app/src/modules/auth/widgets/auth_button.dart';
import 'package:bounce_patient_app/src/modules/auth/widgets/link_text.dart';
import 'package:bounce_patient_app/src/modules/auth/widgets/password_textfield.dart';
import 'package:bounce_patient_app/src/modules/book_session/controllers/session_list_controller.dart';
import 'package:bounce_patient_app/src/modules/chat/controllers/chat_controller.dart';
import 'package:bounce_patient_app/src/modules/dashboard/screens/select_mood_screen.dart';
import 'package:bounce_patient_app/src/modules/feed/controllers/feed_controller.dart';
import 'package:bounce_patient_app/src/modules/journal/controllers/journal_list_controller.dart';
import 'package:bounce_patient_app/src/modules/notifications/controllers/notification_controller.dart';
import 'package:bounce_patient_app/src/modules/playlist/controllers/song_list_controller.dart';
import 'package:bounce_patient_app/src/modules/wallet/controllers/transaction_list_controller.dart';
import 'package:bounce_patient_app/src/shared/assets/icons.dart';
import 'package:bounce_patient_app/src/shared/models/app_session.dart';
import 'package:bounce_patient_app/src/shared/models/failure.dart';
import 'package:bounce_patient_app/src/shared/models/user.dart';
import 'package:bounce_patient_app/src/shared/styles/colors.dart';
import 'package:bounce_patient_app/src/shared/styles/text.dart';
import 'package:bounce_patient_app/src/shared/utils/messenger.dart';
import 'package:bounce_patient_app/src/shared/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class WelcomeBackScreen extends StatefulWidget {
  const WelcomeBackScreen({
    super.key,
    required this.userName,
    required this.email,
  });

  final String userName;
  final String email;

  @override
  State<WelcomeBackScreen> createState() => _WelcomeBackScreenState();
}

class _WelcomeBackScreenState extends State<WelcomeBackScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  void submit() async {
    if (_formKey.currentState!.validate()) {
      try {
        await context.read<SignInController>().execute(
              username: widget.email,
              password: passwordController.text,
            );

        if (mounted) {
          Messenger.success(message: 'Login successful');
          AppNavigator.removeAllUntil(context, const SelectMoodsScreen());
        }
      } on Failure catch (e) {
        final user = AppSession.user;

        if (user != null) {
          if (e is InCompleteProfileFailure) {
            AppNavigator.to(
              context,
              CreateProfileScreen(
                email: user.email,
                userName: user.userName,
                nextScreen: const SelectMoodsScreen(),
              ),
            );
            return;
          }

          if (e is ConfirmEmailFailure) {
            verifyEmail(user);
            return;
          }
        }
        Messenger.error(message: e.message);
      }
    }
  }

  void verifyEmail(User user) async {
    try {
      await context.read<SignInController>().verifyEmail(email: user.email);

      if (mounted) {
        AppNavigator.to(
          context,
          SignUpConfirmationScreen(
            email: user.email,
            userName: user.userName,
            nextScreen: const SelectMoodsScreen(),
          ),
        );
      }
    } on Failure catch (e) {
      Messenger.error(message: e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();
        return Future.value(true);
      },
      child: Form(
        key: _formKey,
        child: AuthBody(
          children: [
            SvgPicture.asset(
              AuthIcons.welcome,
              width: 159.53.w,
              height: 182.h,
            ),
            SizedBox(height: 50.h),
            Text(
              'Welcome Back, ${widget.userName}',
              textAlign: TextAlign.center,
              style: AppText.bold700(context).copyWith(
                fontSize: 24.sp,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Please enter your password',
              style: AppText.bold400(context),
            ),
            SizedBox(height: 20.h),
            PasswordTextField(
              controller: passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            SizedBox(height: 22.h),
            LinkText(
              text1: 'Not You?',
              text2: 'Switch Account',
              onClick: () {
                context.read<NotificationController>().clear();
                context.read<JournalController>().clear();
                context.read<MyFeedController>().clear();
                context.read<ChatController>().clear();
                context.read<SessionListController>().clear();
                context.read<TransactionListController>().clear();
                context.read<SongListController>().clear();
                LocalStorageService.clear();
                AppNavigator.removeAllUntil(context, const SignInScreen());
              },
            ),
            SizedBox(height: 19.h),
            Consumer<SignInController>(
              builder: (context, controller, _) {
                return AuthButton(
                  label: 'Sign In',
                  isLoading: controller.isBusy,
                  onTap: submit,
                );
              },
            ),
            SizedBox(height: 39.h),
            const SocialAuthView(),
            SizedBox(height: 39.h),
            LinkText(
              text1: 'Don’t have an account?',
              text2: 'Sign Up',
              fontSize: 12.sp,
              onClick: () {
                AppNavigator.to(context, const SignUpScreen());
              },
            ),
            SizedBox(height: 39.h),
          ],
        ),
      ),
    );
  }
}
