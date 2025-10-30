import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/bloc/background_bloc.dart';
import '../../logic/bloc/background_state.dart';

class AppFooterBar extends StatelessWidget {
  const AppFooterBar({super.key});

  @override
  Widget build(BuildContext context) {
    const double borderRadius = 12;
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: BlocBuilder<BackgroundBloc, BackgroundState>(
          buildWhen: (prev, curr) => prev.config.darkColor != curr.config.darkColor,
          builder: (context, state) {
            final baseColor =Colors.black;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: baseColor.withValues(alpha: 0.5),
                border: const Border(
                  top: BorderSide(color: Colors.white24, width: 1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    'Made by Stefania Mak',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    '|',
                    style: TextStyle(color: Colors.white24, fontSize: 12),
                  ),
                  const SizedBox(width: 8),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    minSize: 0,
                    onPressed: () async {
                      final uri = Uri.parse('https://github.com/stefaniamak/background-generator');
                      await launchUrl(uri, mode: LaunchMode.externalApplication);
                    },
                    child: SvgPicture.asset(
                      'assets/icons/github.svg',
                      width: 18,
                      height: 18,
                      colorFilter: const ColorFilter.mode(Colors.white70, BlendMode.srcIn),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}


