import 'package:bounce_patient_app/src/shared/styles/spacing.dart';
import 'package:flutter/material.dart';

class CustomChildScrollView extends StatelessWidget {
  const CustomChildScrollView({
    Key? key,
    required this.child,
    this.padding,
    this.controller,
  }) : super(key: key);

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller,
      physics: const BouncingScrollPhysics(),
      padding: padding ?? AppPadding.defaultPadding,
      child: child,
    );
  }
}

class ScrollToBottomListenerWidget extends StatefulWidget {
  const ScrollToBottomListenerWidget({
    super.key,
    required this.child,
    this.padding,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  State<ScrollToBottomListenerWidget> createState() =>
      _ScrollToBottomListenerWidgetState();
}

class _ScrollToBottomListenerWidgetState extends State<ScrollToBottomListenerWidget> {
  late final ScrollController scrollController;
  bool showFloatingbutton = true;

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      double showoffset = 0.0; //Back to top botton will show on scroll offset 10.0

      if (scrollController.offset > showoffset) {
        showFloatingbutton = false;
        setState(() {});
      } else {
        showFloatingbutton = true;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void scrollToBottom() {
    if (scrollController.hasClients) {
      final position = scrollController.position.maxScrollExtent;
      scrollController.animateTo(
        position,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomChildScrollView(
        controller: scrollController,
        padding: widget.padding,
        child: widget.child,
      ),
      floatingActionButton: showFloatingbutton
          ? FloatingActionButton(
              onPressed: scrollToBottom,
              child: const Icon(
                Icons.arrow_downward_outlined,
                color: Colors.white,
              ),
            )
          : null,
    );
  }
}
