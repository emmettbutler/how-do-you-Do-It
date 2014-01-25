package {
    import org.flixel.*;

    public class ScrollingText extends FlxText {
        public var thoughts:Array = new Array("aahahhahhahahah", "b", "c");
        public var t:FlxText;
        public var pos_x:Number = FlxG.width/2-50;
        //public var pos_y:Number = FlxG.height-20;
        public var pos_y:Number = 50;

        public function ScrollingText() {
            super(pos_x,pos_y,100,thoughts[0]);
        }


        override public function update():void{
            super.update();
            //pos_x--;

            //t.x = pos_x;
            //t.y = pos_y;
        }
    }
}