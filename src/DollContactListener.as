package
{
    import Box2D.Dynamics.Contacts.b2Contact;
    import Box2D.Dynamics.b2ContactListener;
    import Box2D.Dynamics.*;
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.Joints.*;
    import org.flixel.*;

    public class DollContactListener extends b2ContactListener
    {
        [Embed(source = "../assets/toy1.mp3")] private var SndToy1:Class;
        [Embed(source = "../assets/toy2.mp3")] private var SndToy2:Class;
        [Embed(source = "../assets/toy3.mp3")] private var SndToy3:Class;
        [Embed(source = "../assets/toy4.mp3")] private var SndToy4:Class;
        [Embed(source = "../assets/toy5.mp3")] private var SndToy5:Class;
        [Embed(source = "../assets/toy6.mp3")] private var SndToy6:Class;
        [Embed(source = "../assets/toy7.mp3")] private var SndToy7:Class;
        [Embed(source = "../assets/blegh.mp3")] private var Blegh:Class;
        [Embed(source = "../assets/confused.mp3")] private var Confused:Class;
        [Embed(source = "../assets/hehe.mp3")] private var Hehe:Class;
        [Embed(source = "../assets/hmm.mp3")] private var Hmm:Class;
        [Embed(source = "../assets/hmph.mp3")] private var Hmph:Class;
        [Embed(source = "../assets/kissu.mp3")] private var Kissu:Class;
        [Embed(source = "../assets/ooh.mp3")] private var Ooh:Class;
        [Embed(source = "../assets/uh.mp3")] private var Uh:Class;

        public var t:FlxText = new FlxText(200,200,100,"COLLIDING");
        public var face:Face;
        public var sex:Number = 0;
        public var isColliding:Boolean = false;

        public function DollContactListener(face:Face):void{
            this.face = face;
        }

        override public function BeginContact(contact:b2Contact):void
        {
            var bodyA:b2Fixture = contact.GetFixtureA();
            var bodyB:b2Fixture = contact.GetFixtureB();
            var rand:Number = FlxG.random()*12;

            if(bodyA.IsSensor() && bodyB.IsSensor()){
                this.isColliding = true;
                this.face.increaseBlush();
                //A HEAD TO B HEAD
                if(bodyA.GetUserData().toString() == PhysicsDoll.COL_HEAD){
                    if(bodyB.GetUserData().toString() == PhysicsDoll.COL_HEAD){
                        this.face.play("excited");
                        if (rand < 1) {
                            FlxG.play(Kissu);
                        }
                    }
                }
                //A GROIN TO B GROIN
                if(bodyA.GetUserData().toString() == PhysicsDoll.COL_GROIN){
                    if(bodyB.GetUserData().toString() == PhysicsDoll.COL_GROIN){
                        this.face.play("surprised");
                        if (rand < 1) {
                            FlxG.play(Ooh);
                        }
                    }
                }
                //A HEAD TO B GROIN
                if(bodyA.GetUserData().toString() == PhysicsDoll.COL_HEAD){
                    if(bodyB.GetUserData().toString() == PhysicsDoll.COL_GROIN){
                        this.face.play("disgusted");
                        if (rand < 1) {
                            FlxG.play(Hmph);
                        }
                    }
                }
                //B HEAD TO A GROIN
                if(bodyB.GetUserData().toString() == PhysicsDoll.COL_HEAD){
                    if(bodyA.GetUserData().toString() == PhysicsDoll.COL_GROIN){
                        this.face.play("disgusted");
                        if (rand < 1) {
                            FlxG.play(Hmm);
                        }
                    }
                }
                //A HEAD TO B L HAND
                if(bodyA.GetUserData().toString() == PhysicsDoll.COL_HEAD){
                    if(bodyB.GetUserData().toString() == PhysicsDoll.COL_L_HAND){
                        this.face.play("confused");
                        if (rand < 1) {
                            FlxG.play(Uh);
                        }
                    }
                }
                //B HEAD TO A L HAND
                if(bodyB.GetUserData().toString() == PhysicsDoll.COL_HEAD){
                    if(bodyA.GetUserData().toString() == PhysicsDoll.COL_L_HAND){
                        this.face.play("confused");
                        if (rand < 1) {
                            FlxG.play(Hmm);
                        }
                    }
                }
                //A HEAD TO B R HAND
                if(bodyA.GetUserData().toString() == PhysicsDoll.COL_HEAD){
                    if(bodyB.GetUserData().toString() == PhysicsDoll.COL_R_HAND){
                        this.face.play("confused");
                        if (rand < 1) {
                           FlxG.play(Uh);
                        }
                    }
                }
                //B HEAD TO A R HAND
                if(bodyB.GetUserData().toString() == PhysicsDoll.COL_HEAD){
                    if(bodyA.GetUserData().toString() == PhysicsDoll.COL_R_HAND){
                        this.face.play("confused");
                        if (rand < 1) {
                            FlxG.play(Confused);
                        }
                    }
                }
                //A GROIN TO B L HAND
                if(bodyA.GetUserData().toString() == PhysicsDoll.COL_GROIN){
                    if(bodyB.GetUserData().toString() == PhysicsDoll.COL_L_HAND){
                        this.face.play("excited");
                        if (rand < 1) {
                            FlxG.play(Hehe);
                        }
                    }
                }
                //B GROIN TO A L HAND
                if(bodyB.GetUserData().toString() == PhysicsDoll.COL_GROIN){
                    if(bodyA.GetUserData().toString() == PhysicsDoll.COL_L_HAND){
                        this.face.play("disgusted");
                        if (rand < 1) {
                            FlxG.play(Blegh);
                        }
                    }
                }
                //A GROIN TO B R HAND
                if(bodyA.GetUserData().toString() == PhysicsDoll.COL_GROIN){
                    if(bodyB.GetUserData().toString() == PhysicsDoll.COL_R_HAND){
                        this.face.play("disgusted");
                        if (rand < 1) {
                            FlxG.play(Ooh);
                        }
                    }
                }
                //B GROIN TO A R HAND
                if(bodyB.GetUserData().toString() == PhysicsDoll.COL_GROIN){
                    if(bodyA.GetUserData().toString() == PhysicsDoll.COL_R_HAND){
                        this.face.play("surprised");
                        if (rand < 1) {
                            FlxG.play(Hehe);
                        }
                    }
                }
                var pick:Number = FlxG.random()*12;
                if (pick < 1) {
                    FlxG.play(SndToy1);
                } else if (pick < 2) {
                    FlxG.play(SndToy2);
                } else if (pick < 3) {
                    FlxG.play(SndToy3);
                } else if (pick < 4) {
                    FlxG.play(SndToy4);
                } else if (pick < 5) {
                    FlxG.play(SndToy5);
                } else if (pick < 6) {
                    FlxG.play(SndToy6);
                } else if (pick < 7) {
                    FlxG.play(SndToy7);
                }
            }
        }

        override public function EndContact(contact:b2Contact):void
        {
            var bodyA:b2Fixture = contact.GetFixtureA();
            var bodyB:b2Fixture = contact.GetFixtureB();

            if(bodyA.IsSensor() && bodyB.IsSensor()){
                sex++;
                this.isColliding = false;
            }
        }
    }
}
