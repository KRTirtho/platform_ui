import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart' as FluentUI;
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:macos_ui/macos_ui.dart' as MacosUI;
import 'package:platform_ui/platform_ui.dart';

const double kDefaultTextFieldIconSize = 18;

const BorderSide _kDefaultRoundedBorderSide = BorderSide(
  color: CupertinoDynamicColor.withBrightness(
    color: Color(0x33000000),
    darkColor: Color(0x33FFFFFF),
  ),
  width: 0.0,
);

const Border _kDefaultRoundedBorder = Border(
  top: _kDefaultRoundedBorderSide,
  bottom: _kDefaultRoundedBorderSide,
  left: _kDefaultRoundedBorderSide,
  right: _kDefaultRoundedBorderSide,
);

const BoxDecoration _kDefaultRoundedBorderDecoration = BoxDecoration(
  color: CupertinoDynamicColor.withBrightness(
    color: CupertinoColors.white,
    darkColor: CupertinoColors.black,
  ),
  border: _kDefaultRoundedBorder,
  borderRadius: BorderRadius.all(Radius.circular(5.0)),
);

class PlatformTextField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextDirection? textDirection;
  final bool autofocus;
  final String obscuringCharacter;
  final bool obscureText;
  final bool autocorrect;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final bool enableSuggestions;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final bool readOnly;
  final ToolbarOptions? toolbarOptions;
  final bool? showCursor;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final BoxHeightStyle selectionHeightStyle;
  final BoxWidthStyle selectionWidthStyle;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool? enableInteractiveSelection;
  final DragStartBehavior dragStartBehavior;
  final TextSelectionControls? selectionControls;
  final GestureTapCallback? onTap;
  final ScrollPhysics? scrollPhysics;
  final Iterable<String>? autofillHints;
  final ScrollController? scrollController;
  final String? restorationId;
  final Clip clipBehavior;
  final Widget? prefix;
  final Widget? suffix;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  final String? placeholder;
  final TextStyle? placeholderStyle;
  final String? label;
  final TextStyle? labelStyle;
  final Color? borderColor;
  final double? borderWidth;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;

  final Color? focusedBorderColor;
  final double? focusedBorderWidth;
  final Color? focusedBackgroundColor;
  final TextStyle? focusedStyle;

  const PlatformTextField({
    Key? key,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.readOnly = false,
    this.toolbarOptions,
    this.showCursor,
    this.autofocus = false,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.autocorrect = true,
    this.smartDashesType,
    this.smartQuotesType,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.inputFormatters,
    this.enabled,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.selectionHeightStyle = BoxHeightStyle.tight,
    this.selectionWidthStyle = BoxWidthStyle.tight,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.dragStartBehavior = DragStartBehavior.start,
    this.enableInteractiveSelection,
    this.selectionControls,
    this.onTap,
    this.scrollController,
    this.scrollPhysics,
    this.autofillHints = const <String>[],
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.prefix,
    this.suffix,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixIconColor,
    this.suffixIconColor,
    this.placeholder,
    this.placeholderStyle,
    this.label,
    this.labelStyle,
    this.borderColor,
    this.borderWidth,
    this.padding,
    this.backgroundColor,
    this.focusedBorderColor,
    this.focusedBorderWidth,
    this.focusedBackgroundColor,
    this.focusedStyle,
  }) : super(key: key);

  @override
  FluentUI.State<PlatformTextField> createState() => _PlatformTextFieldState();
}

