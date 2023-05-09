#include <Servo.h> // Importamos la librería para utilizar el servo
Servo myServo; // Declaramos el objeto del servo

const int SENSOR_PIN = A1; // Definimos el pin A1 como el pin de entrada del sensor IR
const int SERVO_PIN = 9; // Definimos el pin 9 como el pin de salida del servo
const int AUDIO_PIN = 5; // Definimos el pin 5 como el pin de salida del buzzer

int distance; // Variable para almacenar la distancia medida por el sensor

void setup()
{
  pinMode(AUDIO_PIN, OUTPUT); // Configuramos el pin del buzzer como salida
  pinMode(SENSOR_PIN, INPUT); // Configuramos el pin del sensor como entrada
  Serial.begin(9600); // Inicializamos la comunicación serie a 9600 baudios
  myServo.attach(SERVO_PIN); // Configuramos el pin del servo como salida a través del objeto
}

void loop()
{
  // Giramos el servo en sentido horario de 0 a 180 grados
  for (int i = 0; i <= 180; i++) {
    myServo.write(i); // Movemos el servo a la posición i
    delay(15); // Esperamos un corto tiempo para dar tiempo al servo a moverse
    distance = measureDistance(); // Medimos la distancia desde el sensor IR
    // En función de la distancia medida, emitimos un sonido característico a través del buzzer
    if (distance <= 10) {
      tone(AUDIO_PIN, 3000, 200);
    } else if (distance <= 20) {
      tone(AUDIO_PIN, 2000, 150);
    } else if (distance <= 30) {
      tone(AUDIO_PIN, 1000, 100);
    }
    // Imprimimos en el monitor serie el ángulo del servo y la distancia medida
    Serial.print(i);
    Serial.print(",");
    Serial.println(distance);
  }

  // Giramos el servo en sentido antihorario de 180 a 0 grados
  for (int i = 179; i > 0; i--) {
    myServo.write(i); // Movemos el servo a la posición i
    delay(15); // Esperamos un corto tiempo para dar tiempo al servo a moverse
    distance = measureDistance(); // Medimos la distancia desde el sensor IR
    // En función de la distancia medida, emitimos un sonido característico a través del buzzer
    if (distance <= 10) {
      tone(AUDIO_PIN, 3000, 200);
    } else if (distance <= 20) {
      tone(AUDIO_PIN, 2000, 150);
    } else if (distance <= 30) {
      tone(AUDIO_PIN, 1000, 100);
    }
    // Imprimimos en el monitor serie el ángulo del servo y la distancia medida
    Serial.print(i);
    Serial.print(",");
    Serial.println(distance);
  }
}

int measureDistance() {
  long totalCm = 0; // Variable para almacenar la suma de las distancias obtenidas
  int cm = 0; // Variable para almacenar la distancia actual medida en centímetros
  for (int i = 0; i < 50; i++) { // Hacemos 50 mediciones para obtener una medida más precisa
    int adc = analogRead(SENSOR_PIN); // Obtenemos la lectura del sensor infrarrojo
    cm = (6762 / (adc - 9)) - 4; // Convertimos la lectura a una distancia en centímetros usando la fórmula del datasheet
    totalCm += cm; // Añadimos la distancia actual a la suma total
  }
  cm = totalCm / 50; // Calculamos la distancia promedio de las 50 mediciones
  if (cm > 80) { // Si la distancia medida es mayor a 80 cm, la consideramos como 80 cm
    cm = 80;
  }
  return cm; // Devolvemos la distancia medida en centímetros
}
