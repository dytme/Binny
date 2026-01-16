
// █▀█ █▀▀ █▀█ █░█ █ █▀█ █▀▀ █▀▄▀█ █▀▀ █▄░█ ▀█▀ █▀
// █▀▄ ██▄ ▀▀█ █▄█ █ █▀▄ ██▄ █░▀░█ ██▄ █░▀█ ░█░ ▄█

import processing.serial.*;

/*
Processing Serial Library
@ Processing Foundation
Licensed under Creative Commons (CC BY-NC-SA 4.0)
https://processing.org/reference/libraries/serial/index.html
*/

Serial bin1; // Residual Waste Bin // Index 0
Serial bin2; // Plastic Waste Bin  // Index 1

String portBin1 = Serial.list()[0]; //com #
String portBin2 = Serial.list()[3]; //com #




// █▀ █▀▀ ▀█▀ ▀█▀ █ █▄░█ █▀▀ █▀
// ▄█ ██▄ ░█░ ░█░ █ █░▀█ █▄█ ▄█


int baudrate = 9600;
int numberOfBins = 2;




// █▀ ▀█▀ ▄▀█ ▀█▀ █▀▀ █▀
// ▄█ ░█░ █▀█ ░█░ ██▄ ▄█

boolean waitingThrow = false;
BinType expectedBin;

enum BinType {
	RESIDUAL,
	PLASTIC
}




// █▀ █▀▀ ▀█▀ █░█ █▀█
// ▄█ ██▄ ░█░ █▄█ █▀▀


// Print out the current active serial connections and setup connections for both.
void serialSetup() {
	// println(Serial.list());
	bin1 = new Serial(this, portBin1, baudrate);
	bin2 = new Serial(this, portBin2, baudrate);

	println("Residual waste bin connected to port"+ portBin1);
	println("Plastic waste bin connected to port"+ portBin2);
}




// █▀▀ █▀█ █▀█ █░█░█ ▄▀█ █▀█ █▀▄   █▀█ █▀▀ █▀ █░█ █░░ ▀█▀   ▀█▀ █▀█   █▄▄ █ █▄░█ █▀
// █▀░ █▄█ █▀▄ ▀▄▀▄▀ █▀█ █▀▄ █▄▀   █▀▄ ██▄ ▄█ █▄█ █▄▄ ░█░   ░█░ █▄█   █▄█ █ █░▀█ ▄█

void INFORM_RESIDUAL_BIN() {
	bin1.write('H');
	expectedBin = BinType.RESIDUAL;
    waitingThrow = true;
}

void INFORM_PLASTIC_BIN() {
	bin2.write('H');
	expectedBin = BinType.PLASTIC;
	waitingThrow = true;
}




// █░░ █ █▀ ▀█▀ █▀▀ █▄░█   █▀▀ █▀█ █▀█   ▄▀█ █▀█ █▀▄ █░█ █ █▄░█ █▀█   █▀█ █▀▀ █▀ █▀█ █▀█ █▄░█ █▀ █▀▀
// █▄▄ █ ▄█ ░█░ ██▄ █░▀█   █▀░ █▄█ █▀▄   █▀█ █▀▄ █▄▀ █▄█ █ █░▀█ █▄█   █▀▄ ██▄ ▄█ █▀▀ █▄█ █░▀█ ▄█ ██▄

void serialEvent(Serial which) {


	String read = which.readStringUntil('\n'); //read the characters from THIS serial port until end of line
	if ( read == null) return ;
	read = trim(read);

	// Why are we disregarding "1"?
	if (!read.equals("1")) return;


	BinType actualBin;
	if (which == bin1) actualBin = BinType.RESIDUAL; // Graph used to be updated here.
	else actualBin = BinType.PLASTIC;

	if (waitingThrow) { // If we're waiting on input from the last throw.
						// i.e. if Binny has been used in this particular disposal event
						// TODO: Add a TimeOut to waitingThrow so we don't wait forever.

		// Track the disposal, mentioning the use and result of Binny
		trackDisposal(actualBin.name(), true, expectedBin.name());
		waitingThrow = false;

	} else { trackDisposal(actualBin.name(), false, null); } // If Binny wasn't used, just track whatever item was thrown out.
}

