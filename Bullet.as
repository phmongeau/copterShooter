package
{
	import org.flixel.*;
	
	public class Bullet extends FlxSprite
	{
		[Embed(source = "/data/bullet.png")] private var ImgBullet:Class;
		
		public function Bullet(X:int, Y:int, XVeloctity:Number, YVelocity:Number):void
		{
			super(X,Y);
			loadGraphic(ImgBullet, false, false, 8, 4);
			exists = false;
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