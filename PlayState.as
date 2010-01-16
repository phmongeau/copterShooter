package
{
	import org.flixel.*;

	public class PlayState extends FlxState
	{
		public var ship:Ship;
		public var pBullets:Array;
		
		public var dirigibles:Array;
		public var eBullets:Array;
		public var dirTimer:Number = 0;
		
		//the height of the middle of the tunnel
		public var middle:int;
		
		public var walls:Array;
		public var wallTimer:Number;
		private var wallHeight:int = 50;
		private var wallHolle:int = 200;
		private var branchCount:int = 0;
		private var branchHeight:int = 16;
		
		public var playTime:Number = 0;
				
		public function PlayState()
		{
			//creating the bullet arrays
			pBullets = new Array;
			eBullets = new Array;
			//creating the dirigibles array
			dirigibles = new Array;
			//filling the bullets arrays.
			for(var i:int = 0; i < 40; ++i)
			{
				var b:Bullet = new Bullet(0,0,0,0);
				var b2:Bullet = new Bullet(0,0,0,0);
				pBullets.push(this.add(b));
				eBullets.push(this.add(b2));
			}
			//puting a dirigible in the dirigibles array
			var d:Dirigible = new Dirigible(550, 240, eBullets, ship);
			dirigibles.push(d);
			
			//creating and adding the ship to the state
			ship = new Ship(30, 300, pBullets);
			this.add(ship);
						
			//init the wall timer
			wallTimer = 0;
			//wall array		
			walls = new Array;
		}
		
		override public function update():void
		{
			//updating playTime
			playTime += FlxG.elapsed;
			//checking the timer and creating a new wall
			if (wallTimer >= 0.083)
			{
				//determine if the holle should be lower or higher than the previous one
				var dir:int = Math.round(Math.random() * 2 - 1);
				//determine if the Holle should be larger or smaller
				var sizeChange:int = Math.round(Math.random() * 2 - 1);
				
				if ((wallHeight + dir * 10) > 0) wallHeight +=  dir * 10;
				
				if (wallHolle + sizeChange * 10 >= 200 - (playTime * 10) && wallHolle + sizeChange * 10 >= 100)
					wallHolle += sizeChange * 10;
				
				if (wallHolle + wallHeight >= 480)
				{
					wallHolle -= 70;
				}
				if (FlxG.keys.X)
				{
					branch(wallHeight, wallHolle);
				}
				else
				{
					//create the wall
					createWall(wallHeight, wallHolle);
					branchCount = 0;
				}

				//send the height to ships
				middle = wallHeight + (wallHolle / 2);
				for (var i:int = 0; i < dirigibles.length; ++i)
				{
					dirigibles[i].holle = [wallHeight, wallHolle];
				}
				
				//check if ship.dead
				if (ship.dead)
				{
					ship.deathTimer += FlxG.elapsed * 6;
					if (ship.deathTimer >= 1)
						FlxG.switchState(MenuState);
					else FlxG.log(ship.deathTimer.toString());
				}
				
				//reset the timer
				wallTimer = 0;
			}
			//increment the timer
			else wallTimer += FlxG.elapsed;// * 12;
			
			//spawning dirigibles
			/*if (wallHolle >= 170 && dirTimer >= 3)
			{
				var posx:int = Math.round((Math.random() * 80) + 400);
				d = new Dirigible(posx, middle, eBullets, ship);
				dirigibles.push(this.add(d));
				dirTimer = 0;
			}*/
			dirTimer += FlxG.elapsed;
						
			//Collisions:
			FlxG.overlapArray(walls, ship, collideWall);
			FlxG.overlapArrays(walls, pBullets, killBulletWall);
			FlxG.overlapArrays(pBullets, dirigibles, killDirigibles);
			FlxG.overlapArray(eBullets, ship, killShip);
			//dirigibles bumpers:
			for (i = 0; i < dirigibles.length; ++i)
			{
				FlxG.overlapArray(walls, dirigibles[i].topBumper, dirigibles[i].topCollide);
				FlxG.overlapArray(walls, dirigibles[i].bottomBumper, dirigibles[i].bottomCollide);
			}
			
			//TESTS
			if (FlxG.keys.justPressed("C"))
			{
				var d:Dirigible = new Dirigible(460, middle, eBullets, ship);
				dirigibles.push(this.add(d));
			}
			
						
			//update
			super.update();
		}
		
		private function createWall(height:int, size:int):void
		{
			//var to check if the two walls have been created
			var wallCount:Boolean = false;
			//check if there's an inactive wall that could be reused
			for (var i:int; i < walls.length; ++i)
			{
				if(!walls[i].exists)
				{
					if(!wallCount)
					{
						walls[i].resetWall(640, 0, 16, height, -5);
						wallCount = true;
					}
					else
					{
						walls[i].resetWall(640, height + size, 16, FlxG.height - height - size, -5);
						return
					}
				}
			}
			//create the bottome wall if the top wall has been reused
			if(wallCount)
			{
				var w:Wall = new Wall(640, height + size, 16, FlxG.height - height - size, -5);
				w.resetWall(640, height + size, 16, FlxG.height - height - size, -5)
				walls.push(this.add(w));
			}
			//create the two walls if none could be reused
			else
			{
				w = new Wall(640, 0, 16, height, -5);
				w.resetWall(640, 0, 16, height, -5)
				walls.push(this.add(w));
				
				w = new Wall(640, height + size, 16, FlxG.height - height - size, -5);
				w.resetWall(640, height + size, 16, FlxG.height - height - size, -5)
				walls.push(this.add(w));
			}
		}
		private function branch(height:int, size:int):void
		{
			if (branchCount < 21)
			{
				createWall(height, size);
				var w:Wall = new Wall(640, height + (size/2) - (32/2), 16, branchHeight, -5);
				w.resetWall(640, height + (size/2) - (32/2), 16, branchHeight + branchCount, -5);
				walls.push(this.add(w));
			}
			else if (branchCount < 42)
			{
				if (ship.y < height + (size/2))
				{
					w = new Wall(640, height + size + (branchCount * 2), 16, branchHeight, -5);
					w.resetWall(640, height + (size/2) + (branchCount * 2), 16, branchHeight + (branchCount * 2), -5);
					walls.push(this.add(w));
				}
				else
				{
					w = new Wall(640, height + size + (branchCount * 2), 16, branchHeight, -5);
					w.resetWall(640, height + (size/(branchCount*2)), 16, branchHeight + branchCount, -5);
					walls.push(this.add(w));
				}
					
				createWall(height, size);
			}
			else if (branchCount >= 42)
				createWall(height, size);
			++branchCount;
		}
		
		//switch back to MenuState if the ship touches a wall
		private function collideWall(w:Wall, s:Ship):void
		{
			s.kill();
		}
		
		private function killBulletWall(w:Wall, b:Bullet):void
		{
			b.kill();
		}
		private function killDirigibles(b:Bullet, d:Dirigible):void
		{
			b.kill();
			d.kill();
		}
		private function killShip(b:Bullet, s:Ship):void
		{
			b.kill();
			s.kill();
		}
	}
}