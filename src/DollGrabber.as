package
{
    import org.flixel.*;

    import Box2D.Dynamics.*;
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.Joints.*;

    public class DollGrabber
    {
        public var m_mouseJoint:b2MouseJoint;
        public var ctrlScheme:Number;

        static public var dollTranslateSpeed:Number = .1;

        public static const WASD:Number = 0;
        public static const ARROW:Number = 1;

        public function create(doll:PhysicsDoll, m_world:b2World, ctrl:Number = WASD):void
        {
            this.ctrlScheme = ctrl;

            var md:b2MouseJointDef = new b2MouseJointDef();
            md.bodyA = m_world.GetGroundBody();
            md.bodyB = doll.midriff;
            md.target.Set(doll.midriff.GetPosition().x, doll.midriff.GetPosition().y);
            md.collideConnected = true;
            md.maxForce = 3000.0 * doll.midriff.GetMass();
            m_mouseJoint = m_world.CreateJoint(md) as b2MouseJoint;
        }

        public function update():void
        {
            var target:b2Vec2 = m_mouseJoint.GetTarget();
            if (ctrlScheme == WASD) {
                if (FlxG.keys.D) {
                    target.x += dollTranslateSpeed;
                } else if (FlxG.keys.A) {
                    target.x -= dollTranslateSpeed;
                }
                if (FlxG.keys.S) {
                    target.y += dollTranslateSpeed;
                } else if (FlxG.keys.W) {
                    target.y -= dollTranslateSpeed;
                }
            } else if (ctrlScheme == ARROW) {
                if (FlxG.keys.RIGHT) {
                    target.x += dollTranslateSpeed;
                } else if (FlxG.keys.LEFT) {
                    target.x -= dollTranslateSpeed;
                }
                if (FlxG.keys.DOWN) {
                    target.y += dollTranslateSpeed;
                } else if (FlxG.keys.UP) {
                    target.y -= dollTranslateSpeed;
                }
            }
            m_mouseJoint.SetTarget(target);
        }
    }
}
