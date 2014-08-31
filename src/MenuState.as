package{
    import org.flixel.*;

    public class MenuState extends FlxState{
        [Embed(source="../assets/title_screen.png")] private var ImgBG:Class;

        override public function create():void{
            FlxG.mouse.hide();
            var bg:FlxSprite = new FlxSprite(0, 0);
            bg.loadGraphic(ImgBG, true, true, 320, 240, true);
            add(bg);

            var t:FlxText;
            t = new FlxText(-9, FlxG.height/2+20, FlxG.width, "Press any key to play");
            t.alignment = "right";
            t.color = 0xf9d0b4;
            add(t);
        }

        override public function update():void{
            super.update();

            if(FlxG.keys.any()){
                FlxG.switchState(new MomLeavingState(new PlayState()));
            }
        }
    }
}
