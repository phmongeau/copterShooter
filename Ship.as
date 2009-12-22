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
		}
		
		override public function update():void
		{
			if(FlxG.keys.UP)
				acceleration.y = -400 - FlxG.elapsed * 3;
			else
				acceleration.y = 400 - FlxG.elapsed * 3;
			
			if(FlxG.keys.justPressed("SPACE")) shoot();
			super.update();
		}
		
		private function shoot():void
		{
			FlxG.log("POW");
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