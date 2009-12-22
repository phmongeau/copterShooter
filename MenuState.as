package
{
	import org.flixel.*;

	public class MenuState extends FlxState
	{
		public function MenuState()
		{
			var t:FlxText;
			t = new FlxText(0,FlxG.height/2-10,FlxG.width,"copterShooter");
			t.size = 16;
			t.alignment = "center";
			add(t);
			t = new FlxText(FlxG.width/2-50,FlxG.height-20,100,"Space to play");
			t.alignment = "center";
			add(t);
		}

		override public function update():void
		{
			if(FlxG.keys.SPACE)
				FlxG.switchState(PlayState);
		}
	}
}
