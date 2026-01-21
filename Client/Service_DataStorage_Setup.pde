
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

  // Load the previous fullness values into memory
  loadPreviousFullnessValues();
}



// We shortened this file's format.
//    Before, we had a specific "BINNY_USED" collumn, which stored a yes or no value.
//    However, we discovered that, by simply not storing anything in the "DETECTED_BIN" collumn if Binny was not used,
//    we store both the use of Binny and it's answer (as there'll always be one)

void createDisposalsTrackerTable() {
  
  // Create a new Table object
  disposalsTracker = new Table();
  
  // Create collumns for stored data
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
  fullnessTracker.addColumn("TIME");
  fullnessTracker.addColumn("RESIDUAL_BIN");
  fullnessTracker.addColumn("PLASTIC_BIN");
  // Here we would normally also add the other bins.
  
  // Save table named after today's date
  saveFullnessTrackerTable();
 
}


void loadPreviousFullnessValues() {
  int lastTableRowIndex = fullnessTracker.getRowCount() - 1;
  // println(lastTableRowIndex);

  if (lastTableRowIndex > 0) { // If there is a last valid row in the table
    // Load the data to memory.
    binFullness[0] = fullnessTracker.getString(lastTableRowIndex, "RESIDUAL_BIN");
    binFullness[1] = fullnessTracker.getString(lastTableRowIndex, "PLASTIC_BIN");
  }

  // Check if any of the data in memory is empty, and if so, set it to 0.
  for ( int i = 0; i < binFullness.length; i++ ) {
    if (binFullness[i] == null || binFullness[i] == "") binFullness[i] = "0";
  }

  // println(binFullness);

}


// void loadPreviousBinFullness() {

//   int lastTableRow = fullnessTracker.getRowCount();
//   if (lastTableRow > 0) { // If there is a valid previous row.
//     TableRow lastRow = fullnessTracker.getRow(lastTableRow);
//     if (lastRow != null) {
//       binFullness[0] = fullnessTracker.getString(lastTableRow, "RESIDUAL_BIN");
//       binFullness[1] = fullnessTracker.getString(lastTableRow, "PLASTIC_BIN");
//       // COMPLETE HERE WITH PAPER AND ORGANIC
//     }
//   }

//   // If no previous data is available, either due to a missing entry or a missing row, set to 0.
//   for (String value : binFullness) {
//     println(value);
//     if (value == "" || value == null) value = "0";
//   }
// }