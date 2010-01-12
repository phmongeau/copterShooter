package
{
	import org.flixel.*;
	
	public class Dirigible extends FlxSprite
	{
		[Embed(source = '/data/dirigible.png')] private var ImgShip:Class;
		
		private var bullets:Array;
		
		public var holle:Array;
		
		public function Dirigible(X:int, Y:int, Bullets:Array):void
		{
			super(X, Y);
			loadGraphic(ImgShip, false, true, 50, 25);
			bullets = Bullets;
			drag.y = 400;
			holle = new Array;
		}
		
		override public function update():void
		{
			//update position
			y = holle[0] + (holle[1] /2);
			super.update();
		}
		
		/*
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
		*/

	}
}