import 'package:flutter/material.dart';

/// The soft left-to-right gradient used on the profile card and announcements.
///
/// Text and icons placed on it should use [ColorScheme.onPrimary].
LinearGradient brandGradient(ColorScheme colors) {
  return LinearGradient(
    colors: [
      colors.primary,
      Color.lerp(colors.primary, colors.onPrimary, 0.25)!,
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
