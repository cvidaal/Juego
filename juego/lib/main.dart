import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/services/keyboard_key.g.dart';
import 'package:juego/micanvas.dart';
import 'package:juego/misprite.dart';

void main() {
  runApp(GameWidget(game: MyGame()));
}

class MyGame extends FlameGame with KeyboardEvents, HasKeyboardHandlerComponents{
  late Vector2 screenSize;

  @override
  FutureOr<void> onLoad() {
    screenSize = size;
    //add(Micanvas()); // Añadimos el circulo rojo que hemos creado
    add(MiSprite(screenSize)); // Añadimos el sprite de la clase Sprite
    return super.onLoad();
  }

  @override
  KeyEventResult onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    print(keysPressed);
    return super.onKeyEvent(event, keysPressed);
  }

}
