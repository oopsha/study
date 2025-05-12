import 'package:flutter/material.dart';

class HeaderItem extends StatefulWidget {
  final String title;
  final Color color;

  const HeaderItem({
    super.key,
    required this.title,
    required this.color,
  });

  @override
  State<HeaderItem> createState() => _HeaderItemState();
}

class _HeaderItemState extends State<HeaderItem> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHovering = true),
      onExit: (_) => setState(() => isHovering = false),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              offset: const Offset(1.0, 1.0),
              blurRadius: 3.0,
            ),
          ],
          color: Colors.white,
        ),
        height: 72,
        width: 133,
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: isHovering ? 36 : 26,
                  height: 72,
                  decoration: BoxDecoration(
                    color: widget.color,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                    ),
                  ),
                ),
                const Expanded(
                  child: SizedBox.shrink(),
                )
              ]
            ),
            Positioned(
              left: 50.0,
              top: 8.0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: EdgeInsets.only(left: isHovering ?  6.0 : 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title),
                    const SizedBox(height: 4.0),
                    const Text('103', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
                  ],
                )
              ),
            )
          ],
        )
      ),
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hk2/features/room_status/application/header_item_view_model.dart';

// class HeaderItem extends ConsumerWidget {
//   final String title;
//   final Color color;

//   const HeaderItem({
//     super.key,
//     required this.title,
//     required this.color,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final isHovering = ref.watch(headerItemViewModelProvider);

//     return MouseRegion(
//       cursor: SystemMouseCursors.click,
//       onEnter: (_) => ref.read(headerItemViewModelProvider.notifier).setHovering(true),
//       onExit: (_) => ref.read(headerItemViewModelProvider.notifier).setHovering(false),
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10.0),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withValues(alpha: 0.2),
//               offset: const Offset(1.0, 1.0),
//               blurRadius: 3.0,
//             ),
//           ],
//           color: Colors.white,
//         ),
//         height: 72,
//         width: 133,
//         child: Stack(
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 AnimatedContainer(
//                   duration: const Duration(milliseconds: 150),
//                   width: isHovering ? 36 : 26,
//                   height: 72,
//                   decoration: BoxDecoration(
//                     color: color,
//                     borderRadius: const BorderRadius.only(
//                       topLeft: Radius.circular(10.0),
//                       bottomLeft: Radius.circular(10.0),
//                     ),
//                   ),
//                 ),
//                 const Expanded(
//                   child: SizedBox.shrink(),
//                 )
//               ]
//             ),
//             Positioned(
//               left: 50.0,
//               top: 8.0,
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 150),
//                 padding: EdgeInsets.only(left: isHovering ?  8.0 : 0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(title),
//                     const SizedBox(height: 4.0),
//                     const Text('103', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
//                   ],
//                 )
//               ),
//             )
//           ],
//         )
//       ),
//     );
//   }
// }