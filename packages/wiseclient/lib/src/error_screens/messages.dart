/// [getServerErrorTitle] for server error screen title
String getServerErrorTitle(String languageCode) {
  String errorMessage;

  switch (languageCode) {
    case 'nl':
      errorMessage = 'Serverfout';
    case 'es':
      errorMessage = 'Error del servidor';
    case 'de':
      errorMessage = 'Serverfehler';
    case 'fr':
      errorMessage = 'Erreur de serveur';
    case 'ar':
      errorMessage = 'خطأ في الخادم';
    case 'ja':
      errorMessage = 'サーバーエラー';
    default:
      errorMessage = 'Client error';
  }

  return errorMessage;
}

/// [getClientErrorTitle] for server error screen title
String getClientErrorTitle(String languageCode) {
  String errorMessage;

  switch (languageCode) {
    case 'nl':
      errorMessage = 'Clientfout';
    case 'es':
      errorMessage = 'Error del cliente';
    case 'de':
      errorMessage = 'Clientfehler';
    case 'fr':
      errorMessage = 'Erreur client';
    case 'ar':
      errorMessage = 'خطأ في العميل';
    case 'ja':
      errorMessage = 'クライアントエラー';
    default:
      errorMessage = 'Client error';
  }

  return errorMessage;
}

/// [getDetailedClientErrorMessage] for client detail message
String getDetailedClientErrorMessage(String languageCode) {
  String errorMessage;

  switch (languageCode) {
    case 'en':
      errorMessage = 'A client error occurred, please try again later';
    case 'nl':
      errorMessage =
          'Er is een fout opgetreden bij de client, probeer het later opnieuw';
    case 'es':
      errorMessage =
          'Se produjo un error del cliente, por favor inténtelo de nuevo más tarde';
    case 'de':
      errorMessage =
          'Es ist ein Clientfehler aufgetreten, bitte versuchen Sie es später erneut';
    case 'fr':
      errorMessage =
          "Une erreur client s'est produite, veuillez réessayer plus tard";
    case 'ar':
      errorMessage = 'حدث خطأ في العميل، يرجى المحاولة مرة أخرى لاحقًا';
    case 'ja':
      errorMessage = 'クライアントエラーが発生しました。後でもう一度お試しください';
    default:
      errorMessage = 'A client error occurred, please try again later';
  }

  return errorMessage;
}

/// [getDetailedServerErrorMesssage] for server detail message
String getDetailedServerErrorMesssage(String languageCode) {
  String errorMessage;

  switch (languageCode) {
    case 'en':
      errorMessage = 'A server error occurred, please try again later';
    case 'nl':
      errorMessage =
          'Er is een serverfout opgetreden, probeer het later opnieuw';
    case 'es':
      errorMessage =
          'Se produjo un error del servidor, por favor inténtelo de nuevo más tarde';
    case 'de':
      errorMessage =
          'Es ist ein Serverfehler aufgetreten, bitte versuchen Sie es später erneut';
    case 'fr':
      errorMessage =
          "Une erreur de serveur s'est produite, veuillez réessayer plus tard";
    case 'ar':
      errorMessage = 'حدث خطأ في الخادم، يرجى المحاولة مرة أخرى لاحقًا';
    case 'ja':
      errorMessage = 'サーバーエラーが発生しました。後でもう一度お試しください';
    default:
      errorMessage = 'A server error occurred, please try again later';
  }

  return errorMessage;
}

/// [getViewFullMessage] view message string
String getViewFullMessage(String languageCode) {
  String message;

  switch (languageCode) {
    case 'en':
      message = 'View full message';
    case 'nl':
      message = 'Bekijk volledig bericht';
    case 'es':
      message = 'Ver mensaje completo';
    case 'de':
      message = 'Vollständige Nachricht anzeigen';
    case 'fr':
      message = 'Voir le message complet';
    case 'ar':
      message = 'عرض الرسالة بالكامل';
    case 'ja':
      message = '全文を表示';
    default:
      message = 'View full message';
  }

  return message;
}
