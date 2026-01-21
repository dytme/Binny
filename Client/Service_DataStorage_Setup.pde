
// █▀ █▀▀ ▀█▀ █░█ █▀█
// ▄█ ██▄ ░█░ █▄█ █▀▀


void dataStorageSetup() {
  
  // Get the current time & date
  updateCurrentTime();
  updateCurrentDate();
  // Format will be "YYYY-MM-DD"
  
  // Attempt to load today's CSV tables.
  disposalsTracker = loadTable(("data/data_tracking/disposals/" + currentDate + ".csv"), "header");
  fullnessTracker = loadTable(("data/data_tracking/fullness/" + currentDate + ".csv"), "header");
  
  // If one or more of the tables don't exist for today's date, then create some!
  if (disposalsTracker == null) createDisposalsTrackerTable();
  if (fullnessTracker == null) createFullnessTrackerTable();
}



// We shortened this file's format.
//    Before, we had a specific "BINNY_USED" collumn, which stored a yes or no value.
//    However, we discovered that, by simply not storing anything in the "DETECTED_BIN" collumn if Binny was not used,
//    we store both the use of Binny and it's answer (as there'll always be one)

void createDisposalsTrackerTable() {
  
  // Create a new Table object
  disposalsTracker = new Table();
  
  // Create collumns for stored data
  disposalsTracker.addColumn("ID");
  disposalsTracker.addColumn("TIME");
  disposalsTracker.addColumn("TARGET_BIN");
  disposalsTracker.addColumn("DETECTED_BIN");
  
  // Save table named after today's date
  println("Creating disposal tracker");
  saveDisposalsTrackerTable();
}


void createFullnessTrackerTable() {
  
  // Create a new Table object
  fullnessTracker = new Table();
  
  // Create collumns for stored data
  fullnessTracker.addColumn("ID");
  fullnessTracker.addColumn("TIME");
  fullnessTracker.addColumn("RESIDUAL_BIN");
  fullnessTracker.addColumn("PLASTIC_BIN");
  // Here we would normally also add the other bins.
  
  // Save table named after today's date
  saveFullnessTrackerTable();
 
}