import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/src/services/hardware_keyboard.dart';
import 'package:flutter/src/services/keyboard_key.g.dart';

class MiSprite extends SpriteAnimationComponent with KeyboardHandler {

  final Vector2 screenSize;
  MiSprite(this.screenSize) : super(size: Vector2.all(100));

  double posicionX = 0;
  double posicionY = 0;

  double velocidad = 200;
  bool mirandoDerecha = true;
  int direccion = 0; // 0 quieto, -1 izquierda, 1 derecha

  final double spriteSheetWidth = 405; // Alto del Sprite
  final double spriteSheetHeight = 534; // Ancho del Sprite

  late SpriteAnimation calabazaIdle;
  late SpriteAnimation calabazaWalk;

  @override
  Future<void> onLoad() async{ //esta sería la posicion inicial
    calabazaIdle = await crearAnimacion('calabaza_idle.png', 2, 5);
    calabazaWalk = await crearAnimacion('calabaza_walk.png', 2, 5);

    animation = calabazaIdle; // Animación inicial
    return super.onLoad();
  }

  //TODO: Método para crear Animación
  Future<SpriteAnimation> crearAnimacion(String ruta, int filas, int columnas) async{
    final spriteImage = await Flame.images.load(ruta); // Cargamos la imagen del sprite
    final spriteSheet = SpriteSheet(image: spriteImage, srcSize: Vector2(spriteSheetWidth, spriteSheetHeight));

    List<Sprite> sprites = [];

    for (int i = 0; i < filas; i++) {
      for (int j = 0; j < columnas; j++) {
        sprites.add(spriteSheet.getSprite(i, j));
      }
    }

    return SpriteAnimation.spriteList(sprites, stepTime: 0.2);
  }

  @override
  void update(double dt){
    position.x += velocidad * dt * direccion;
    position.y = 300;
    super.update(dt);
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      if(mirandoDerecha){
        flipHorizontally(); // Rota Horizontalmente
        mirandoDerecha = false;
      }
      direccion = -1;
      animation = calabazaWalk;

    } else if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      if(!mirandoDerecha){
        flipHorizontally();
        mirandoDerecha = true;
      }
      direccion = 1;
      animation = calabazaWalk;

    } else if(keysPressed.isEmpty){
      direccion = 0;
      animation = calabazaIdle;
    }
    return false;
  }
}
