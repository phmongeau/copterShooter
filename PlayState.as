package
{
	import org.flixel.*;

	public class PlayState extends FlxState
	{
//		[Embed(source = '/data/dirt2.png')] private var ImgWall:Class;
		
		public var ship:Ship;
		
		public var pBullets:Array;
		public var walls:Array;
		
		public var wallTimer:Number;
		private var wallHeight:int = 50;
		private var wallHole:int = 200; 
				
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
			wallTimer = 0;
			//createWall(50, 100);	
			//wall array		
			walls = new Array;
			/*
			for (i = 0; i <= 40; ++i)
			{
				var w:Wall = new Wall(0, 0, 0, 0, 0);
				walls.push(this.add(w));							
			}
			*/
		}
		
		override public function update():void
		{
			if (wallTimer >= 1)
			{
				var dir:int = Math.round(Math.random() * 2 - 1);
				var sizeChange:int = Math.round(Math.random() * 2 - 1);
				wallHeight +=  dir * 10;
				if (wallHole >= 50)
					wallHole += sizeChange * 10;
				else
					wallHole += sizeChange * -10;
				createWall(wallHeight, wallHole);
				wallTimer = 0;
			}
			else wallTimer += FlxG.elapsed * 12;
			
			super.update();
		}
		
		private function createWall(height:int, size:int):void
		{
			var wallCount:Boolean = false;
			for (var i:int; i < walls.length; ++i)
			{
				if(!walls[i].exists)
				{
					if(!wallCount)
					{
						walls[i].resetWall(640, 0, 16, height, -5);
						wallCount = true;
						FlxG.log("reset");
					}
					else
					{
						walls[i].resetWall(640, height + size, 16, FlxG.height - height - size, -5);
						return
						FlxG.log("reset");
					}
				}
			}
			FlxG.log("finishedLoop");
			if(wallCount)
			{
				var w:Wall = new Wall(640, height + size, 16, FlxG.height - height - size, -5);
				w.resetWall(640, height + size, 16, FlxG.height - height - size, -5)
				walls.push(this.add(w));
				FlxG.log("create");
			}
			else
			{
				w = new Wall(640, 0, 16, height, -5);
				w.resetWall(640, 0, 16, height, -5)
				walls.push(this.add(w));
				
				w = new Wall(640, height + size, 16, FlxG.height - height - size, -5);
				w.resetWall(640, height + size, 16, FlxG.height - height - size, -5)
				walls.push(this.add(w));
				FlxG.log("create");
			}				
		}
	}
}