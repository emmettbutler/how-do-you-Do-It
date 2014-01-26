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

            if(bodyA.IsSensor() && bodyB.IsSensor()){
                this.isColliding = true;
                this.face.increaseBlush();
                //A HEAD TO B HEAD
                if(bodyA.GetUserData().toString() == PhysicsDoll.COL_HEAD){
                    if(bodyB.GetUserData().toString() == PhysicsDoll.COL_HEAD){
                        this.face.play("excited");
                    }
                }
                //A GROIN TO B GROIN
                if(bodyA.GetUserData().toString() == PhysicsDoll.COL_GROIN){
                    if(bodyB.GetUserData().toString() == PhysicsDoll.COL_GROIN){
                        this.face.play("surprised");
                    }
                }
                //A HEAD TO B GROIN
                if(bodyA.GetUserData().toString() == PhysicsDoll.COL_HEAD){
                    if(bodyB.GetUserData().toString() == PhysicsDoll.COL_GROIN){
                        this.face.play("disgusted");
                    }
                }
                //B HEAD TO A GROIN
                if(bodyB.GetUserData().toString() == PhysicsDoll.COL_HEAD){
                    if(bodyA.GetUserData().toString() == PhysicsDoll.COL_GROIN){
                        this.face.play("disgusted");
                    }
                }
                //A HEAD TO B L HAND
                if(bodyA.GetUserData().toString() == PhysicsDoll.COL_HEAD){
                    if(bodyB.GetUserData().toString() == PhysicsDoll.COL_L_HAND){
                        this.face.play("confused");
                    }
                }
                //B HEAD TO A L HAND
                if(bodyB.GetUserData().toString() == PhysicsDoll.COL_HEAD){
                    if(bodyA.GetUserData().toString() == PhysicsDoll.COL_L_HAND){
                        this.face.play("confused");
                    }
                }
                //A HEAD TO B R HAND
                if(bodyA.GetUserData().toString() == PhysicsDoll.COL_HEAD){
                    if(bodyB.GetUserData().toString() == PhysicsDoll.COL_R_HAND){
                        this.face.play("confused");
                    }
                }
                //B HEAD TO A R HAND
                if(bodyB.GetUserData().toString() == PhysicsDoll.COL_HEAD){
                    if(bodyA.GetUserData().toString() == PhysicsDoll.COL_R_HAND){
                        this.face.play("confused");
                    }
                }
                //A GROIN TO B L HAND
                if(bodyA.GetUserData().toString() == PhysicsDoll.COL_GROIN){
                    if(bodyB.GetUserData().toString() == PhysicsDoll.COL_L_HAND){
                        this.face.play("excited");
                    }
                }
                //B GROIN TO A L HAND
                if(bodyB.GetUserData().toString() == PhysicsDoll.COL_GROIN){
                    if(bodyA.GetUserData().toString() == PhysicsDoll.COL_L_HAND){
                        this.face.play("disgusted");
                    }
                }
                //A GROIN TO B R HAND
                if(bodyA.GetUserData().toString() == PhysicsDoll.COL_GROIN){
                    if(bodyB.GetUserData().toString() == PhysicsDoll.COL_R_HAND){
                        this.face.play("disgusted");
                    }
                }
                //B GROIN TO A R HAND
                if(bodyB.GetUserData().toString() == PhysicsDoll.COL_GROIN){
                    if(bodyA.GetUserData().toString() == PhysicsDoll.COL_R_HAND){
                        this.face.play("surprised");
                    }
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
