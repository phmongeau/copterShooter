package
{
	import org.flixel.*;
	
	public class Bullet extends FlxSprite
	{
		[Embed(source = "/data/bullet.png")] private var ImgBullet:Class;
		[Embed(source = "/data/redpix.png")] private var ImgPix:Class;
		
		public var e:FlxEmitter;
				
		public function Bullet(X:int, Y:int, XVeloctity:Number, YVelocity:Number):void
		{
			super(X,Y);
			loadGraphic(ImgBullet, false, false, 8, 4);
			exists = false;
			
			e = new FlxEmitter(0, 0, -1.5);
			e.setXVelocity(-150, 0);
			e.setYVelocity(-150, 150);
			e.createSprites(ImgPix, 20, false);
			FlxG.state.add(e);

		}
		
		override public function update():void
		{
			//check if the wall is out of the screen and kill it
			if (x <= 0 || x >= 640)
			{
				kill();
			}
			
			super.update();	
		}
		
		override public function kill():void
		{
			if(dead)
				return;
			e.x = x;
			e.y = y;
			super.kill()
			e.restart();
		}
		
		//restet function to be able to reuse the bullet
		public function resetBullet(X:Number, Y:Number, XVelocity:Number, YVelocity:Number):void
		{
			x = X;
			y = Y;
			velocity.x = XVelocity;
			velocity.y = YVelocity;
			exists = true;
			visible = true;
			dead = false;
		}				
	}
}