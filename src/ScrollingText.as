package {
    import org.flixel.*;

    public class ScrollingText extends FlxText {
        public var thoughts:Array = new Array(
            "...she's gone.",
            "Rose...",
            "Jack...",
            "Why was it so cloudy in there?",
            "In the car on the Titanic...",
            "Clouds don't go in cars...",
            "They were hugging all like...",
            "I don't hug mommy like that.",
            "I hope she doesn't see this...",
            "Don't... people usually stand and hug?",
            "What kind of a hug is a hug on the floor?",
            "Like this...?",
            "How many hugs are there?",
            "There's a lot about hugging I don't understand.",
            "I hope she doesn't see this...",
            "They kissed too...",
            "Kissing seems nice.",
            "Mimi said that grown-ups have sex and...",
            "That sex is a lot of kissing and hugging.",
            "Mom doesn't like that word...",
            "Why doesn't she like it?",
            "I hope she doesn't see this...",
            "Why doesn't she like... sex?",
            "I wish I knew what sex was.");
        public var thought_bubble:String = "";
        public var bubble_width:Number = FlxG.width/2;
        public var pos_x:Number = FlxG.width-100;
        public var pos_y:Number = 20;
        public var counter:Number = 0;
        public var frame_counter:Number = 0;
        public var paused:Boolean = true;

        public function ScrollingText() {
            super(pos_x,pos_y,100,thoughts[counter]);
        }

        override public function update():void{
            super.update();
            frame_counter++;

            if(frame_counter%150 == 0 && !paused){
                counter++;
                if(counter >= thoughts.length){
                    counter = 0;
                }
                this.text = thoughts[counter];
            }
        }
    }
}
