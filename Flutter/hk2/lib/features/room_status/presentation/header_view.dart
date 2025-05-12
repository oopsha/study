import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hk2/features/room_status/widgets/header_item.dart';
import 'package:hk2/shared/extensions/string_extensions.dart';

class HeaderView extends ConsumerWidget {
  const HeaderView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        HeaderItem(color: '#bbbbbb'.toColor(), title: '퇴실예정'),
        HeaderItem(color: '#3a4359'.toColor(), title: '퇴실완료'),
        HeaderItem(color: '#00b0ff'.toColor(), title: '청소중'),
        HeaderItem(color: '#ffc107'.toColor(), title: '청소완료'),
        HeaderItem(color: '#4cdb09'.toColor(), title: '재실'),
        HeaderItem(color: '#ff5656'.toColor(), title: '점검요청'),
        // HeaderItem(color: '#7a7fca'.toColor(), title: '점검완료'),
      ]
    );
  }
}
