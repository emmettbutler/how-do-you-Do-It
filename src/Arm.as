package
{
    import org.flixel.*;

    public class Arm
    {
        [Embed(source="../assets/girl_forearm.png")] private var ImgForearm:Class;
        [Embed(source="../assets/girl_handL.png")] private var ImgHandL:Class;
        [Embed(source="../assets/girl_handR.png")] private var ImgHandR:Class;

        public var forearm:FlxSprite;
        public var hand:FlxSprite;

        public function Arm(x:Number, rt:Boolean = false)
        {
            forearm = new FlxSprite(x, 180);
            forearm.loadGraphic(ImgForearm, true, true, 81, 290, true);
            FlxG.state.add(forearm);

            hand = new FlxSprite(x, 120);
            if (rt) {
                hand.loadGraphic(ImgHandL, true, true, 88, 89, true);
            } else {
                hand.loadGraphic(ImgHandR, true, true, 88, 89, true);
            }
            FlxG.state.add(hand);
        }
    }
}
