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

  static const String actionBack = 'Zurück';
  static const String actionOpen = 'Öffnen';
  static const String actionRename = 'Umbenennen';
  static const String actionRestore = 'Wiederherstellen';

  static const String none = '–';
  static const String archived = 'Archiviert';
  static const String deleted = 'Der Eintrag wurde gelöscht.';
  static const String deletedArchived =
      'Der Eintrag wurde gelöscht und ins Archiv verschoben.';
  static const String restored = 'Der Eintrag wurde wiederhergestellt.';
  static const String selectPlaceholder = 'Bitte auswählen';
  static const String filterAll = 'Alle';
  static const String filterShowArchived = 'Archivierte anzeigen';
  static const String days = 'Tage';
  static const String rentals = 'Vermietungen';
  static const String defaultLocation = 'Hof Nord';

  static const String fieldName = 'Name';
  static const String fieldStatus = 'Status';
  static const String fieldNumber = 'Nr.';
  static const String fieldInternalCode = 'Interner Bezeichner';
  static const String fieldLicensePlate = 'Kennzeichen';
  static const String fieldTrailerType = 'Anhängertyp';
  static const String fieldTrailer = 'Anhänger';
  static const String fieldLocation = 'Standort';
  static const String fieldAddress = 'Adresse';
  static const String fieldLatitude = 'Breitengrad';
  static const String fieldLongitude = 'Längengrad';
  static const String fieldCoordinates = 'Koordinaten';
  static const String fieldCreatedAt = 'Angelegt am';
  static const String fieldUpdatedAt = 'Aktualisiert am';
  static const String fieldFirstName = 'Vorname';
  static const String fieldLastName = 'Nachname';
  static const String fieldEmail = 'E-Mail';
  static const String fieldPhone = 'Telefon';
  static const String fieldStreet = 'Straße und Hausnummer';
  static const String fieldPostalCode = 'PLZ';
  static const String fieldCity = 'Ort';
  static const String fieldLicenseNumber = 'Führerscheinnummer';
  static const String fieldCustomer = 'Kunde';
  static const String fieldStartAt = 'Mietbeginn';
  static const String fieldEndAt = 'Mietende';
  static const String fieldPeriod = 'Zeitraum';
  static const String fieldPickupLocation = 'Abholort';
  static const String fieldReturnLocation = 'Rückgabeort';
  static const String fieldPrice = 'Preis';
  static const String fieldPriceEuro = 'Preis in Euro';
  static const String fieldDate = 'Datum';
  static const String fieldDamageType = 'Schadensart';
  static const String fieldCausedBy = 'Verursacher';
  static const String fieldDescription = 'Beschreibung';
  static const String fieldCost = 'Kosten';
  static const String fieldCostEuro = 'Kosten in Euro';

  static const String placeholderInternalCode = 'z. B. BLITZ-01';
  static const String placeholderLicensePlate = 'z. B. DD-AH 101';
  static const String placeholderAddress = 'z. B. Hof Nord, Stellplatz 3';
  static const String placeholderLatitude = 'z. B. 51,0504';
  static const String placeholderLongitude = 'z. B. 13,7373';
  static const String placeholderMoney = 'z. B. 49,90';

  static const String validationMoney =
      'Bitte einen Betrag wie 49,90 eingeben.';
  static const String validationCoordinate =
      'Bitte eine gültige Koordinate eingeben.';

  static const String periodAll = 'Gesamter Zeitraum';
  static const String periodLast30Days = 'Letzte 30 Tage';
  static const String periodLast12Months = 'Letzte 12 Monate';
  static const String periodThisYear = 'Dieses Jahr';

  static const String sectionOverview = 'Übersicht';
  static const String sectionPhotos = 'Fotos';
  static const String sectionDamageHistory = 'Schadenshistorie';
  static const String sectionContracts = 'Mietverträge';
  static const String sectionStatusHistory = 'Statusverlauf';
  static const String sectionContactData = 'Kontaktdaten';

  static const String trailerCreate = 'Anhänger hinzufügen';
  static const String trailerEdit = 'Anhänger bearbeiten';
  static const String trailerSearch =
      'Suchen nach Bezeichner, Kennzeichen oder Typ';
  static const String trailerChangeStatus = 'Status ändern';
  static const String trailerChangeLocation = 'Standort ändern';
  static const String trailerStatusHint =
      '„Vermietet“ wird automatisch bei der Übergabe eines Vertrags gesetzt.';
  static const String trailerDeleteConfirm =
      'Der Anhänger wird gelöscht und ins Archiv verschoben. Verträge und Schäden bleiben erhalten. Über „Archivierte anzeigen“ kann er wiederhergestellt werden.';

  static const String photoAdd = 'Foto hinzufügen';
  static const String photoReplace = 'Foto ersetzen';
  static const String photosEmpty = 'Noch keine Fotos vorhanden.';

  static const String damageCreate = 'Schaden erfassen';
  static const String damageEdit = 'Schaden bearbeiten';
  static const String damagePhotosAfterSave =
      'Fotos können nach dem Speichern über „Bearbeiten“ hinzugefügt werden.';

  static const String customerCreate = 'Kunde hinzufügen';
  static const String customerEdit = 'Kunde bearbeiten';
  static const String customerSearch =
      'Suchen nach Name, E-Mail, Telefon oder Ort';
  static const String customerDeleteConfirm =
      'Der Kunde wird gelöscht und ins Archiv verschoben. Die Vertragshistorie bleibt erhalten.';

  static const String contractCreate = 'Vertrag anlegen';
  static const String contractEdit = 'Vertrag bearbeiten';
  static const String contractHandOver = 'Übergeben';
  static const String contractHandOverConfirm =
      'Den Anhänger jetzt an den Kunden übergeben? Der Anhänger wird auf „Vermietet“ gesetzt.';
  static const String contractHandedOver =
      'Der Anhänger wurde übergeben.';
  static const String contractReturn = 'Rücknahme';
  static const String contractReturnConfirm =
      'Den Anhänger jetzt zurücknehmen? Der Vertrag wird abgeschlossen und der Anhänger ist wieder verfügbar.';
  static const String contractReturned =
      'Der Anhänger wurde zurückgenommen.';
  static const String contractCancel = 'Stornieren';
  static const String contractCancelConfirm =
      'Möchten Sie diesen Vertrag wirklich stornieren?';
  static const String contractCancelled = 'Der Vertrag wurde storniert.';

  static const String dashboardFleet = 'Fuhrpark';
  static const String dashboardFinance = 'Vermietung und Umsatz';
  static const String dashboardUtilization = 'Auslastung';
  static const String dashboardThisMonth = 'im aktuellen Monat';
  static const String dashboardRevenueYtd = 'Umsatz seit Jahresbeginn';
  static const String dashboardRentalsYtd = 'Vermietungen seit Jahresbeginn';
  static const String dashboardPreviousYear = 'Vorjahr';
  static const String dashboardOpenContracts = 'Offene Verträge';
  static const String dashboardOpenValue = 'Wert offener Verträge';
  static const String dashboardAverageDuration = 'Ø Mietdauer';
  static const String dashboardRentalsPerMonth =
      'Vermietungen pro Monat (12 Monate)';
  static const String dashboardRevenuePerMonth = 'Umsatz pro Monat (12 Monate)';
  static const String dashboardPopularTypes = 'Beliebteste Anhängertypen';
  static const String dashboardReport = 'Bericht Anhänger-Verwaltung';
  static const String dashboardMonth = 'Monat';
  static const String dashboardRevenue = 'Umsatz';

  static const String settingsUsers = 'Benutzer';
  static const String settingsTrailerTypes = 'Anhängertypen';
  static const String settingsBackup = 'Datensicherung und Beispieldaten';
  static const String userCreate = 'Benutzer hinzufügen';
  static const String userActive = 'Aktiv';
  static const String userInactive = 'Deaktiviert';
  static const String userActivate = 'Aktivieren';
  static const String userDeactivate = 'Deaktivieren';
  static const String userDeactivateSelf =
      'Der angemeldete Benutzer kann nicht deaktiviert werden.';
  static const String trailerTypeCreate = 'Anhängertyp hinzufügen';
  static const String backupDescription =
      'Die Sicherung enthält die Datenbank und alle Fotos. Sie wird als Ordner im gewählten Verzeichnis angelegt. Beispieldaten werden nur geladen, wenn noch keine Anhänger, Kunden und Verträge existieren.';
  static const String backupExport = 'Sicherung erstellen';
  static const String backupImport = 'Sicherung einspielen';
  static const String backupExportDone = 'Sicherung gespeichert unter';
  static const String backupExportFailed =
      'Die Sicherung konnte nicht erstellt werden.';
  static const String backupInvalidFolder =
      'Der gewählte Ordner ist keine Sicherung (database/app.sqlite fehlt).';
  static const String backupImportConfirm =
      'Alle aktuellen Daten werden durch die Sicherung ersetzt. Die Anwendung startet danach neu. Fortfahren?';
  static const String sampleDataLoad = 'Beispieldaten laden';
  static const String sampleDataLoaded = 'Die Beispieldaten wurden geladen.';
  static const String sampleDataNotEmpty =
      'Es sind bereits Daten vorhanden. Beispieldaten werden nur in eine leere Datenbank geladen.';

  static const String exportDone = 'Die Datei wurde exportiert.';
  static const String exportContractsFile = 'vertraege.csv';
  static const String exportReportFile = 'bericht.csv';
  static const String fileTypeCsv = 'CSV-Datei';
  static const String fileTypeImages = 'Bilder';
  static const String errorFile =
      'Die Datei konnte nicht gelesen oder geschrieben werden.';
}
