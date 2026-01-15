import processing.serial.*;

void actOnDetection(String disposalCategory) {

  println("actOnDetection() Ran");

  // TODO: By setting the currentScene to a specific category, instead of calling on that scene directly, we allow processing to handle this request on it's own render loop.
  //       Because we're using Asynchronous calling, the result may come at an 'unfortunate' time for Processing and cause a plethora of visual bugs and glitches otherwise.

  // However, it should be safe to execute Arduino code on a separate CPU thread, as we are not listening for a result from the Microprocessors that would result in a visible change to the interface.
  
  switch (disposalCategory) {

    case "PLASTIC":  
    println("Ran Plastic.");
      currentScene = "PLASTIC";
      break;

    case "PAPER":
    println("Ran Paper.");
      currentScene = "PAPER";
      break;

    case "SERVICE_DESK":
    println("Ran ServiceDesk.");
      currentScene = "SERVICE_DESK";
      break;

    case "ORGANIC":
    println("Ran Organic.");
      currentScene = "ORGANIC";
      break;
    
    default:
      println("Ran Residual.");
      currentScene = "RESIDUAL";
      break;

  }

}