class _PlatformTextFieldState extends FluentUI.State<PlatformTextField>
    with PlatformMixin<Widget> {
  @override
  Widget build(BuildContext context) {
    return getPlatformType(context);
  }

  FocusNode? _focusNode;

  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? (_focusNode ??= FocusNode());

  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    _effectiveFocusNode.addListener(() {
      if (mounted) {
        setState(() {
          isFocused = _effectiveFocusNode.hasFocus;
        });
      }
    });
  }

  @override
  void dispose() {
    _effectiveFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget android(BuildContext context) {
    return TextField(
      controller: widget.controller,
      focusNode: _effectiveFocusNode,
      decoration: InputDecoration(
        border: Theme.of(context).inputDecorationTheme.border?.copyWith(
              borderSide: Theme.of(context)
                  .inputDecorationTheme
                  .border
                  ?.borderSide
                  .copyWith(
                    color: widget.borderColor,
                    width: widget.borderWidth,
                  ),
            ),
        focusedBorder:
            Theme.of(context).inputDecorationTheme.focusedBorder?.copyWith(
                  borderSide: Theme.of(context)
                      .inputDecorationTheme
                      .focusedBorder
                      ?.borderSide
                      .copyWith(
                        color: widget.focusedBorderColor,
                        width: widget.focusedBorderWidth,
                      ),
                ),
        filled: widget.backgroundColor != null ||
            isFocused && widget.focusedBackgroundColor != null,
        fillColor:
            isFocused ? widget.focusedBackgroundColor : widget.backgroundColor,
        labelText: widget.label,
        labelStyle: widget.labelStyle,
        floatingLabelStyle: widget.labelStyle,
        hintText: widget.placeholder,
        hintStyle: widget.placeholderStyle,
        prefix: widget.prefix,
        suffix: widget.suffix,
        prefixIconColor: widget.prefixIconColor,
        suffixIconColor: widget.suffixIconColor,
        prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
        suffixIcon: widget.suffixIcon != null ? Icon(widget.suffixIcon) : null,
        contentPadding: widget.padding,
      ),
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      style: isFocused ? widget.focusedStyle : widget.style,
      strutStyle: widget.strutStyle,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      textDirection: widget.textDirection,
      readOnly: widget.readOnly,
      toolbarOptions: widget.toolbarOptions,
      showCursor: widget.showCursor,
      autofocus: widget.autofocus,
      obscuringCharacter: widget.obscuringCharacter,
      obscureText: widget.obscureText,
      autocorrect: widget.autocorrect,
      smartDashesType: widget.smartDashesType,
      smartQuotesType: widget.smartQuotesType,
      enableSuggestions: widget.enableSuggestions,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      expands: widget.expands,
      maxLength: widget.maxLength,
      maxLengthEnforcement: widget.maxLengthEnforcement,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      onSubmitted: widget.onSubmitted,
      inputFormatters: widget.inputFormatters,
      enabled: widget.enabled,
      cursorWidth: widget.cursorWidth,
      cursorHeight: widget.cursorHeight,
      cursorRadius: widget.cursorRadius,
      cursorColor: widget.cursorColor,
      selectionHeightStyle: widget.selectionHeightStyle,
      selectionWidthStyle: widget.selectionWidthStyle,
      keyboardAppearance: widget.keyboardAppearance,
      scrollPadding: widget.scrollPadding,
      dragStartBehavior: widget.dragStartBehavior,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      selectionControls: widget.selectionControls,
      onTap: widget.onTap,
      scrollController: widget.scrollController,
      scrollPhysics: widget.scrollPhysics,
      autofillHints: widget.autofillHints,
      clipBehavior: widget.clipBehavior,
      restorationId: widget.restorationId,
    );
  }

  @override
  Widget ios(BuildContext context) {
    final textField = CupertinoTextField(
      controller: widget.controller,
      focusNode: _effectiveFocusNode,
      decoration: _kDefaultRoundedBorderDecoration.copyWith(
        border: Border.fromBorderSide(
          _kDefaultRoundedBorderSide.copyWith(
            color: isFocused ? widget.focusedBorderColor : widget.borderColor,
            width: isFocused ? widget.focusedBorderWidth : widget.borderWidth,
          ),
        ),
        color:
            isFocused ? widget.focusedBackgroundColor : widget.backgroundColor,
      ),
      padding: widget.padding ?? const EdgeInsets.all(6.0),
      placeholder: widget.placeholder,
      placeholderStyle: widget.placeholderStyle,
      prefix: widget.prefix ??
          (widget.prefixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(
                    widget.prefixIcon,
                    color: widget.prefixIconColor,
                  ),
                )
              : null),
      suffix: widget.suffix ??
          (widget.suffixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    widget.suffixIcon,
                    color: widget.suffixIconColor,
                  ),
                )
              : null),
      prefixMode: OverlayVisibilityMode.always,
      suffixMode: OverlayVisibilityMode.always,
      clearButtonMode: OverlayVisibilityMode.editing,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      style: isFocused ? widget.focusedStyle : widget.style,
      strutStyle: widget.strutStyle,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      textDirection: widget.textDirection,
      readOnly: widget.readOnly,
      toolbarOptions: widget.toolbarOptions,
      showCursor: widget.showCursor,
      autofocus: widget.autofocus,
      obscuringCharacter: widget.obscuringCharacter,
      obscureText: widget.obscureText,
      autocorrect: widget.autocorrect,
      smartDashesType: widget.smartDashesType,
      smartQuotesType: widget.smartQuotesType,
      enableSuggestions: widget.enableSuggestions,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      expands: widget.expands,
      maxLength: widget.maxLength,
      maxLengthEnforcement: widget.maxLengthEnforcement,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      onSubmitted: widget.onSubmitted,
      inputFormatters: widget.inputFormatters,
      enabled: widget.enabled,
      cursorWidth: widget.cursorWidth,
      cursorHeight: widget.cursorHeight,
      cursorRadius: widget.cursorRadius ?? const Radius.circular(2.0),
      cursorColor: widget.cursorColor,
      selectionHeightStyle: widget.selectionHeightStyle,
      selectionWidthStyle: widget.selectionWidthStyle,
      keyboardAppearance: widget.keyboardAppearance,
      scrollPadding: widget.scrollPadding,
      dragStartBehavior: widget.dragStartBehavior,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      selectionControls: widget.selectionControls,
      onTap: widget.onTap,
      scrollController: widget.scrollController,
      scrollPhysics: widget.scrollPhysics,
      autofillHints: widget.autofillHints,
      clipBehavior: widget.clipBehavior,
      restorationId: widget.restorationId,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) Text(widget.label!, style: widget.labelStyle),
        SizedBox(height: widget.label != null ? 8.0 : 0.0),
        textField,
      ],
    );
  }

  @override
  Widget linux(BuildContext context) {
    final textField = TextField(
      controller: widget.controller,
      focusNode: _effectiveFocusNode,
      decoration: InputDecoration(
          isDense: true,
          border: Theme.of(context).inputDecorationTheme.border?.copyWith(
                borderSide: Theme.of(context)
                    .inputDecorationTheme
                    .border
                    ?.borderSide
                    .copyWith(
                      color: widget.borderColor,
                      width: widget.borderWidth,
                    ),
              ),
          focusedBorder:
              Theme.of(context).inputDecorationTheme.focusedBorder?.copyWith(
                    borderSide: Theme.of(context)
                        .inputDecorationTheme
                        .focusedBorder
                        ?.borderSide
                        .copyWith(
                          color: widget.focusedBorderColor,
                          width: widget.focusedBorderWidth,
                        ),
                  ),
          filled: true,
          fillColor: isFocused
              ? widget.focusedBackgroundColor
              : widget.backgroundColor,
          hintText: widget.placeholder,
          hintStyle: widget.placeholderStyle,
          prefix: widget.prefix,
          prefixIcon: widget.prefixIcon != null
              ? Icon(
                  widget.prefixIcon,
                  color: widget.prefixIconColor ??
                      PlatformTheme.of(context).textTheme?.body?.color,
                  size: kDefaultTextFieldIconSize,
                )
              : null,
          suffix: widget.suffix,
          suffixIcon: widget.suffixIcon != null
              ? Icon(
                  widget.suffixIcon,
                  color: widget.suffixIconColor ??
                      PlatformTheme.of(context).textTheme?.body?.color,
                  size: kDefaultTextFieldIconSize,
                )
              : null),
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      style: isFocused ? widget.focusedStyle : widget.style,
      strutStyle: widget.strutStyle,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      textDirection: widget.textDirection,
      readOnly: widget.readOnly,
      toolbarOptions: widget.toolbarOptions,
      showCursor: widget.showCursor,
      autofocus: widget.autofocus,
      obscuringCharacter: widget.obscuringCharacter,
      obscureText: widget.obscureText,
      autocorrect: widget.autocorrect,
      smartDashesType: widget.smartDashesType,
      smartQuotesType: widget.smartQuotesType,
      enableSuggestions: widget.enableSuggestions,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      expands: widget.expands,
      maxLength: widget.maxLength,
      maxLengthEnforcement: widget.maxLengthEnforcement,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      onSubmitted: widget.onSubmitted,
      inputFormatters: widget.inputFormatters,
      enabled: widget.enabled,
      cursorWidth: widget.cursorWidth,
      cursorHeight: widget.cursorHeight,
      cursorRadius: widget.cursorRadius,
      cursorColor: widget.cursorColor,
      selectionHeightStyle: widget.selectionHeightStyle,
      selectionWidthStyle: widget.selectionWidthStyle,
      keyboardAppearance: widget.keyboardAppearance,
      scrollPadding: widget.scrollPadding,
      dragStartBehavior: widget.dragStartBehavior,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      selectionControls: widget.selectionControls,
      onTap: widget.onTap,
      scrollController: widget.scrollController,
      scrollPhysics: widget.scrollPhysics,
      autofillHints: widget.autofillHints,
      clipBehavior: widget.clipBehavior,
      restorationId: widget.restorationId,
    );

    if (widget.label != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              _effectiveFocusNode.requestFocus();
            },
            child: Text(
              widget.label!,
              style: widget.labelStyle ??
                  PlatformTheme.of(context)
                      .textTheme
                      ?.body
                      ?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: widget.label != null ? 8.0 : 0.0),
          textField,
        ],
      );
    }

    return textField;
  }

  @override
  Widget macos(BuildContext context) {
    return FluentUI.Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) Text(widget.label!, style: widget.labelStyle),
        ClipRect(
          clipBehavior: widget.clipBehavior,
          child: MacosUI.MacosTextField(
            controller: widget.controller,
            focusNode: _effectiveFocusNode,
            decoration: MacosUI.kDefaultRoundedBorderDecoration.copyWith(
              border: Border.fromBorderSide(
                _kDefaultRoundedBorderSide.copyWith(
                  color: widget.borderColor,
                  width: widget.borderWidth,
                ),
              ),
              color: widget.backgroundColor,
            ),
            focusedDecoration: MacosUI.kDefaultFocusedBorderDecoration.copyWith(
              border: Border.fromBorderSide(
                _kDefaultRoundedBorderSide.copyWith(
                  color: widget.focusedBorderColor,
                  width: widget.focusedBorderWidth,
                ),
              ),
              color: widget.focusedBackgroundColor,
            ),
            padding:
                (widget.padding as EdgeInsets?) ?? const EdgeInsets.all(6.0),
            placeholder: widget.placeholder,
            placeholderStyle: widget.placeholderStyle,
            prefix: widget.prefix ??
                (widget.prefixIcon != null
                    ? Icon(
                        widget.prefixIcon,
                        color: widget.prefixIconColor,
                      )
                    : null),
            suffix: widget.suffix ??
                (widget.suffixIcon != null
                    ? Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(
                          widget.suffixIcon,
                          color: widget.suffixIconColor,
                        ),
                      )
                    : null),
            prefixMode: MacosUI.OverlayVisibilityMode.always,
            suffixMode: MacosUI.OverlayVisibilityMode.always,
            clearButtonMode: MacosUI.OverlayVisibilityMode.editing,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            textCapitalization: widget.textCapitalization,
            style: isFocused ? widget.focusedStyle : widget.style,
            strutStyle: widget.strutStyle,
            textAlign: widget.textAlign,
            textAlignVertical: widget.textAlignVertical,
            readOnly: widget.readOnly,
            toolbarOptions: widget.toolbarOptions,
            showCursor: widget.showCursor,
            autofocus: widget.autofocus,
            obscuringCharacter: widget.obscuringCharacter,
            obscureText: widget.obscureText,
            autocorrect: widget.autocorrect,
            smartDashesType: widget.smartDashesType,
            smartQuotesType: widget.smartQuotesType,
            enableSuggestions: widget.enableSuggestions,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            expands: widget.expands,
            maxLength: widget.maxLength,
            maxLengthEnforcement: widget.maxLengthEnforcement,
            onChanged: widget.onChanged,
            onEditingComplete: widget.onEditingComplete,
            onSubmitted: widget.onSubmitted,
            inputFormatters: widget.inputFormatters,
            enabled: widget.enabled,
            cursorWidth: widget.cursorWidth,
            cursorHeight: widget.cursorHeight,
            cursorRadius: widget.cursorRadius ?? const Radius.circular(2.0),
            cursorColor: widget.cursorColor,
            selectionHeightStyle: widget.selectionHeightStyle,
            selectionWidthStyle: widget.selectionWidthStyle,
            keyboardAppearance: widget.keyboardAppearance,
            scrollPadding: widget.scrollPadding,
            dragStartBehavior: widget.dragStartBehavior,
            enableInteractiveSelection:
                widget.enableInteractiveSelection ?? true,
            selectionControls: widget.selectionControls,
            onTap: widget.onTap,
            scrollController: widget.scrollController,
            scrollPhysics: widget.scrollPhysics,
            autofillHints: widget.autofillHints,
            restorationId: widget.restorationId,
          ),
        ),
      ],
    );
  }

  @override
  Widget windows(BuildContext context) {
    return FluentUI.TextBox(
      controller: widget.controller,
      focusNode: _effectiveFocusNode,
      decoration: BoxDecoration(
          color: isFocused
              ? widget.focusedBackgroundColor
              : widget.backgroundColor),
      foregroundDecoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isFocused
                ? widget.borderColor ??
                    FluentUI.FluentTheme.of(context).accentColor
                : widget.enabled != true
                    ? Colors.transparent
                    : FluentUI.FluentTheme.of(context).brightness.isLight
                        ? const Color.fromRGBO(0, 0, 0, 0.45)
                        : const Color.fromRGBO(255, 255, 255, 0.54),
            width: isFocused
                ? widget.focusedBorderWidth ?? 2
                : widget.borderWidth ?? 0,
          ),
        ),
      ),
      header: widget.label,
      headerStyle: widget.labelStyle,
      padding: widget.padding ?? const EdgeInsets.all(6.0),
      placeholder: widget.placeholder,
      placeholderStyle: widget.placeholderStyle,
      prefix: widget.prefix ??
          (widget.prefixIcon != null
              ? FluentUI.Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(
                    widget.prefixIcon,
                    color: widget.prefixIconColor,
                  ),
                )
              : null),
      suffix: widget.suffix ??
          (widget.suffixIcon != null
              ? FluentUI.Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    widget.suffixIcon,
                    color: widget.suffixIconColor,
                  ),
                )
              : null),
      prefixMode: FluentUI.OverlayVisibilityMode.always,
      suffixMode: FluentUI.OverlayVisibilityMode.always,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      style: isFocused ? widget.focusedStyle : widget.style,
      strutStyle: widget.strutStyle,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      readOnly: widget.readOnly,
      showCursor: widget.showCursor,
      autofocus: widget.autofocus,
      obscuringCharacter: widget.obscuringCharacter,
      obscureText: widget.obscureText,
      autocorrect: widget.autocorrect,
      smartDashesType: widget.smartDashesType,
      smartQuotesType: widget.smartQuotesType,
      enableSuggestions: widget.enableSuggestions,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      expands: widget.expands,
      maxLength: widget.maxLength,
      maxLengthEnforcement: widget.maxLengthEnforcement,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      onSubmitted: widget.onSubmitted,
      inputFormatters: widget.inputFormatters,
      enabled: widget.enabled,
      cursorWidth: widget.cursorWidth,
      cursorHeight: widget.cursorHeight,
      cursorRadius: widget.cursorRadius ?? const Radius.circular(2.0),
      cursorColor: widget.cursorColor,
      selectionHeightStyle: widget.selectionHeightStyle,
      selectionWidthStyle: widget.selectionWidthStyle,
      keyboardAppearance: widget.keyboardAppearance,
      scrollPadding: widget.scrollPadding,
      dragStartBehavior: widget.dragStartBehavior,
      enableInteractiveSelection: widget.enableInteractiveSelection ?? true,
      onTap: widget.onTap,
      scrollController: widget.scrollController,
      scrollPhysics: widget.scrollPhysics,
      autofillHints: widget.autofillHints,
      clipBehavior: widget.clipBehavior,
      restorationId: widget.restorationId,
    );
  }
}
