class StringUtils {
  static String convertTurkishToEnglish(String text) {
    const turkishChars = ['ı', 'İ', 'ğ', 'Ğ', 'ü', 'Ü', 'ş', 'Ş', 'ö', 'Ö', 'ç', 'Ç'];
    const englishChars = ['i', 'I', 'g', 'G', 'u', 'U', 's', 'S', 'o', 'O', 'c', 'C'];
    
    String result = text;
    for (int i = 0; i < turkishChars.length; i++) {
      result = result.replaceAll(turkishChars[i], englishChars[i]);
    }
    return result;
  }

  static String generateUsernameFromName(String firstName, String lastName) {
    if (firstName.isEmpty && lastName.isEmpty) return '';
    
    // Convert to English characters and remove spaces
    String normalizedFirstName = convertTurkishToEnglish(firstName.trim());
    String normalizedLastName = convertTurkishToEnglish(lastName.trim());
    
    // Remove any special characters and spaces, convert to lowercase
    normalizedFirstName = normalizedFirstName.replaceAll(RegExp(r'[^a-zA-Z]'), '').toLowerCase();
    normalizedLastName = normalizedLastName.replaceAll(RegExp(r'[^a-zA-Z]'), '').toLowerCase();
    
    // Combine first name and last name
    return '$normalizedFirstName$normalizedLastName';
  }
}