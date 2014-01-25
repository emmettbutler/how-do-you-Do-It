package
{
    import org.flixel.*;

    import Box2D.Dynamics.*;
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.Math.*;

    public class B2FlxSprite extends FlxSprite{
        private var ratio:Number = 30;

        public var _fixDef:b2FixtureDef;
        public var _bodyDef:b2BodyDef
        public var _obj:b2Body;

        private var _world:b2World;

        //Physics params default value
        public var _friction:Number = 0.8;
        public var _restitution:Number = 0.3;
        public var _density:Number = 0.7;

        //Default angle
        public var _angle:Number = 0;
        //Default body type
        public var _type:uint = b2Body.b2_dynamicBody;


        public function B2FlxSprite(X:Number, Y:Number, Width:Number, Height:Number, w:b2World):void
        {
            super(X,Y);

            width = Width;
            height = Height;
            _world = w
        }

        override public function update():void
        {
            x = (_obj.GetPosition().x * ratio) - width/2 ;
            y = (_obj.GetPosition().y * ratio) - height/2;
            angle = _obj.GetAngle() * (180 / Math.PI);
            super.update();
        }

        public function createBody(myType:uint, _bodyDef:b2BodyDef=null,
                                   _fixDef:b2FixtureDef=null, _category:Number=0,
                                   _mask:Number=0):void
        {
            var boxShape:b2PolygonShape = new b2PolygonShape();
            boxShape.SetAsBox((width/2) / ratio, (height/2) /ratio);

            if(_fixDef == null){
                _fixDef = new b2FixtureDef();
                _fixDef.density = _density;
                _fixDef.restitution = _restitution;
                _fixDef.friction = _friction;
                _fixDef.filter.categoryBits = _category;
                _fixDef.filter.maskBits = _mask;
            }
            _fixDef.shape = boxShape;

            if(_bodyDef == null){
                _bodyDef = new b2BodyDef();
                _bodyDef.position.Set((x + (width/2)) / ratio, (y + (height/2)) / ratio);
                _bodyDef.angle = _angle * (Math.PI / 180);
                _bodyDef.type = myType;
            }

            _obj = _world.CreateBody(_bodyDef);
            _obj.CreateFixture(_fixDef);
        }
    }
}
