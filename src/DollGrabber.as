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
        public var pos:b2Vec2;

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

        public function SetTransform(target:b2Vec2, angle:Number, toss:Boolean=false):void{
            var targetAABB:b2AABB = new b2AABB();
            targetAABB.lowerBound.Set(target.x, target.y);
            targetAABB.upperBound.Set(target.x, target.y);
            if (worldBounds.Contains(targetAABB) || toss) {
                var midpoint:Number = worldBounds.upperBound.x/2;
                var lower:Number = midpoint - 1;
                var upper:Number = midpoint + 1;

                if ((m_mouseJoint.GetTarget().x < midpoint && target.x < lower) ||
                    (m_mouseJoint.GetTarget().x > midpoint && target.x > upper)) {
                    m_mouseJoint.SetTarget(target);
                    this.pos = target;
                }
            }
            doll.midriff.SetAngle(angle);
        }
    }
}
