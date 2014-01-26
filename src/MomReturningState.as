package
{
    import org.flixel.*;

    public class MomReturningState extends TimedState{
        [Embed(source = "../assets/bgm.mp3")] private var SndBGM:Class;
        [Embed(source = "../assets/doorclose.mp3")] private var doorClose:Class;
        [Embed(source = "../assets/house.png")] private var house:Class;
        [Embed(source = "../assets/outside.png")] private var outside:Class;
        [Embed(source = "../assets/girl3.png")] private var girl3:Class;
        [Embed(source = "../assets/dolls.png")] private var dolls:Class;
        [Embed(source = "../assets/mom1.png")] private var mom:Class;
        [Embed(source = "../assets/mom_shock.png")] private var mom_shock:Class;

        public var nextState:FlxState;
        public var time_frame:Number = 0;

        public var cameraTrack:FlxSprite;
        public var cam_moving:Boolean = false;
        public var cam_target_point:FlxPoint;
        public var scene_time:Number = 1;
        public var current_scene:Number = 1;
        public var girl3_sprite:FlxSprite;
        public var dolls_sprite:FlxSprite;
        public var mom_sprite:FlxSprite;
        public var caught:Boolean

        public function MomReturningState(next:EndState, caught:Boolean) {
            super();
            this.nextState = next;
            this.caught = caught;
        }

        override public function create():void
        {
            endTime = 7;

            cam_target_point = new FlxPoint(389+(FlxG.width/2),52+FlxG.height/2);

            cameraTrack = new FlxSprite(389+(FlxG.width/2),52+FlxG.height/2);
            cameraTrack.visible = false;
            add(cameraTrack);
            FlxG.camera.target = cameraTrack;

            var outside_bg:FlxSprite = new FlxSprite(0, 0);
            outside_bg.loadGraphic(outside, true, true, 600, 185, true);
            add(outside_bg);
            outside_bg.scrollFactor = new FlxPoint(.5, .5);

            var house_bg:FlxSprite = new FlxSprite(0, 0);
            house_bg.loadGraphic(house, true, true, 1500/2, 360, true);
            house_bg.addAnimation("closed", [0], 1, false);
            house_bg.addAnimation("open", [1], 1, false);
            add(house_bg);

            girl3_sprite = new FlxSprite(525, 174);
            girl3_sprite.loadGraphic(girl3, true, true, 60, 101, true);
            add(girl3_sprite);

            dolls_sprite = new FlxSprite(598, 178);
            dolls_sprite.loadGraphic(dolls, true, true, 76, 55, true);
            add(dolls_sprite);

            if (this.caught) {
                mom_sprite = new FlxSprite(22, 29);
                mom_sprite.loadGraphic(mom_shock, true, true, 101, 174, true);
                mom_sprite.addAnimation("run", [0, 1], 3, true);
                mom_sprite.play("run");
            } else {
                mom_sprite = new FlxSprite(22, 49);
                mom_sprite.loadGraphic(mom, true, true, 77, 151, true);
            }
            add(mom_sprite);
            mom_sprite.alpha = 0;

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

            if((timeFrame/100)%3 == 0){
                current_scene++;
                if(current_scene == 2){
                    cam_moving = true;
                    cam_target_point = new FlxPoint(FlxG.width/2,FlxG.height/2);
                }
            }

            if(Math.abs(cameraTrack.x - cam_target_point.x) < 10 && Math.abs(cameraTrack.y - cam_target_point.y) < 10){
                cam_moving = false;
                if(current_scene == 2){
                    mom_sprite.alpha += .02;
                }
            } else {
                cameraTrack.velocity.x = cam_target_point.x - cameraTrack.x;
                cameraTrack.velocity.y = cam_target_point.y - cameraTrack.y;
            }

            if(current_scene == 2){
                girl3_sprite.alpha -= .02;
                dolls_sprite.alpha -= .02;
            }
        }

        override public function endCallback():void {
            FlxG.switchState(nextState);
        }
    }
}
