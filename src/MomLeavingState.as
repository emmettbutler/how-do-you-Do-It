package
{
    import org.flixel.*;

    public class MomLeavingState extends TimedState{
        [Embed(source = "../assets/bgm.mp3")] private var SndBGM:Class;
        [Embed(source = "../assets/dooropen.mp3")] private var doorOpen:Class;
        [Embed(source = "../assets/doorclose.mp3")] private var doorClose:Class;
        [Embed(source = "../assets/garageopen.mp3")] private var garageOpen:Class;
        [Embed(source = "../assets/cardoor.mp3")] private var carDoor:Class;
        [Embed(source = "../assets/carleave.mp3")] private var carLeave:Class;

        public var nextState:FlxState;
        public var time_frame:Number = 0;

        public function MomLeavingState(next:FlxState) {
            super();
            this.nextState = next;
        }

        override public function create():void
        {
            endTime = 10;

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
                FlxG.play(doorOpen);
            } else if(time_frame == 150){
                FlxG.play(doorClose);
            } else if(time_frame == 200){
                FlxG.play(garageOpen);
            } else if(time_frame == 300){
                FlxG.play(carDoor);
            } else if(time_frame == 400){
                FlxG.play(carLeave);
            }
        }

        override public function endCallback():void {
            FlxG.switchState(nextState);
        }
    }
}