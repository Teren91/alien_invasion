

import 'dart:ui';

import 'package:flame/effects.dart';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';



import 'package:alien_invasion/src/alien_invasion.dart';
import 'package:alien_invasion/src/components/components.dart';
import 'package:alien_invasion/settings/components_settings.dart';
import 'package:flame/flame.dart';

class Alien extends SpriteComponent
  with CollisionCallbacks, HasGameReference<AlienInvasion>
{
  Alien(
  {
    required this.velocity,
    required super.position,
    required super.size,
    required this.alienMoveToRight
   // required this.difficultyModifier,
  })
    : super(
      anchor: Anchor.center,
     // paint: Paint()..color = Palette().alien.color,
      children: [RectangleHitbox()] ,
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

        endGame(false);
      }
    }else if (other is Bullet){
      removeFromParent();
      other.removeFromParent();  

      if(winCondition())
      {
        endGame(true);
      }

    }else {
    //  debugPrint('Collision with $other');
    }
  }

  @override
  Future<void> onLoad() async
  {
    super.onLoad();  
    
    Image image = await Flame.images.load('enemy/ufo_mad.png');
    final alienSprite = Sprite(image);  
    
    sprite = alienSprite;
  }


  //Función que hace que los aliens bajen una fila y cambien de dirección
  void alienDrop()
  {    
      game.world.children.query<Alien>().forEach((alien) {
        alien.velocity.x = -alien.velocity.x * gameDificulty;
        alien.position.y = alien.position.y + (alienHeight / 2) ;
        
      });
  }

  bool winCondition()
  {
    if(game.world.children.query<Alien>().length == 1)
    {
      return true;
    }else{
      return false;
    }
  }

  void endGame(bool win)
  {
    if(win)
    {
      game.playState = PlayState.win;
    }else{
      game.playState = PlayState.gameOver;
    }
    game.world.removeAll(game.world.children.query<Player>());
    game.world.removeAll(game.world.children.query<Bullet>());
    game.world.removeAll(game.world.children.query<Alien>());
  }
  
}