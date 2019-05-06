from flask_sqlalchemy import SQLAlchemy
import csv
from sqlalchemy import *
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from sqlalchemy.sql import *
from db import db, Place


engine = create_engine('sqlite:///places.db')
Place.__table__.create(bind=engine, checkfirst=True)


cornellplaces = []
with open('data.csv', newline='') as csvfile:
     reader = csv.DictReader(csvfile)
     for row in reader:
     	health = {}
     	health["name"] = row['Name']
     	health["img"] = row['Image Name']
     	health["phone"] = row['Phone']
     	health["hours"] = row['Hours']
     	health["address"] = row['Address']
     	health["website"] = row['Website']
     	health["category"] = row['category']
     	health["time"] = row['Time (filter)']
     	health["location"] = row['Location (filter)']
     	health["coordinates"] = row['coordinates']
     	cornellplaces.append(health)

Session = sessionmaker(bind=engine)
session = Session() 
for cornellplace in cornellplaces:
    row = Place(**cornellplace)
    session.add(row)
session.commit()