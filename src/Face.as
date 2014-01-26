package
{
    import org.flixel.*;

    public class Face extends FlxSprite
    {
        [Embed(source="../assets/faces_strip.png")] private var ImgFace:Class;

        public function Face(x:Number, y:Number)
        {
            super(x, y);
            loadGraphic(ImgFace, true, true, 205, 202, true);
            addAnimation("neutral", [0], 1, false);
            addAnimation("blink", [2, 3, 2, 0], 12, false);
            addAnimation("lookaside", [1, 0], 2, false);
            play("neutral");
        }

        override public function update():void
        {
            super.update();

            var pick:Number = FlxG.random()*400;
            if (pick < 1) {
                play("lookaside");
            } else if (pick < 2) {
                play("blink");
            }
        }
    }
}
