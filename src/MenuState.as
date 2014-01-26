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
            t = new FlxText(FlxG.width-85,FlxG.height/2+20,100,"J to play");
            t.alignment = "center";
            t.color = 0xf9d0b4;
            add(t);
        }

        override public function update():void{
            super.update();

            if(FlxG.keys.J){
                FlxG.switchState(new MomLeavingState(new PlayState()));
            }
        }
    }
}
