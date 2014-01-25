package{
	import org.flixel.*;

	public class MenuState extends FlxState{
		override public function create():void{
			var t:FlxText;
			t = new FlxText(0,FlxG.height/2-10,FlxG.width,"ggj");
			t.size = 16;
			t.alignment = "center";
			add(t);
			t = new FlxText(FlxG.width/2-50,FlxG.height-20,100,"click to play");
			t.alignment = "center";
			add(t);

			FlxG.mouse.show();
		}

		override public function update():void{
			super.update();

			if(FlxG.mouse.justPressed()){
				FlxG.mouse.hide();
				FlxG.switchState(new SceneState("I'll be back in a minute.", new SceneState("OMG what's sex", new PlayState())));
			}
		}
	}
}
