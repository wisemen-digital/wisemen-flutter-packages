import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';

class InfoTile extends StatefulWidget {
  const InfoTile({
    super.key,
    required this.title,
    required this.value,
    this.icon,
  });

  final String title;
  final String value;
  final IconData? icon;

  @override
  State<InfoTile> createState() => _InfoTileState();
}

class _InfoTileState extends State<InfoTile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (widget.icon != null) ...[
          Icon(widget.icon, color: Colors.red),
          const SizedBox(width: 16),
        ],
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title: ${widget.title}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: context.fgColor.brandPrimary,
              ),
            ),
          ],
        ),
        gapWM,
        InkWell(
          onTap: () {
            context.router.maybePop();
          },
          child: Ink(
            padding: padS,
            child: const Icon(
              Icons.delete,
              color: context.fgColor.brandPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
