from flask_sqlalchemy import SQLAlchemy
import csv
from sqlalchemy import *
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from sqlalchemy.sql import *


db = SQLAlchemy()


association_table = db.Table('association', db.Model.metadata,
    db.Column('places_id', db.Integer, db.ForeignKey('places.id')),
    #db.Column('location_id', db.Integer, db.ForeignKey('location.id'))
)

class Place(db.Model):
	__tablename__ = 'places'
	id = db.Column(db.Integer, primary_key = True)
	name = db.Column(db.String, nullable = False)
	img = db.Column(db.String, nullable = False)
	phone = db.Column(db.String, nullable = False)
	hours = db.Column(db.String, nullable = False)
	address = db.Column(db.String, nullable = False)
	website = db.Column(db.String, nullable = False)
	category = db.Column(db.String, nullable = False)
	time = db.Column(db.String, nullable = False)
	location = db.Column(db.String, nullable = False)
	coordinates = db.Column(db.String, nullable = False)

	'''
	hours = db.Column(db.Integer, nullable = False)
	description = db.Column(db.String, nullable = False)
	location = db.relationship('Location', secondary=association_table)
	'''

	def __init__(self, **kwargs):
		self.name = kwargs.get('name', '')
		self.img = kwargs.get('img', '')
		self.phone = kwargs.get('phone', '')
		self.hours = kwargs.get('hours', '')
		self.address = kwargs.get('address', '')
		self.website = kwargs.get('website', '')
		self.category = kwargs.get('category', '')
		self.time = kwargs.get('time', '')
		self.location = kwargs.get('location', '')
		self.coordinates = kwargs.get('coordinates', '')

	def serialize(self):
		return {
			'id': self.id,
			'name': self.name,
			'img': self.img,
			'phone': self.phone,
			'hours': self.hours,
			'address': self.address,
			'website': self.website,
			'types': stoArray(self.category),
			'times': stoArray(self.time),
			'locations': stoArray(self.location),
			'coordinates': stoArray(self.coordinates)

		}

def stoArray(original):
	ugh = original.replace(']','').replace('[','')
	return ugh

