package
{
	import org.flixel.*;
	[SWF(width="640", height="480", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]

	public class copterShooter extends FlxGame
	{
		public function copterShooter()
		{
			super(640,480,MenuState,1);
			showLogo = false;
			FlxG.debug = true;
		}
	}
}
