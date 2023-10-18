// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:care_betes/app/core/extensions/size_extension.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CommonScaffold extends StatefulWidget {
  CommonScaffold({
    Key? key,
    this.appbar,
    required this.body,
    this.scroll,
    this.padding,
    this.scaffoldKey,
    this.isFloatingActionButton = false,
    this.height,
  }) : super(key: key);

  final PreferredSizeWidget? appbar;
  final Widget body;
  final ScrollPhysics? scroll;
  final EdgeInsetsGeometry? padding;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  bool isFloatingActionButton;
  double? height;

  @override
  State<CommonScaffold> createState() => _CommonScaffoldState();
}

class _CommonScaffoldState extends State<CommonScaffold>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: widget.scaffoldKey,
        appBar: widget.appbar,
        backgroundColor: const Color(0XFF7EA1C1),
        body: SingleChildScrollView(
          physics: widget.scroll ?? const NeverScrollableScrollPhysics(),
          child: Container(
            width: context.screenWidth,
            height: widget.height,
            padding: widget.padding,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0XFF7EA1C1),
                  Color(0XFF99B4CE),
                  Color(0XFFE3EAF0),
                ],
              ),
            ),
            child: widget.body,
          ),
        ),
        floatingActionButton: widget.isFloatingActionButton
            ? FloatingActionBubble(
                // Menu items
                items: <Bubble>[
                  Bubble(
                    title: "Nova Consulta",
                    iconColor: Colors.white,
                    bubbleColor: const Color(0XFF7EA1C1),
                    icon: Icons.medical_services_rounded,
                    titleStyle:
                        const TextStyle(fontSize: 16, color: Colors.white),
                    onPress: () async {
                      _animationController.reverse();

                      Modular.to.pushNamed('register_medical_appointment');
                    },
                  ),
                  Bubble(
                    title: "Novo Medicamento",
                    iconColor: Colors.white,
                    bubbleColor: const Color(0XFF7EA1C1),
                    icon: Icons.medication,
                    titleStyle:
                        const TextStyle(fontSize: 16, color: Colors.white),
                    onPress: () async {
                      _animationController.reverse();

                      Modular.to.pushNamed('register_medication');
                    },
                  ),
                ],

                // animation controller
                animation: _animation,

                // On pressed change animation state
                onPress: () => _animationController.isCompleted
                    ? _animationController.reverse()
                    : _animationController.forward(),
                iconColor: Colors.white,
                iconData: Icons.add,
                backGroundColor: const Color(0XFF7EA1C1),
              )
            : null,
      ),
    );
  }
}
