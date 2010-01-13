package
{
	import org.flixel.*;
	
	public class Ship extends FlxSprite
	{
		[Embed(source = '/data/sideShip.png')] private var ImgShip:Class;
		
		private var bullets:Array;
		
		public function Ship(X:int, Y:int, Bullets:Array):void
		{
			super(X, Y);
			loadGraphic(ImgShip, false, true, 30, 20);
			bullets = Bullets;
			
			drag.y = 400;
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