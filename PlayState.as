package
{
	import org.flixel.*;

	public class PlayState extends FlxState
	{
		public var ship:Ship;
		
		public var pBullets:Array;
				
		public function PlayState()
		{
			
			pBullets = new Array;
						
			for(var i:int = 0; i < 40; ++i)
			{
				var b:Bullet = new Bullet(0,0,0,0);
				pBullets.push(this.add(b));
			}
			
			ship = new Ship(0, 300, pBullets);
			this.add(ship);

		}
	}
}
