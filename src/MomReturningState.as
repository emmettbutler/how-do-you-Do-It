package
{
    import org.flixel.*;

    public class MomReturningState extends TimedState{
        [Embed(source = "../assets/bgm.mp3")] private var SndBGM:Class;
        [Embed(source = "../assets/doorclose.mp3")] private var doorClose:Class;


        public var nextState:FlxState;
        public var time_frame:Number = 0;

        public function MomReturningState(next:FlxState) {
            super();
            this.nextState = next;
        }

        override public function create():void
        {
            endTime = 1;

            if(FlxG.music == null){
                FlxG.playMusic(SndBGM, ggj.VOLUME);
            } else {
                FlxG.music.resume();
                if(!FlxG.music.active){
                    FlxG.playMusic(SndBGM, ggj.VOLUME);
                }
            }
        }

        override public function update():void
        {
            super.update();
            time_frame++;
            if(time_frame == 50){
                FlxG.play(doorClose);
            }
        }

        override public function endCallback():void {
            FlxG.switchState(nextState);
        }
    }
}
