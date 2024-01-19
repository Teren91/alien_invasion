
import 'package:alien_invasion/src/components/bullet.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:alien_invasion/src/alien_invasion.dart';
import 'package:alien_invasion/src/components/components.dart';
import 'package:alien_invasion/settings/components_settings.dart';

class Alien extends RectangleComponent
  with CollisionCallbacks, HasGameReference<AlienInvasion>
{
  Alien(
  {
    required this.velocity,
    required super.position,
    required super.size,
    required this.alienMoveToRight,
   // required this.difficultyModifier,
  })
    : super(
      anchor: Anchor.center,
      children: [RectangleHitbox()] 
    );

  final Vector2 velocity;
  double alienMoveToRight;


  @override
  void update(double dt)
  {
    super.update(dt);
    position += velocity * alienMoveToRight;
  }


  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints, PositionComponent other)
  {
    super.onCollisionStart(intersectionPoints, other);

    if(other is PlayArea)
    {
      //Si el alien choca con el borde derecho o izquierdo, se invierte la dirección
      if(intersectionPoints.first.x >= game.width || intersectionPoints.first.x <= 0)
      {
        alienDrop();
      }else if(intersectionPoints.first.y >= game.height)
      {

        add(RemoveEffect(
          delay: 0.35,
          onComplete: () {
           // game.playState = PlayState.gameOver;           
           removeFromParent();
           debugPrint('Alien destroy from $other');
          },
        ));
      }
    }else if (other is Bullet){
      removeFromParent();
      other.removeFromParent();  
    }else {
      debugPrint('Collision with $other');
    }
  }
 
  //Función que hace que los aliens bajen una fila y cambien de dirección
  void alienDrop()
  {    
      game.world.children.query<Alien>().forEach((alien) {
        alien.velocity.x = -alien.velocity.x;
        alien.position.y = alien.position.y + alienHeight ;
      });
  }
  
}