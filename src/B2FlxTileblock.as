package{

    import org.flixel.*;
    import Box2D.Dynamics.*;
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.Math.*;

    public class B2FlxTileblock extends FlxTileblock{

        private var ratio:Number = 30;

        public var _fixDef:b2FixtureDef;
        public var _bodyDef:b2BodyDef
        public var _obj:b2Body;

        //References
        private var _world:b2World;

        //Physics params default value
        public var _friction:Number = 0.8;
        public var _restitution:Number = 0.3;
        public var _density:Number = 0.7;

        //Default angle
        public var _angle:Number = 0;
        //Default body type
        public var _type:uint = b2Body.b2_staticBody;

        public function B2FlxTileblock(X:Number, Y:Number, Width:Number, Height:Number, w:b2World):void{

            super(X,Y, Width, Height);
            _world = w;
        }

        public function createBody():void
        {
            var boxShape:b2PolygonShape = new b2PolygonShape();
            boxShape.SetAsBox((width/2) / ratio, (height/2) /ratio);

            _fixDef = new b2FixtureDef();
            _fixDef.density = _density;
            _fixDef.restitution = _restitution;
            _fixDef.friction = _friction;
            _fixDef.shape = boxShape;

            _bodyDef = new b2BodyDef();
            _bodyDef.position.Set((x + (width/2)) / ratio, (y + (height/2)) / ratio);
            _bodyDef.angle = _angle * (Math.PI / 180);
            _bodyDef.type = _type;

            _obj = _world.CreateBody(_bodyDef);
            _obj.CreateFixture(_fixDef);
        }
    }
}