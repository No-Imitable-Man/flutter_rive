import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rive/rive_app/theme.dart';
import 'package:rive/rive.dart' hide LinearGradient;

class SignInView extends StatefulWidget {
  const SignInView({super.key, this.clodeModal});

  final Function? clodeModal;

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  late SMITrigger _successAnim;
  late SMITrigger _errorAnim;
  late SMITrigger _confettiAnim;

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  void _onCheckRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(
      artboard,
      "State Machine 1",
    );
    artboard.addController(controller!);
    _successAnim = controller.findInput<bool>("Check") as SMITrigger;
    _errorAnim = controller.findInput<bool>("Error") as SMITrigger;
  }

  void _onConfettiRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(
      artboard,
      "State Machine 1",
    );
    artboard.addController(controller!);
    _confettiAnim =
        controller.findInput<bool>("Trigger explosion") as SMITrigger;
  }

  void login() {
    setState(() {
      _isLoading = true;
    });

    bool isEmailValid = _emailController.text.trim().isNotEmpty;
    bool isPassValid = _passController.text.trim().isNotEmpty;
    bool isValid = isEmailValid && isPassValid;

    Future.delayed(const Duration(seconds: 1), () {
      isValid ? _successAnim.fire() : _errorAnim.fire();
    });

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
      if (isValid) _confettiAnim.fire();
    });

    if (isValid) {
      Future.delayed(const Duration(seconds: 4), () {
        widget.clodeModal!();
        _emailController.text = "";
        _passController.text = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Stack(
              children: [
                Container(
                  constraints: const BoxConstraints(maxWidth: 600),
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [Colors.white.withOpacity(0.8), Colors.white10],
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(29),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: RiveAppTheme.shadow.withOpacity(0.3),
                          offset: Offset(0, 3),
                          blurRadius: 5,
                        ),
                        BoxShadow(
                          color: RiveAppTheme.shadow.withOpacity(0.3),
                          offset: const Offset(0, 30),
                          blurRadius: 30,
                        ),
                      ],
                      color: CupertinoColors.secondarySystemBackground,
                      backgroundBlendMode: BlendMode.luminosity,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Sign In",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          "Access to 240+ hours of content. Learn design and code, by building real apps with React and Swift.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Email",
                            style: TextStyle(
                              color: CupertinoColors.secondaryLabel,
                              fontFamily: "Poppins",
                              fontSize: 15,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          decoration: authInputStyle("icon_email"),
                          controller: _emailController,
                        ),
                        const SizedBox(height: 24),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Password",
                            style: TextStyle(
                              color: CupertinoColors.secondaryLabel,
                              fontFamily: "Poppins",
                              fontSize: 15,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          obscureText: true,
                          decoration: authInputStyle("icon_lock"),
                          controller: _passController,
                        ),
                        const SizedBox(height: 24),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFF77D8E).withOpacity(0.5),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: CupertinoButton(
                            padding: const EdgeInsets.all(20),
                            color: Color(0xFFF77D8E),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "Sign In",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () {
                              if (!_isLoading) login();
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: Row(
                            children: [
                              const Expanded(child: Divider()),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: Text(
                                  "OR",
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.3),
                                    fontSize: 15,
                                    fontFamily: "Poppins",
                                  ),
                                ),
                              ),
                              const Expanded(child: Divider()),
                            ],
                          ),
                        ),
                        const Text(
                          "Sign up with Email, Apple or Google",
                          style: TextStyle(
                            color: CupertinoColors.secondaryLabel,
                            fontFamily: "Poppins",
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              "assets/rive_app/images/logo_email.png",
                            ),
                            Image.asset(
                              "assets/rive_app/images/logo_apple.png",
                            ),
                            Image.asset(
                              "assets/rive_app/images/logo_google.png",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                Positioned.fill(
                  child: IgnorePointer(
                    ignoring: true,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if (_isLoading)
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: RiveAnimation.asset(
                              "assets/rive_app/rive/check.riv",
                              onInit: _onCheckRiveInit,
                            ),
                          ),
                        Positioned.fill(
                          child: SizedBox(
                            width: 500,
                            height: 500,
                            child: Transform.scale(
                              scale: 3,
                              child: RiveAnimation.asset(
                                "assets/rive_app/rive/confetti.riv",
                                onInit: _onConfettiRiveInit,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Align(
                    alignment: Alignment.center,
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      borderRadius: BorderRadius.circular(36 / 2),
                      minSize: 36,
                      color: Colors.red,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(36 / 2),
                          boxShadow: [
                            BoxShadow(
                              color: RiveAppTheme.shadow.withOpacity(0.3),
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.close, color: Colors.black),
                      ),
                      onPressed: () {
                        widget.clodeModal!();
                      },
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

InputDecoration authInputStyle(String iconName) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.white,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.black.withOpacity(0.1)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.black.withOpacity(0.1)),
    ),
    prefixIcon: Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Image.asset("assets/rive_app/images/$iconName.png"),
    ),
  );
}
