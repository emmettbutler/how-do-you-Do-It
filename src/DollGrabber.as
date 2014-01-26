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
        public var doll:PhysicsDoll;
        public var worldBounds:b2AABB;

        public function create(doll:PhysicsDoll, m_world:b2World,
                               bounds:b2AABB):void
        {
            this.doll = doll;
            this.worldBounds = bounds;

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

        }

        public function SetTransform(target:b2Vec2, angle:Number):void{
            var targetAABB:b2AABB = new b2AABB();
            targetAABB.lowerBound.Set(target.x, target.y);
            targetAABB.upperBound.Set(target.x, target.y);
            if (worldBounds.Contains(targetAABB)) {
                var midpoint:Number = worldBounds.upperBound.x/2;
                if ((m_mouseJoint.GetTarget().x < midpoint && target.x < midpoint)
                || (m_mouseJoint.GetTarget().x > midpoint && target.x > midpoint)) {
                    m_mouseJoint.SetTarget(target);
                }
            }
            doll.midriff.SetAngle(angle);
        }
    }
}
