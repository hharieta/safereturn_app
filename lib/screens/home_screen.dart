import 'package:flutter/material.dart';
import 'package:safereturn/utils/utils.dart';
import 'package:gap/gap.dart';
import 'package:safereturn/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final deviceSize = context.deviceSize;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: deviceSize.height * 0.3,
                width: deviceSize.width,
                color: colors.primary,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DisplayWhiteText(
                      text: 'Welcome to',
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                    Gap(10),
                    DisplayWhiteText(
                      text: 'SafeReturn',
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: deviceSize.width,
                  color: colors.surface,
                ),
              ),
            ],
          ),
          const Positioned(
            top: 120,
            left: 0,
            right: 0,
            child: SafeArea(
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
