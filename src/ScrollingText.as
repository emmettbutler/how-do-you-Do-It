package {
    import org.flixel.*;

    public class ScrollingText extends FlxText {
        public var thoughts:Array = new Array(
            "...she's gone.",
            "Rose...",
            "...Jack",
            "Why was it so cloudy there?",
            "Clouds don't go in cars...",
            "They were hugging all like...",
            "I don't hug mommy like that.",
            "Don't... people usually stand and hug?",
            "What kind of a hug is a hug on the floor?",
            "How many hugs are there?",
            "There's a lot about hugging I don't understand.",
            "They kissed too...",
            "Kissing seems nice.",
            "Mimi said that grown-ups have sex and...",
            "That sex is a lot of kissing and hugging.",
            "Mom doesn't like that word...",
            "Why doesn't she like it?",
            "Why doesn't she like... sex?",
            "I wish I knew what sex was.");
        public var spacing:String = "                               ";
        public var thought_bubble:String = "";
        public var bubble_width:Number = FlxG.width/2;
        public var pos_x:Number = bubble_width;
        public var pos_y:Number = FlxG.height-20;
        public var counter:Number = 0;
        public var edge:Number = bubble_width;

        public function ScrollingText() {
            for(var i:Number = 0; i < thoughts.length; i++){
                thought_bubble += thoughts[i] + spacing;
            }

            super(pos_x,pos_y,thought_bubble.length+9999,thought_bubble);
        }

        override public function update():void{
            super.update();
            pos_x -= .5;

            this.x = pos_x;
            this.y = pos_y;

            if(this.x + thought_bubble.length < 0){
                this.kill();
            }
        }
    }
}