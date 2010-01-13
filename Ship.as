package
{
	import org.flixel.*;
	
	public class Ship extends FlxSprite
	{
		[Embed(source = '/data/sideShip.png')] private var ImgShip:Class;
		[Embed(source = '/data/explosion.png')] private var ImgExpl:Class;
		
		private var bullets:Array;
		private var e:FlxEmitter;
		public var deathTimer:Number = 0;;

		
		public function Ship(X:int, Y:int, Bullets:Array):void
		{
			super(X, Y);
			loadGraphic(ImgShip, false, true, 30, 20);
			bullets = Bullets;
			
			drag.y = 400;
			
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
			if(FlxG.keys.UP)
				velocity.y -= 390 * FlxG.elapsed * 3;
			else
				velocity.y += 390 * FlxG.elapsed * 3;
			
			if(FlxG.keys.justPressed("SPACE")) shoot();
			
			if (y < 0 || y > 480) FlxG.switchState(MenuState);
									
			super.update();
		}
		
		override public function kill():void
		{
			e.x = x;
			e.y = y;
			e.restart();
			super.kill();

		}
		
		private function shoot():void
		{
			var XVelocity:Number = 300;
			var YVelocity:Number = 0;
			for (var i:uint = 0; i< bullets.length; ++i)
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