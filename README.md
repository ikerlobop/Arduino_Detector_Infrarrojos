# Arduino_Detector_Infrarrojos
# Proyecto de Radar con Servo y Sensor Infrarrojo

Este proyecto utiliza un sensor infrarrojo (IR) para medir la distancia de objetos en el entorno y un servo para girar el sensor de izquierda a derecha en un rango de 180 grados. Dependiendo de la distancia medida, se emite un sonido a través de un buzzer. Los datos de ángulo y distancia se envían al monitor serie para su visualización.

## Componentes necesarios

- Arduino Uno o similar
- Servo motor
- Sensor de distancia infrarrojo (IR)
- Buzzer
- Cables de conexión
- Resistencia (si es necesario, dependiendo del buzzer)

## Instalación y configuración

1. **Conectar los componentes:**
   - **Servo Motor:** Conectar el pin de señal del servo al pin digital 9 del Arduino.
   - **Sensor IR:** Conectar el pin de salida del sensor IR al pin analógico A1 del Arduino.
   - **Buzzer:** Conectar el buzzer al pin digital 5 del Arduino.

2. **Instalar el IDE de Arduino:** Si no lo has hecho ya, descarga e instala el [IDE de Arduino](https://www.arduino.cc/en/software).

3. **Instalar la librería Servo:** Asegúrate de que la librería `Servo` esté instalada. Esta librería viene preinstalada con el IDE de Arduino.

4. **Cargar el código en Arduino:**
   - Abre el archivo `Radar_Servo_IR.ino` en el IDE de Arduino.
   - Selecciona la placa y el puerto correctos en el menú `Herramientas`.
   - Carga el código en tu placa Arduino.

## Archivos del proyecto

### 1. `Radar_Servo_IR.ino`

Este archivo contiene el código para controlar el servo, medir la distancia utilizando el sensor IR y emitir sonidos a través de un buzzer. Aquí hay un resumen de su funcionamiento:

- **Incluye la librería Servo** para controlar el motor servo.
- **Inicializa los pines** del sensor IR, el servo, y el buzzer.
- En el **`setup()`**, se configura la comunicación serie, el pin del buzzer, y se adjunta el pin del servo.
- En el **`loop()`**, el servo se mueve de 0 a 180 grados y de vuelta, midiendo la distancia en cada paso. Dependiendo de la distancia medida, se emite un tono a través del buzzer:
  - Si la distancia es menor o igual a 10 cm, se genera un tono de 3000 Hz durante 200 ms.
  - Si la distancia es menor o igual a 20 cm, se genera un tono de 2000 Hz durante 150 ms.
  - Si la distancia es menor o igual a 30 cm, se genera un tono de 1000 Hz durante 100 ms.
- **`measureDistance()`** es una función que mide la distancia utilizando el sensor IR y devuelve la distancia promedio después de 50 lecturas.

### 2. `RadarVisualizer.pde`

Este archivo es un sketch de Processing que permite visualizar los datos de ángulo y distancia recibidos del Arduino. Aquí hay un resumen de su funcionamiento:

- **Inicializa la comunicación serie** con el puerto COM correspondiente.
- En el **`setup()`**, se configura la ventana de visualización y se establece la comunicación serie.
- En el **`draw()`**, se actualiza la visualización del radar, las líneas de ángulo, los objetos detectados y el texto basado en los datos recibidos.
- **Funciones de dibujo** como `drawRadar()`, `drawObject()`, `drawLine()`, y `drawText()` se encargan de dibujar el radar y los objetos en pantalla.
- **`serialEvent()`** procesa los datos recibidos del Arduino para actualizar las visualizaciones en Processing.

## Ejecución

1. **Cargar el código en Arduino:** Sigue las instrucciones de instalación y configuración mencionadas anteriormente.
2. **Abrir Processing:** Abre el archivo `RadarVisualizer.pde` en el IDE de Processing.
3. **Ejecutar el sketch de Processing:** Haz clic en el botón de ejecutar en Processing. Deberías ver una visualización en tiempo real del radar, mostrando el ángulo del servo y la distancia medida por el sensor IR.

## Licencia

Este proyecto está bajo la licencia MIT. Consulta el archivo `LICENSE` para obtener más detalles.

## Contribuciones

Las contribuciones son bienvenidas. Siéntete libre de abrir un issue o enviar una pull request para mejoras o correcciones.

## Créditos

Este proyecto fue desarrollado por [Iker Lobo](https://github.com/ikerlobop) con la colaboración de Lander Agustín, como una demostración de cómo usar un sensor IR, un servo y un buzzer con Arduino, para la asignatura de Sistemas de medida y regulación, impartida por Ander Duque.
