package {
    import org.flixel.*;

    public class ScrollingText extends FlxText {
        public var thoughts:Array = new Array("a", "b", "c");
        public var pos_x:Number = FlxG.width;
        public var pos_y:Number = FlxG.height-20;
        //public var pos_y:Number = 50;

        public function ScrollingText() {
            super(pos_x,pos_y,100,thoughts[0]);
        }


        override public function update():void{
            super.update();
            pos_x -= .5;

            this.x = pos_x;
            this.y = pos_y;
        }
    }
}