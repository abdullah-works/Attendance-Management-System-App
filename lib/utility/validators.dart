String? defaultUserInputValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please provide the requested credentials';
  }
  if (value.trim().isEmpty) {
    return 'Only Whitespaces are not accepted';
  }
  return null;
}
