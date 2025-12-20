import 'package:flutter/material.dart';
import '../constants/colors.dart';

class ChapterListItem extends StatelessWidget {
  final int number;
  final String title;
  final String subtitle;
  final double rating;
  final bool isLocked;
  final VoidCallback? onTap;

  const ChapterListItem({
    super.key,
    required this.number,
    required this.title,
    required this.subtitle,
    required this.rating,
    this.isLocked = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(16),
        elevation: 2,
        shadowColor: AppColors.shadowColor,
        child: InkWell(
          onTap: isLocked ? null : onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      '$number',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            subtitle,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textGray,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Icon(
                            Icons.star,
                            size: 14,
                            color: AppColors.accentYellow,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            rating.toStringAsFixed(1),
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textGray,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (isLocked)
                  const Icon(
                    Icons.lock_outline,
                    color: AppColors.textGray,
                    size: 20,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
