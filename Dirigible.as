package
{
//	import flash.geom.Point;
	import org.flixel.*;
	
	public class Dirigible extends FlxSprite
	{
		[Embed(source = '/data/dirigible.png')] private var ImgShip:Class;
		[Embed(source = '/data/explosion.png')] private var ImgExpl:Class;
		
		private var bullets:Array;
		
		public var holle:Array;
		public var topBumper:FlxCore;
		public var bottomBumper:FlxCore;
		
		private var e:FlxEmitter;
		
		public function Dirigible(X:int, Y:int, Bullets:Array):void
		{
			super(X, Y);
			loadGraphic(ImgShip, false, true, 50, 25);
			bullets = Bullets;
			drag.y = 400;
			holle = new Array;
			topBumper = new FlxCore;
			topBumper.reset(x + 55, y - 10)
			bottomBumper = new FlxCore;
			bottomBumper.reset(x + 55, y + 35)
			velocity.y = 100;
			
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
			var middle:int = holle[0] + (holle[1] / 2);
			topBumper.y = y - holle[1] / 4
			bottomBumper.y = y + holle[1] / 4;
			if (y > middle + 10 && y < middle - 10) velocity.y *= 0.7;
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
			FlxG.log("top");
		}
		public function bottomCollide(w:Wall, c:FlxCore):void
		{
			velocity.y = - 100;
			FlxG.log("bottom");
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