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
            var textWidth:Number = FlxG.width;
            if(times == 1){
                t = new FlxText(0,FlxG.height/2-50, textWidth,"You might have done sex\n" + times + " time...?");
                t.setFormat("Minecraftia-Regular",16,0xffffffff,"center");
                add(t);
            } else {
                t = new FlxText(0,FlxG.height/2-50, textWidth,"You might have done sex\n" + times + " times...?");
                t.setFormat("Minecraftia-Regular",16,0xffffffff,"center");
                add(t);
            }
            if (this.caught) {
                t.text += "\nEep! Mom saw!";
            } else {
                t.text += "\nAnd you didn't get caught!";
            }
            t = new FlxText(FlxG.width/2-50,FlxG.height-40,100,"J to play again");
            t.setFormat("Minecraftia-Regular",16,0xffffffff,"center");
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
