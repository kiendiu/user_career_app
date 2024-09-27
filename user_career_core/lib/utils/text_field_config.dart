import 'package:flutter/services.dart';
import 'package:mobile_framework/packages/ui/utilities/character_length_limiter.dart';

class TextFieldConfig {
  TextFieldConfig._();

  static ({
    List<TextInputFormatter> inputFormatters,
    CharacterLengthLimiter characterLengthLimiter,
    TextInputType textInputType
  }) get phone => (
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        characterLengthLimiter:
            CharacterLengthLimiter(length: 11, canShowCharacterCount: false),
        textInputType: TextInputType.phone
      );

  static ({
    List<TextInputFormatter> inputFormatters,
    CharacterLengthLimiter characterLengthLimiter,
    TextInputType textInputType
  }) get tin => (
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
        ],
        characterLengthLimiter:
            CharacterLengthLimiter(length: 15, canShowCharacterCount: false),
        textInputType: const TextInputType.numberWithOptions(signed: true)
      );

  static ({
    List<TextInputFormatter> inputFormatters,
    CharacterLengthLimiter characterLengthLimiter,
    TextInputType textInputType
  }) get idCardNumber => (
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        characterLengthLimiter:
            CharacterLengthLimiter(length: 12, canShowCharacterCount: false),
        textInputType: TextInputType.phone
      );

  static ({
    List<TextInputFormatter> inputFormatters,
    CharacterLengthLimiter characterLengthLimiter,
    TextInputType textInputType
  }) get yob => (
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        characterLengthLimiter:
            CharacterLengthLimiter(length: 4, canShowCharacterCount: false),
        textInputType: TextInputType.phone
      );

  static ({
    List<TextInputFormatter> inputFormatters,
    CharacterLengthLimiter characterLengthLimiter,
    TextInputType textInputType
  }) get profit => (
        inputFormatters: [
          // FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
        ],
        characterLengthLimiter:
            CharacterLengthLimiter(length: 200, canShowCharacterCount: false),
        textInputType:
            const TextInputType.numberWithOptions(signed: true, decimal: true)
      );

  static ({
    List<TextInputFormatter> inputFormatters,
    CharacterLengthLimiter characterLengthLimiter,
    TextInputType textInputType
  }) get normalTextField => (
        inputFormatters: [],
        characterLengthLimiter:
            CharacterLengthLimiter(length: 200, canShowCharacterCount: false),
        textInputType: TextInputType.text
      );

  static ({
    List<TextInputFormatter> inputFormatters,
    CharacterLengthLimiter characterLengthLimiter,
    TextInputType textInputType
  }) get description => (
        inputFormatters: [],
        characterLengthLimiter:
            CharacterLengthLimiter(length: 2000, canShowCharacterCount: false),
        textInputType: TextInputType.text
      );

  static ({
    List<TextInputFormatter> inputFormatters,
    CharacterLengthLimiter characterLengthLimiter,
    TextInputType textInputType
  }) get contract => (
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        characterLengthLimiter:
            CharacterLengthLimiter(length: 20, canShowCharacterCount: false),
        textInputType: TextInputType.text
      );

  static ({
    List<TextInputFormatter> inputFormatters,
    CharacterLengthLimiter characterLengthLimiter,
    TextInputType textInputType
  }) get note => (
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        characterLengthLimiter:
            CharacterLengthLimiter(length: 100, canShowCharacterCount: true),
        textInputType: TextInputType.text
      );

  static ({
    List<TextInputFormatter> inputFormatters,
    CharacterLengthLimiter characterLengthLimiter,
    TextInputType textInputType
  }) get zalo => (
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        characterLengthLimiter:
            CharacterLengthLimiter(length: 10, canShowCharacterCount: false),
        textInputType: TextInputType.phone
      );
}
