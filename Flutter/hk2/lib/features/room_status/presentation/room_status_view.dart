import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hk2/features/room_status/presentation/header_view.dart';
import 'package:hk2/features/room_status/presentation/rooms_view.dart';

class RoomStatusView extends ConsumerWidget {
  final ScrollController scrollController = ScrollController();

  RoomStatusView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        const contentWidth = 1080.0 - 133.0 - 24.0;
        // const contentWidth = 1080.0;

        final bool isNarrow = screenWidth < contentWidth;
        final double sidePadding = isNarrow ? 24 : (screenWidth - contentWidth) / 2;

        return Scrollbar(
          // thumbVisibility: true,
          controller: scrollController,
          child: SingleChildScrollView(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(width: sidePadding),
                Container(
                  // color: Colors.blueGrey.shade100,
                  constraints: const BoxConstraints(maxWidth: double.infinity),
                  height: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 22.0, horizontal: 16.0),
                  width: contentWidth,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderView(),
                      SizedBox(height: 24.0),
                      RoomsView(),
                    ],
                  ),
                ),
                SizedBox(width: sidePadding),
              ],
            ),
          ),
        );
      },
    );
  }
}