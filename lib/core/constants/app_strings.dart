abstract final class AppStrings {
  static const String appTitle = 'Anhaenger-Verwaltung';

  static const String navDashboard = 'Dashboard';
  static const String navTrailers = 'Anhaenger';
  static const String navDamages = 'Schaeden';
  static const String navCustomers = 'Kunden';
  static const String navContracts = 'Vertraege';
  static const String navSettings = 'Einstellungen';

  static const String actionSave = 'Speichern';
  static const String actionCancel = 'Abbrechen';
  static const String actionDelete = 'Loeschen';
  static const String actionEdit = 'Bearbeiten';
  static const String actionAdd = 'Hinzufuegen';
  static const String actionClose = 'Schliessen';
  static const String actionRetry = 'Erneut versuchen';
  static const String actionExport = 'Exportieren';

  static const String statusAvailable = 'Verfuegbar';
  static const String statusRented = 'Vermietet';
  static const String statusMaintenance = 'In Wartung';
  static const String statusBlocked = 'Gesperrt';

  static const String contractStatusActive = 'Aktiv';
  static const String contractStatusCompleted = 'Abgeschlossen';
  static const String contractStatusCancelled = 'Storniert';

  static const String loading = 'Daten werden geladen...';
  static const String errorGeneric = 'Die Daten konnten nicht geladen werden.';
  static const String emptyTrailers =
      'Keine Anhaenger vorhanden. Legen Sie den ersten Anhaenger an.';
  static const String emptyDamages =
      'Fuer diesen Anhaenger sind keine Schaeden erfasst.';
  static const String emptyCustomers = 'Keine Kunden vorhanden.';
  static const String emptyContracts = 'Keine Mietvertraege vorhanden.';
  static const String emptySearch = 'Keine Ergebnisse fuer Ihre Suche.';

  static const String validationRequired = 'Dieses Feld ist erforderlich.';
  static const String validationEmail =
      'Bitte geben Sie eine gueltige E-Mail-Adresse ein.';
  static const String validationDateRange =
      'Das Mietende muss nach dem Mietbeginn liegen.';

  static const String confirmDelete =
      'Moechten Sie diesen Eintrag wirklich loeschen?';
  static const String saveSuccess = 'Die Aenderungen wurden gespeichert.';
}
