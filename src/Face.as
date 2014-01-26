package
{
    import org.flixel.*;

    public class Face extends FlxSprite
    {
        [Embed(source="../assets/faces_strip.png")] private var ImgFace:Class;
        [Embed(source="../assets/blush.png")] private var ImgBlush:Class;

        public var blush:FlxSprite;

        public function Face(x:Number, y:Number)
        {
            super(x, y);
            loadGraphic(ImgFace, true, true, 205, 202, true);
            addAnimation("neutral", [0], 1, false);
            addAnimation("blink", [2, 3, 2, 0], 12, false);
            addAnimation("lookaside", [1, 0], 2, false);
            addAnimation("excited", [4]);
            addAnimation("disgusted", [5]);
            addAnimation("confused", [6]);
            addAnimation("surprised", [7]);
            play("neutral");
            FlxG.state.add(this);

            blush = new FlxSprite(x, y);
            blush.loadGraphic(ImgBlush, true, true, 205, 202, true);
            FlxG.state.add(blush);
            blush.alpha = 0;
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
            decreaseBlush();
        }

        public function increaseBlush():void
        {
            if (blush.alpha < 1) {
                blush.alpha += .2;
            }
        }

        public function decreaseBlush():void
        {
            if (blush.alpha > 0) {
                blush.alpha -= .002;
            }
        }
    }
}
