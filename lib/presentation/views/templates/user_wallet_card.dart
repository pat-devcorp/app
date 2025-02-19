import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

import '../style/dimensions.dart';

class UserWalletCard extends StatelessWidget {
  final UserWalletCardItem? user;

  const UserWalletCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final kPrimary = colorScheme.primary;
    final kPrimaryContainer = colorScheme.primaryContainer;
    final kOnPrimaryContainer = colorScheme.onPrimaryContainer;
    final kOnSurface = colorScheme.onSurface;
    final kOutlineVariant = colorScheme.outlineVariant;
    final kOutline = colorScheme.outline;
    final kOnSurfaceVariant = colorScheme.onSurfaceVariant;
    final kSurfaceContainer = colorScheme.surfaceContainer;

    final kLayoutRadius = Dimensions.radius.small;

    final kLayoutPadding = Dimensions.paddings.xlarge;

    final kFormSpace = Dimensions.spaces.xsmall;
    final kDetailSpace = Dimensions.spaces.xxxsmall;

    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kLayoutRadius),
      ),
      child: Padding(
        padding: EdgeInsets.all(kLayoutPadding),
        child: user != null
            ? _buildUserContent(
                context,
                user!,
                kPrimaryContainer,
                kOnPrimaryContainer,
                kOnSurface,
                kOnSurfaceVariant,
                kPrimary,
                kOutline,
                kFormSpace,
                kDetailSpace)
            : _buildSkeleton(context, kSurfaceContainer, kOutlineVariant,
                kOutline, kFormSpace, kDetailSpace),
      ),
    );
  }

  Widget _buildUserContent(
      BuildContext context,
      UserWalletCardItem user,
      Color kPrimaryContainer,
      Color kOnPrimaryContainer,
      Color kOnSurface,
      Color kOnSurfaceVariant,
      Color kPrimary,
      Color kOutline,
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
                    user.tittle[0].toUpperCase(),
                  ),
            ),
            SizedBox(width: kFormSpace),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    user.tittle,
                    style: TextStyle(
                      color: kOnSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: kDetailSpace),
                  Text(
                    '**** ${user.detail}',
                    style: TextStyle(
                      color: kOnSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: kFormSpace),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    user.amount,
                    style: TextStyle(
                      color: kPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: kFormSpace),
                  Icon(Icons.arrow_forward_ios, size: 16, color: kOutline),
                ],
              ),
            ),
          ],
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: kOutline,
        ),
      ],
    );
  }

  Widget _buildSkeleton(
      BuildContext context,
      Color kSurfaceContainer,
      Color kOutlineVariant,
      Color kOutline,
      double kFormSpace,
      double kDetailSpace) {
    return Column(
      children: [
        Row(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonAnimation(
                    shimmerColor: kSurfaceContainer,
                    child: Container(
                      height: 20,
                      width: 100,
                      color: kOutlineVariant,
                    ),
                  ),
                  SizedBox(height: kDetailSpace),
                  SkeletonAnimation(
                    shimmerColor: kSurfaceContainer,
                    child: Container(
                      height: 20,
                      width: 80,
                      color: kOutlineVariant,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: kFormSpace),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SkeletonAnimation(
                    shimmerColor: kSurfaceContainer,
                    child: Container(
                      height: 20,
                      width: 60,
                      color: kOutlineVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: kOutline,
        ),
      ],
    );
  }
}

class UserWalletCardItem {
  final Widget? icon;
  final String tittle;
  final String detail;
  final String amount;

  UserWalletCardItem({
    this.icon,
    required this.tittle,
    required this.detail,
    required this.amount,
  });
}
