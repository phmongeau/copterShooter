package
{
	import flash.geom.Point;
	import org.flixel.*;
	
	public class Wall extends FlxBlock
	{
		[Embed(source = '/data/dirt2.png')] private var ImgWall:Class;
		
		public var velocity:Point;
		public function Wall(X:int, Y:int, Width:int, Height:int, Speed:int):void
		{
			super(X, Y, Width, Height);
			loadGraphic(ImgWall);
			
			velocity = new Point();
			
			velocity.x = Speed;
			velocity.y = 0;		
			
			exists = false;	
		}
		
		override public function update():void
		{
			if(x <= 0) kill();
			x += velocity.x;
			y += velocity.y;
			
			super.update();
		}
		
		//restet function to be able to reuse the bullet
		public function resetWall(X:int, Y:int, Width:int, Height:int, Speed:int):void
		{
			super.reset(X, Y)
			
			width = Width;
			height = Height;
			
			exists = true;
			visible = true;
			
			loadGraphic(ImgWall);
			
			velocity.x = Speed;
		}
	}
}