package{
    import org.flixel.*;

    public class EndState extends FlxState{
        public var times:Number;
        public var caught:Boolean

        public function EndState(sex:Number, caught:Boolean){
            times = sex;
            this.caught = caught;
        }

        override public function create():void{
            var t:FlxText;
            FlxG.mouse.hide();
            if(times == 1){
                t = new FlxText(0,FlxG.height/2-10,FlxG.width,"you might have done sex " + times + " time...?");
                t.size = 16;
                t.alignment = "center";
                add(t);
            } else {
                t = new FlxText(0,FlxG.height/2-10,FlxG.width,"You might have done sex " + times + " times...?");
                t.size = 16;
                t.alignment = "center";
                add(t);
            }
            if (this.caught) {
                t.text += "\nEep! Mom saw!";
            }
            t = new FlxText(FlxG.width/2-50,FlxG.height-20,100,"J to play again");
            t.alignment = "center";
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
