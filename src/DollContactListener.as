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

        public function DollContactListener():void{
        }

        override public function BeginContact(contact:b2Contact):void
        {
            var bodyA:b2Fixture = contact.GetFixtureA();
            var bodyB:b2Fixture = contact.GetFixtureB();

            if(bodyA.IsSensor() && bodyB.IsSensor()){
                onCollision();
            }
        }

        public function onCollision():void
        {
        }
    }
}