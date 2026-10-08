abstract final class AppStrings {
  static const String appTitle = 'Anhänger-Verwaltung';

  static const String navDashboard = 'Dashboard';
  static const String navTrailers = 'Anhänger';
  static const String navDamages = 'Schäden';
  static const String navCustomers = 'Kunden';
  static const String navContracts = 'Verträge';
  static const String navSettings = 'Einstellungen';

  static const String actionSave = 'Speichern';
  static const String actionCancel = 'Abbrechen';
  static const String actionDelete = 'Löschen';
  static const String actionEdit = 'Bearbeiten';
  static const String actionAdd = 'Hinzufügen';
  static const String actionClose = 'Schließen';
  static const String actionRetry = 'Erneut versuchen';
  static const String actionExport = 'Exportieren';
  static const String actionConfirm = 'Bestätigen';
  static const String actionStart = 'Anmelden';
  static const String actionSwitchUser = 'Benutzer wechseln';

  static const String statusAvailable = 'Verfügbar';
  static const String statusRented = 'Vermietet';
  static const String statusMaintenance = 'In Wartung';
  static const String statusBlocked = 'Gesperrt';

  static const String contractStatusPlanned = 'Geplant';
  static const String contractStatusActive = 'Aktiv';
  static const String contractStatusCompleted = 'Abgeschlossen';
  static const String contractStatusCancelled = 'Storniert';

  static const String damageTypeAccident = 'Unfall';
  static const String damageTypeVandalism = 'Vandalismus';
  static const String damageTypeWear = 'Verschleiß';
  static const String damageTypeOther = 'Sonstiges';

  static const String damageCauseCustomer = 'Kunde';
  static const String damageCauseInternal = 'Intern';
  static const String damageCauseUnknown = 'Unbekannt';

  static const String loading = 'Daten werden geladen...';
  static const String errorGeneric = 'Die Daten konnten nicht geladen werden.';
  static const String emptyTrailers =
      'Keine Anhänger vorhanden. Legen Sie den ersten Anhänger an.';
  static const String emptyDamages =
      'Für diesen Anhänger sind keine Schäden erfasst.';
  static const String emptyCustomers = 'Keine Kunden vorhanden.';
  static const String emptyContracts = 'Keine Mietverträge vorhanden.';
  static const String emptySearch = 'Keine Ergebnisse für Ihre Suche.';
  static const String emptyDashboard =
      'Das Dashboard wird nach Festlegung der Kennzahlen umgesetzt.';
  static const String emptySettings =
      'Hier werden Benutzer, Anhängertypen und das Backup verwaltet.';
  static const String emptyDamagesOverview =
      'Schäden werden in der Detailansicht eines Anhängers erfasst.';

  static const String validationRequired = 'Dieses Feld ist erforderlich.';
  static const String validationEmail =
      'Bitte geben Sie eine gültige E-Mail-Adresse ein.';
  static const String validationDateRange =
      'Das Mietende muss nach dem Mietbeginn liegen.';

  static const String confirmDelete =
      'Möchten Sie diesen Eintrag wirklich löschen?';
  static const String saveSuccess = 'Die Änderungen wurden gespeichert.';

  static const String startupTitle = 'Willkommen';
  static const String startupSelectUser = 'Benutzer auswählen';
  static const String startupError =
      'Die Datenbank konnte nicht geöffnet werden.';
  static const String currentUser = 'Angemeldet als';

  static const String errorNotFound = 'Der Eintrag wurde nicht gefunden.';
  static const String errorDuplicateInternalCode =
      'Dieser interne Bezeichner ist bereits vergeben.';
  static const String errorDuplicateLicensePlate =
      'Dieses Kennzeichen ist bereits vergeben.';
  static const String errorDuplicateName = 'Dieser Name ist bereits vergeben.';
  static const String errorStatusChangeNotAllowed =
      'Der Status kann während einer laufenden Vermietung nicht geändert werden.';
  static const String errorRentedStatusManual =
      'Der Status „Vermietet“ wird nur durch die Übergabe eines Vertrags gesetzt.';
  static const String errorTrailerNotAvailable =
      'Der Anhänger ist nicht verfügbar.';
  static const String errorTrailerArchived =
      'Archivierte Anhänger können nicht vermietet werden.';
  static const String errorContractOverlap =
      'Der Anhänger ist in diesem Zeitraum bereits vermietet oder reserviert.';
  static const String errorContractNotEditable =
      'Nur geplante Verträge können bearbeitet werden.';
  static const String errorContractTransition =
      'Dieser Statuswechsel ist für den Vertrag nicht möglich.';
  static const String errorTrailerTypeInUse =
      'Dieser Anhängertyp wird noch von Anhängern verwendet.';
  static const String errorInvalidPrice = 'Der Betrag darf nicht negativ sein.';
  static const String errorTrailerHasOpenContracts =
      'Der Anhänger hat noch geplante oder aktive Verträge.';
  static const String errorCustomerHasOpenContracts =
      'Der Kunde hat noch geplante oder aktive Verträge.';
  static const String errorCustomerArchived =
      'Für archivierte Kunden können keine Verträge angelegt werden.';
}
