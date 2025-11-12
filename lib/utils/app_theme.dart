import 'package:flutter/material.dart';

class AppTheme {
  // Updated palette inspired by provided template (Laundry app) but keeping TAGit brand coral.
  // Assumption: Primary brand color remains coral (#FF7643) for emergency app identity.
  static const Color primaryCoral = Color(0xFFFF7643); // Brand primary
  static const Color primaryCoralDark = Color(0xFFE75F2F); // Darker shade
  static const Color primaryCoralLight = Color(0xFFFFA37F); // Light accent

  // Legacy color name aliases (to avoid breaking existing references until refactor):
  static const Color primaryRed = primaryCoral;
  static const Color darkRed = primaryCoralDark;
  static const Color lightRed = primaryCoralLight;
  static const Color ultraLightRed =
      Color(0xFFFFF2EA); // soft very light coral background
  static const Color backgroundLight = backgroundColor; // alias

  static const Color backgroundColor =
      Color(0xFFF5F7F9); // Subtle off-white (from template)
  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFFDFDFD);
  static const Color textDark = Color(0xFF131621); // Slightly softened dark
  static const Color textGrey = Color(0xFF4A4D54);
  static const Color textLightGrey = Color(0xFF8F94A2);
  static const Color dividerGrey = Color(0xFFE0E3E8);
  static const Color borderGrey = Color(0xFFD4D7DD);

  static const Color successGreen = Color(0xFF4CAF50);
  static const Color warningOrange = Color(0xFFFF9800);
  static const Color errorRed = Color(0xFFD32F2F);
  static const Color accentBlue = Color(0xFF2DAAE1);

  // Simple gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      primaryCoral,
      primaryCoralDark,
    ],
  );

  static const LinearGradient lightGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFFFFF),
      Color(0xFFF5F5F5),
    ],
  );

  // Theme Data - Minimalistic & Clean
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    // Use GoogleFonts Poppins via textTheme override below
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: primaryCoral,
      onPrimary: Colors.white,
      secondary: primaryCoralLight,
      onSecondary: textDark,
      error: errorRed,
      onError: Colors.white,
      surface: cardWhite,
      onSurface: textDark,
      tertiary: accentBlue,
    ),
    scaffoldBackgroundColor: backgroundColor,

    // AppBar Theme - Minimal
    appBarTheme: const AppBarTheme(
      backgroundColor: cardWhite,
      foregroundColor: textDark,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textDark,
        letterSpacing: 0,
      ),
      iconTheme: IconThemeData(
        color: textDark,
        size: 24,
      ),
    ),

    // Card Theme - Subtle shadows
    cardTheme: CardThemeData(
      color: cardWhite,
      elevation: 0,
      shadowColor: Colors.black.withOpacity(0.05),
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: dividerGrey, width: 1),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
    ),

    // Elevated Button Theme - Bold & Simple
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        minimumSize: const WidgetStatePropertyAll(Size(double.infinity, 48)),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled))
            return primaryCoralLight.withOpacity(0.5);
          return primaryCoral;
        }),
        foregroundColor: const WidgetStatePropertyAll(Colors.white),
        shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        elevation: const WidgetStatePropertyAll(0),
        textStyle: const WidgetStatePropertyAll(
            TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
      ),
    ),

    // Outlined Button Theme - Clean borders
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        minimumSize: const WidgetStatePropertyAll(Size(double.infinity, 48)),
        side: const WidgetStatePropertyAll(
            BorderSide(color: primaryCoral, width: 2)),
        foregroundColor: const WidgetStatePropertyAll(primaryCoral),
        shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        textStyle: const WidgetStatePropertyAll(
            TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
      ),
    ),

    // Input Decoration Theme - Minimal
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: cardWhite,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: borderGrey, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: borderGrey, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: primaryCoral, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: errorRed, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      labelStyle: const TextStyle(color: textGrey, fontSize: 14),
      hintStyle: const TextStyle(color: textLightGrey, fontSize: 14),
    ),

    // Text Theme - Clean & Readable
    // Text styles will be replaced at runtime by GoogleFonts in MaterialApp builder if desired.
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w700,
          color: textDark,
          letterSpacing: -0.5),
      headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: textDark,
          letterSpacing: -0.3),
      titleLarge:
          TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: textDark),
      titleMedium:
          TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: textDark),
      bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: textDark,
          height: 1.5),
      bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: textGrey,
          height: 1.4),
      bodySmall: TextStyle(
          fontSize: 12, fontWeight: FontWeight.w400, color: textLightGrey),
    ),

    // Icon Theme - Consistent sizing
    iconTheme: const IconThemeData(
      color: textDark,
      size: 24,
    ),
  );

  // Simplified gradients
  static const LinearGradient redGradient = LinearGradient(
    colors: [primaryCoral, primaryCoralDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Minimal Box Shadow
  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.04),
      blurRadius: 10,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> buttonShadow = [
    BoxShadow(
      color: primaryCoral.withOpacity(0.25),
      blurRadius: 10,
      offset: const Offset(0, 4),
    ),
  ];

  // Animation Durations
  static const Duration fastAnimation = Duration(milliseconds: 150);
  static const Duration normalAnimation = Duration(milliseconds: 250);
  static const Duration slowAnimation = Duration(milliseconds: 400);
}

// Custom Widgets for consistent styling
class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final Gradient gradient;

  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.gradient = AppTheme.redGradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: onPressed != null ? gradient : null,
        color: onPressed == null ? Colors.grey : null,
        borderRadius: BorderRadius.circular(12),
        boxShadow: onPressed != null ? AppTheme.cardShadow : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Center(
              child: isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (icon != null) ...[
                          Icon(icon, color: Colors.white),
                          const SizedBox(width: 8),
                        ],
                        Text(
                          text,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color? color;
  final VoidCallback? onTap;

  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cardColor = color ?? AppTheme.primaryCoral;

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: cardColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: cardColor,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              if (onTap != null)
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: AppTheme.textGrey,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
