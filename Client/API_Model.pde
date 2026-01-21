
// █▀█ █▀▀ █▀█ █░█ █ █▀█ █▀▀ █▀▄▀█ █▀▀ █▄░█ ▀█▀ █▀
// █▀▄ ██▄ ▀▀█ █▄█ █ █▀▄ ██▄ █░▀░█ ██▄ █░▀█ ░█░ ▄█

// Importing the new Java HTTP Client, which is nicer to use than the older method(s).

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

import java.util.concurrent.CompletableFuture;

HttpClient client;
String detectAPI = "http://localhost:3000/detect";

// Name map for possible detection results
JSONObject nameMap;

// Look-up table that tells us where an item is supposed to be disposed.
JSONObject binMap;


void httpConnectionSetup() {
  // Create HTTP Client
  println("Attempting to create Http client");
  client = HttpClient.newHttpClient();
  println("Http client created!");
  
  // Load in JSON files.
  nameMap = loadJSONObject("tables/name_map.json");
  binMap = loadJSONObject("tables/bin_map.json");
}






// █▀█ █▀▀ █▀█ █░█ █▀▀ █▀ ▀█▀   █▀▄ █▀▀ ▀█▀ █▀▀ █▀▀ ▀█▀ █ █▀█ █▄░█
// █▀▄ ██▄ ▀▀█ █▄█ ██▄ ▄█ ░█░   █▄▀ ██▄ ░█░ ██▄ █▄▄ ░█░ █ █▄█ █░▀█


boolean processingDetection = false;
CompletableFuture<String> requestDetection(String filePath) {
  
  processingDetection = true;
  println("Client detection request");
  
  byte[] image = loadBytes(filePath);
  
  if (image == null) {
    println("Invalid image at filepath.");
    return null;
  }
  
  println("Image loaded in");
  
  // Huge thanks to baeldung.com for the guide on setting up the Java HTTP Client and sending POST requests through it.
  // https://www.baeldung.com/java-httpclient-post#bd-preparing-a-post-request

  // HTTP Request Body
  HttpRequest req = HttpRequest.newBuilder()
    .uri(URI.create(detectAPI))
    .header("Content-Type", "image/jpeg")
    .POST(HttpRequest.BodyPublishers.ofByteArray(image))
    .build();
  println("Http Request Built");

  // Send an asynchronous request to the server to analyze our object.
  return client.sendAsync(req, HttpResponse.BodyHandlers.ofString())
  
  .thenApply(res -> {
    int statusCode = res.statusCode();
    String detectionResult = res.body();
    
    println("Received Response from HTTP Server.");
    println("Status: " + statusCode);

    // Check if the response is an error. If so, log it to the console and show the error.
    if (statusCode >= 300) {
      println("Error Body: " + detectionResult);
      SHOW_ERROR(Integer.toString(statusCode), detectionResult);
    }    

    // Otherwise, return the detection result.
    return detectionResult;
  })

  // If there's an exception in the connection, use the CloudFlare status code and showcase it.
  .exceptionally(exception -> {
    println("Error Body: " + exception);
    SHOW_ERROR("522", exception.toString());
    return "-2";
  });
  
}




// █▀█ █▀█ █▀█ █▀▀ █▀▀ █▀ █▀   █▀█ █▀▀ █▀ █░█ █░░ ▀█▀ █▀
// █▀▀ █▀▄ █▄█ █▄▄ ██▄ ▄█ ▄█   █▀▄ ██▄ ▄█ █▄█ █▄▄ ░█░ ▄█


// Attribute the int result returned by the model with an actual object and disposal category.
void processModelResult(String result) {
  
  // Turn the String back into an integer. Used to determine errors (any result < 0 is an error/issue);
  int intResult = Integer.parseInt(result);
  
  // Any result smaller than -2 implies an error. If that's the case, we'll have a specific error splash screen.
  // But from the perspective of this method, nothing is relevant. Error handling happens before this point.
  if (intResult <= -2) return;
  
  // Set up default answers.
  String objectName = "N/A";
  String disposalCategory = "N/A";
  
  // Analyze result(s)
  if (intResult > 0 && intResult < 59) { // If the model detected something, then it will always return an integer between 0 and 59.
    objectName = nameMap.getString(result);
    disposalCategory = binMap.getString(result);
  }
  
  // Output result(s)
  println("==========================");
  println("Results of last detection:");
  println("Raw Int: " + result);
  println("Object Type: " + objectName);
  println("Disposal: " + disposalCategory);
  println("==========================");
  
  actOnDetection(disposalCategory);

}