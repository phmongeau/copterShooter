package
{
	import org.flixel.*;
	
	public class Dirigible extends FlxSprite
	{
		[Embed(source = '/data/dirigible.png')] private var ImgShip:Class;
		[Embed(source = '/data/explosion.png')] private var ImgExpl:Class;
		
		private var bullets:Array;
		
		public var holle:Array;
		public var topBumper:FlxCore;
		public var bottomBumper:FlxCore;
		public var ship:FlxSprite;
		
		private var e:FlxEmitter;
		private var attackTimer:Number = 0;
		
		public function Dirigible(X:int, Y:int, Bullets:Array, Ship:FlxSprite):void
		{
			super(X, Y);
			loadGraphic(ImgShip, false, true, 50, 25);
			bullets = Bullets;
			drag.y = 400;
			velocity.y = 100;
			
			holle = new Array;
			topBumper = new FlxCore;
			topBumper.reset(x + 55, y - 10)
			bottomBumper = new FlxCore;
			bottomBumper.reset(x + 55, y + 35)
			ship = Ship;
			
			//paritcles
			e = new FlxEmitter(0, 0, -0.2);
			e.setXVelocity(-80, 80);
			e.setYVelocity(-80, 0);
			e.createSprites(ImgExpl, 20, true);
			e.gravity = 0;
			FlxG.state.add(e);			
		}
		
		override public function update():void
		{
			//calculate the middle point of the height of the tunelle
			var middle:int = holle[0] + (holle[1] / 2);
			//place the bumpers
			topBumper.y = y - holle[1] / 4
			bottomBumper.y = y + holle[1] / 4;
			//adjuste de position of the ship based on the players height
			if (y < ship.y) velocity.y += 100 * FlxG.elapsed * 3;
			else if (y > ship.y) velocity.y -= 100 * FlxG.elapsed * 3;
			else velocity.y *= 0.7;
			//check if out of screen
			if ( y > 480 || y < 0)
			{
				kill();
			}
			//Check timer and attack
			if (attackTimer >= 6)
			{
				FlxG.log("shoot");
				shoot()
				attackTimer = 0;
			}
			else attackTimer += FlxG.elapsed * 3;
			//FlxG.log(attackTimer.toString());
			super.update();
		}
		
		override public function kill():void
		{
			e.x = x;
			e.y = y;
			e.restart();
			super.kill();
		}
		
		public function topCollide(w:Wall, c:FlxCore):void
		{
			velocity.y = 100;
		}
		public function bottomCollide(w:Wall, c:FlxCore):void
		{
			velocity.y = - 100;
		}

		private function shoot():void
		{
			var XVelocity:Number = -400;
			var YVelocity:Number = 0;
			for (var i:uint = 0; i < bullets.length; ++i)
			{
				if (!bullets[i].exists)
				{
					bullets[i].resetBullet(x + 30, y + 10, XVelocity, YVelocity);
					return;
				}
			}
			
			var bullet:Bullet = new Bullet(x, y, XVelocity, YVelocity);
			bullet.resetBullet(x + 30, y + 10, XVelocity, YVelocity);
			bullets.push(FlxG.state.add(bullet));
		}

	}
}