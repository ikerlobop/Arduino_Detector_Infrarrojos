import processing.serial.*; // Importa la biblioteca para la comunicación serial
import java.awt.event.KeyEvent; // Importa la biblioteca para leer datos del puerto serial
import java.io.IOException;

Serial myPort; // Define el objeto Serial

// Define variables
String angle = "";
String distance = "";
String data = "";
String noObject;
float pixsDistance;
int iAngle, iDistance;
int index1 = 0;
int index2 = 0;
PFont orcFont;

void setup() {
  size(1200, 700); // ***CAMBIA RESOLUCIÓN***
  smooth();
  myPort = new Serial(this, "COM5", 9600); // Inicia la comunicación serial
  myPort.bufferUntil('.'); // Lee los datos del puerto serial hasta el carácter '.'. Así que realmente lee esto: ángulo, distancia.
}

void draw() {
  fill(98, 245, 31);
  // Simula el desenfoque de movimiento y el desvanecimiento lento de la línea en movimiento
  noStroke();
  fill(0, 4); 
  rect(0, 0, width, height - height * 0.065); 
  
  fill(98, 245, 31); // Color verde
  // Llama a las funciones para dibujar el radar
  drawRadar(); 
  drawLine();
  drawObject();
  drawText();
}

void serialEvent(Serial myPort) { // Comienza a leer datos del puerto serial
  // Lee los datos del puerto serial hasta el carácter '.' y los coloca en la variable de tipo String "data".
  data = myPort.readStringUntil('.');
  data = data.substring(0, data.length() - 1);
  
  index1 = data.indexOf(","); // Encuentra el carácter ',' y lo coloca en la variable "index1"
  angle = data.substring(0, index1); // Lee los datos desde la posición "0" hasta la posición de la variable index1 o ese es el valor del ángulo que la placa Arduino envió al puerto serial
  distance = data.substring(index1 + 1, data.length()); // Lee los datos desde la posición "index1" hasta el final de los datos o ese es el valor de la distancia
  
  // Convierte las variables String a enteros
  iAngle = int(angle);
  iDistance = int(distance);
}

void drawRadar() {
  pushMatrix();
  translate(width / 2, height - height * 0.074); // Mueve las coordenadas iniciales a una nueva ubicación
  noFill();
  strokeWeight(2);
  stroke(98, 245, 31);
  // Dibuja las líneas de arco
  arc(0, 0, (width - width * 0.0625), (width - width * 0.0625), PI, TWO_PI);
  arc(0, 0, (width - width * 0.27), (width - width * 0.27), PI, TWO_PI);
  arc(0, 0, (width - width * 0.479), (width - width * 0.479), PI, TWO_PI);
  arc(0, 0, (width - width * 0.687), (width - width * 0.687), PI, TWO_PI);
  // Dibuja las líneas de ángulo
  line(-width / 2, 0, width / 2, 0);
  line(0, 0, (-width / 2) * cos(radians(30)), (-width / 2) * sin(radians(30)));
  line(0, 0, (-width / 2) * cos(radians(60)), (-width / 2) * sin(radians(60)));
  line(0, 0, (-width / 2) * cos(radians(90)), (-width / 2) * sin(radians(90)));
  line(0, 0, (-width / 2) * cos(radians(120)), (-width / 2) * sin(radians(120)));
  line(0, 0, (-width / 2) * cos(radians(150)), (-width / 2) * sin(radians(150)));
  line((-width / 2) * cos(radians(30)), 0, width / 2, 0);
  popMatrix();
}

void drawObject() {
  pushMatrix();
  translate(width / 2, height - height * 0.074); // Mueve las coordenadas iniciales a una nueva ubicación
  strokeWeight(9);
  stroke(255, 10, 10); // Color rojo
  pixsDistance = iDistance * ((height - height * 0.1666) * 0.025); // Convierte la distancia del sensor de cm a píxeles
  // Limita el rango a 40 cm
  if (iDistance < 40) {
    // Dibuja el objeto de acuerdo al ángulo y la distancia
    line(pixsDistance * cos(radians(iAngle)), -pixsDistance * sin(radians(iAngle)), (width - width * 0.505) * cos(radians(iAngle)), -(width - width * 0.505) * sin(radians(iAngle)));
  }
  popMatrix();
}

void drawLine() {
  pushMatrix();
  strokeWeight(9);
  stroke(30, 250, 60);
  translate(width / 2, height - height * 0.074); // Mueve las coordenadas iniciales a una nueva ubicación
  line(0, 0, (height - height * 0.12) * cos(radians(iAngle)), -(height - height * 0.12) * sin(radians(iAngle))); // Dibuja la línea de acuerdo al ángulo
  popMatrix();
}

void drawText() { // Dibuja los textos en la pantalla
  pushMatrix();
  if (iDistance > 40) {
    noObject = "Fuera de Rango";
  } else {
    noObject = "Dentro del Rango";
  }
  fill(0, 0, 0);
  noStroke();
  rect(0, height - height * 0.0648, width, height);
  fill(98, 245, 31);
  textSize(25);
  
  text("10cm", width - width * 0.3854, height - height * 0.0833);
  text("20cm", width - width * 0.281, height - height * 0.0833);
  text("30cm", width - width * 0.177, height - height * 0.0833);
  text("40cm", width - width * 0.0729, height - height * 0.0833);
  textSize(40);
  text("Espacio de César", width - width * 0.875, height - height * 0.0277);
  text("Ángulo: " + iAngle + " °", width - width * 0.48, height - height * 0.0277);
  text("Dist:", width - width * 0.26, height - height * 0.0277);
  if (iDistance < 40) {
    text("        " + iDistance + " cm", width - width * 0.225, height - height * 0.0277);
  }
  textSize(25);
  fill(98, 245, 60);
  translate((width - width * 0.4994) + width / 2 * cos(radians(30)), (height - height * 0.0907) - width / 2 * sin(radians(30)));
  rotate(-radians(-60));
  text("30°", 0, 0);
  resetMatrix();
  translate((width - width * 0.503) + width / 2 * cos(radians(60)), (height - height * 0.0888) - width / 2 * sin(radians(60)));
  rotate(-radians(-30));
  text("60°", 0, 0);
  resetMatrix();
  translate((width - width * 0.507) + width / 2 * cos(radians(90)), (height - height * 0.0833) - width / 2 * sin(radians(90)));
  rotate(radians(0));
  text("90°", 0, 0);
  resetMatrix();
  translate(width - width * 0.513 + width / 2 * cos(radians(120)), (height - height * 0.07129) - width / 2 * sin(radians(120)));
  rotate(radians(-30));
  text("120°", 0, 0);
  resetMatrix();
  translate((width - width * 0.5104) + width / 2 * cos(radians(150)), (height - height * 0.0574) - width / 2 * sin(radians(150)));
  rotate(radians(-60));
  text("150°", 0, 0);
  popMatrix(); 
}
