// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:slate/src/core/constants/app_colors.dart';
import 'package:slate/src/core/constants/app_text_styles.dart';

class SlateStyleGuide extends StatefulWidget {
  const SlateStyleGuide({super.key});

  @override
  SlateStyleGuideState createState() => SlateStyleGuideState();
}

class SlateStyleGuideState extends State<SlateStyleGuide>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text)).then((_) {
      _scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          content: Text('Copied to clipboard: $text'),
          duration: const Duration(seconds: 2),
          backgroundColor: AppColors.success,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text('Style Guide Browser', style: AppTextStyles.heading2),
          backgroundColor: AppColors.surface,
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Colors'),
              Tab(text: 'Text Styles'),
            ],
            labelStyle: AppTextStyles.labelBold,
            unselectedLabelColor: AppColors.textSecondary,
            labelColor: AppColors.primaryGreen,
            indicatorColor: AppColors.primaryGreen,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildColorsGrid(),
            _buildTextStylesList(),
          ],
        ),
      ),
    );
  }

  Widget _buildColorsGrid() {
    // Create a map of color name to color value
    final colorMap = {
      'green': AppColors.green,
      'surface': AppColors.surface,
      'gray': AppColors.gray,
      'lightGray': AppColors.lightGray,
      'pureWhite': AppColors.pureWhite,
      'primaryTeal': AppColors.primaryTeal,
      'accentCream': AppColors.accentCream,
      'backgroundLight': AppColors.backgroundLight,
      'textDark': AppColors.textDark,
      'textLight': AppColors.textLight,
      'iconColor': AppColors.iconColor,
      'dividerColor': AppColors.dividerColor,
      'backgroundDark': AppColors.backgroundDark,
      'surfaceDark': AppColors.surfaceDark,
      'iconColorDark': AppColors.iconColorDark,
      'dividerColorDark': AppColors.dividerColorDark,
      'expenseRed': AppColors.expenseRed,
      'incomeGreen': AppColors.incomeGreen,
      'success': AppColors.success,
      'warning': AppColors.warning,
      'error': AppColors.error,
      'info': AppColors.info,
      'background': AppColors.background,
      'surfaceLight': AppColors.surfaceLight,
      'textPrimary': AppColors.textPrimary,
      'textSecondary': AppColors.textSecondary,
      'primaryGreen': AppColors.primaryGreen,
      'chatBubbleGreen': AppColors.chatBubbleGreen,
      'purple': AppColors.purple,
      'blue': AppColors.blue,
      'orange': AppColors.orange,
      'containerBackground': AppColors.containerBackground,
      'negativeRed': AppColors.negativeRed,
      'chartPurple': AppColors.chartPurple,
      'chartBlue': AppColors.chartBlue,
    };

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: colorMap.length,
      itemBuilder: (context, index) {
        final colorName = colorMap.keys.elementAt(index);
        final color = colorMap.values.elementAt(index);

        return _buildColorCard(colorName, color);
      },
    );
  }

  Widget _buildColorCard(String colorName, Color color) {
    final textColor = _calculateTextColor(color);
    final codeSnippet = 'color: AppColors.$colorName,';

    return InkWell(
      onTap: () => _copyToClipboard(codeSnippet),
      child: Card(
        color: color,
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                colorName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              Text(
                _colorToHex(color),
                style: TextStyle(
                  fontSize: 12,
                  color: textColor,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: textColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Tap to copy',
                  style: TextStyle(
                    fontSize: 10,
                    color: textColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextStylesList() {
    // Create a map of text style name to text style
    final textStyleMap = {
      'heading1': AppTextStyles.heading1,
      'heading2': AppTextStyles.heading2,
      'heading3': AppTextStyles.heading3,
      'bodyLarge': AppTextStyles.bodyLarge,
      'bodyMedium': AppTextStyles.bodyMedium,
      'bodySmall': AppTextStyles.bodySmall,
      'currencyLarge': AppTextStyles.currencyLarge,
      'labelBold': AppTextStyles.labelBold,
      'buttonText': AppTextStyles.buttonText,
      'chatText': AppTextStyles.chatText,
    };

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: textStyleMap.length,
      itemBuilder: (context, index) {
        final styleName = textStyleMap.keys.elementAt(index);
        final textStyle = textStyleMap.values.elementAt(index);

        return _buildTextStyleCard(styleName, textStyle);
      },
    );
  }

  Widget _buildTextStyleCard(String styleName, TextStyle textStyle) {
    final codeSnippet = 'style: AppTextStyles.$styleName';
    final styleDetails =
        'Size: ${textStyle.fontSize}px, Weight: ${textStyle.fontWeight}, Color: ${_colorToHex(textStyle.color ?? AppColors.textPrimary)}';

    return Card(
      color: AppColors.containerBackground,
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () => _copyToClipboard(codeSnippet),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    styleName,
                    style: AppTextStyles.labelBold,
                  ),
                  IconButton(
                    icon: const Icon(Icons.content_copy,
                        color: AppColors.primaryGreen, size: 18),
                    onPressed: () => _copyToClipboard(codeSnippet),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'The quick brown fox jumps over the lazy dog',
                style: textStyle,
              ),
              const SizedBox(height: 8),
              Text(
                styleDetails,
                style: AppTextStyles.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';
  }

  Color _calculateTextColor(Color backgroundColor) {
    // Use luminance to determine if text should be light or dark
    if (backgroundColor.computeLuminance() > 0.5) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }
}
