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

        public function DollContactListener():void{
        }

        override public function BeginContact(contact:b2Contact):void
        {
            var bodyA:b2Fixture = contact.GetFixtureA();
            var bodyB:b2Fixture = contact.GetFixtureB();

            if(bodyA.IsSensor() && bodyB.IsSensor()){
                //A HEAD TO B HEAD
                if(bodyA.GetUserData().toString() == PhysicsDoll.COL_HEAD){
                    if(bodyB.GetUserData().toString() == PhysicsDoll.COL_HEAD){

                    }
                }
                //B HEAD TO A HEAD
                if(bodyB.GetUserData().toString() == PhysicsDoll.COL_HEAD){
                    if(bodyA.GetUserData().toString() == PhysicsDoll.COL_HEAD){

                    }
                }
                //A GROIN TO B GROIN
                if(bodyA.GetUserData().toString() == PhysicsDoll.COL_GROIN){
                    if(bodyB.GetUserData().toString() == PhysicsDoll.COL_GROIN){

                    }
                }
                //B GROIN TO A GROIN
                if(bodyB.GetUserData().toString() == PhysicsDoll.COL_GROIN){
                    if(bodyA.GetUserData().toString() == PhysicsDoll.COL_GROIN){

                    }
                }
                //A HEAD TO B GROIN
                if(bodyA.GetUserData().toString() == PhysicsDoll.COL_HEAD){
                    if(bodyB.GetUserData().toString() == PhysicsDoll.COL_GROIN){

                    }
                }
                //B HEAD TO A GROIN
                if(bodyB.GetUserData().toString() == PhysicsDoll.COL_HEAD){
                    if(bodyA.GetUserData().toString() == PhysicsDoll.COL_GROIN){

                    }
                }
                //A HEAD TO B L HAND
                if(bodyA.GetUserData().toString() == PhysicsDoll.COL_HEAD){
                    if(bodyB.GetUserData().toString() == PhysicsDoll.COL_L_HAND){

                    }
                }
                //B HEAD TO A L HAND
                if(bodyB.GetUserData().toString() == PhysicsDoll.COL_HEAD){
                    if(bodyA.GetUserData().toString() == PhysicsDoll.COL_L_HAND){

                    }
                }
                //A HEAD TO B R HAND
                if(bodyA.GetUserData().toString() == PhysicsDoll.COL_HEAD){
                    if(bodyB.GetUserData().toString() == PhysicsDoll.COL_R_HAND){

                    }
                }
                //B HEAD TO A R HAND
                if(bodyB.GetUserData().toString() == PhysicsDoll.COL_HEAD){
                    if(bodyA.GetUserData().toString() == PhysicsDoll.COL_R_HAND){

                    }
                }
                //A GROIN TO B L HAND
                if(bodyA.GetUserData().toString() == PhysicsDoll.COL_GROIN){
                    if(bodyB.GetUserData().toString() == PhysicsDoll.COL_L_HAND){

                    }
                }
                //B GROIN TO A L HAND
                if(bodyB.GetUserData().toString() == PhysicsDoll.COL_GROIN){
                    if(bodyA.GetUserData().toString() == PhysicsDoll.COL_L_HAND){

                    }
                }
                //A GROIN TO B R HAND
                if(bodyA.GetUserData().toString() == PhysicsDoll.COL_GROIN){
                    if(bodyB.GetUserData().toString() == PhysicsDoll.COL_R_HAND){

                    }
                }
                //B GROIN TO A R HAND
                if(bodyB.GetUserData().toString() == PhysicsDoll.COL_GROIN){
                    if(bodyA.GetUserData().toString() == PhysicsDoll.COL_R_HAND){

                    }
                }
            }
        }

        override public function EndContact(contact:b2Contact):void
        {
            var bodyA:b2Fixture = contact.GetFixtureA();
            var bodyB:b2Fixture = contact.GetFixtureB();

            if(bodyA.IsSensor() && bodyB.IsSensor()){
                FlxG.state.remove(t);
            }
        }
    }
}