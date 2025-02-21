import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

import '../molecules/arrow_forward_button.dart';
import '../style/dimensions.dart';

class UserCard extends StatelessWidget {
  final UserCardItem? user;
  final VoidCallback? onPressed;

  const UserCard({super.key, required this.user, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final kPrimaryContainer = colorScheme.primaryContainer;
    final kOnPrimaryContainer = colorScheme.onPrimaryContainer;
    final kOnSurface = colorScheme.onSurface;
    final kOutlineVariant = colorScheme.outlineVariant;
    final kOutline = colorScheme.outline;
    final kSurfaceContainer = colorScheme.surfaceContainer;

    final kLayoutPadding = Dimensions.paddings.xlarge;

    final kFormSpace = Dimensions.spaces.xsmall;
    final kDetailSpace = Dimensions.spaces.xxsmall;

    return Card(
      elevation: 0,
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kFormSpace),
      ),
      child: Padding(
        padding: EdgeInsets.all(kLayoutPadding),
        child: user != null
            ? _buildUserContent(context, user!, onPressed!, kOutline, kPrimaryContainer,
                kOnPrimaryContainer, kOnSurface, kFormSpace, kDetailSpace)
            : _buildSkeleton(context, kOutline, kSurfaceContainer,
                kOutlineVariant, kFormSpace),
      ),
    );
  }

  Widget _buildUserContent(
      BuildContext context,
      UserCardItem user,
      VoidCallback onPressed,
      Color kOutline,
      Color kPrimaryContainer,
      Color kOnPrimaryContainer,
      Color kOnSurface,
      double kFormSpace,
      double kDetailSpace) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: kPrimaryContainer,
              foregroundColor: kOnPrimaryContainer,
              child: user.icon ??
                  Text(
                    user.name[0].toUpperCase(),
                  ),
            ),
            SizedBox(width: kFormSpace),
            Expanded(
              flex: 2,
              child: Text(
                user.name,
                style: TextStyle(
                  color: kOnSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ArrowForwardButton(
              onPressed: onPressed,
              iconColor: kOutline,
              iconSize: 16.0,
            ),
          ],
        ),
        SizedBox(height: kDetailSpace),
        Divider(
          height: 1,
          thickness: 1,
          color: kOutline,
        ),
      ],
    );
  }

  Widget _buildSkeleton(BuildContext context, Color kOutline,
      Color kSurfaceContainer, Color kOutlineVariant, double kFormSpace) {
    return Row(
      children: [
        SkeletonAnimation(
          shimmerColor: kSurfaceContainer,
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kOutlineVariant,
            ),
          ),
        ),
        SizedBox(width: kFormSpace),
        Expanded(
          flex: 2,
          child: SkeletonAnimation(
            shimmerColor: kSurfaceContainer,
            child: Container(
              height: 20,
              width: 100,
              color: kOutlineVariant,
            ),
          ),
        ),
      ],
    );
  }
}

class UserCardItem {
  final Widget? icon;
  final String name;

  UserCardItem({
    this.icon,
    required this.name,
  });
}
