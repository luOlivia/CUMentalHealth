import json
from flask import Flask, request
from db import db, Place#, Location

app = Flask(__name__)

#db = DB()
db_filename = 'places.db'

app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///%s' % db_filename
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SQLALCHEMY_ECHO'] = True

db.init_app(app)
with app.app_context():
    db.create_all()

@app.route('/')
@app.route('/api/places/')
def get_places():
    places = Place.query.all()

    res = {'success': True, 'data': [place.serialize() for place in places]}
    return json.dumps(res), 200

@app.route('/api/places/', methods=['POST'])
def create_place():
    place_body = json.loads(request.data)

    place = Place(
        name= place_body.get('name'),
        img= place_body.get('img'),
        phone= place_body.get('phone'),
        hours= place_body.get('hours'),
        address= place_body.get('address'),
        website= place_body.get('website'),
        category= place_body.get('category'),
        time= place_body.get('time'),
        location= place_body.get('location'),
        coordinates= place_body.get('coordinates')
    )
    db.session.add(place)
    db.session.commit()
    return json.dumps({'success': True, 'data': place.serialize()}), 201

@app.route('/api/place/<int:place_id>/')
def get_place(place_id):
    place = Place.query.filter_by(id=place_id).first()
    if place is not None:
        return json.dumps({'success': True, 'data': place.serialize()}), 201
    return json.dumps({'success': False, 'error': 'place not found!'}), 404

@app.route('/api/place/<int:place_id>/', methods=['DELETE'])
def delete_place(place_id):
    place = Place.query.filter_by(id = place_id).first()
    if place is not None:
        db.session.delete(place)
        db.session.commit()
        return json.dumps({'success': True, 'data': place.serialize()}), 201
    return json.dumps({'success': False, 'error': 'place not found!'}), 404

#----------------------location class-------------------------------------
'''
@app.route('/api/locations/', methods=['POST'])
def create_location():
    body = json.loads(request.data)

    location = Location(
        building= body.get('building'),
        area= body.get('area'),
        coor= body.get('coor'),
    )
    db.session.add(location)
    db.session.commit()
    return json.dumps({'success': True, 'data': location.serialize()}), 201

@app.route('/api/location/<int:location_id>/')
def get_location(location_id):
    location = Location.query.filter_by(id=location_id).first()
    if location is not None:
        return json.dumps({'success': True, 'data': location.serialize()}), 201
    return json.dumps({'success': False, 'error': 'location not found!'}), 404

@app.route('/api/location/<int:location_id>/', methods=['DELETE'])
def delete_location(location_id):
    location = Location.query.filter_by(id = location_id).first()
    if location is not None:
        db.session.delete(location)
        db.session.commit()
        return json.dumps({'success': True, 'data': location.serialize()}), 201
    return json.dumps({'success': False, 'error': 'location not found!'}), 404
'''
#----------------------extra-----------------------------------------------
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001, debug=True)
