# CUMentalHealth
A consolidation of Cornell's mental health services

# Purpose
CUMentalHealth aims to create one place to find and learn about Cornell's mental health resources in an effort to connect students with support more easily.

# How it works
Upon starting the app, the user is presented with a list of all resources in our database along with filters by the type of resource, times available, and locations on campus. Clicking on a filter will accordingly filter out any resource that doesn't match the filter chosen. Additional filtering can be done using the search bar at the top of the page, where the user can search by name of the resource or filters it falls under. Clicking on a resource presents the user with a page including the name of the resource, location on a map, hours available, website and phone number for more information. The map can be interacted with to the scope desired and the buttons pressed to navigate to the website linked or to call the phone number provided. 

# Features

iOS
  - Receives data for resources from API request
  - Uses UICollectionView for filters and UITableView for resources
  - Uses UISearchBar for searching name of resource or filter
  - Upon clicking table cells, navigates to Modal View Controller that displays specific information + location on map
  - Modal View Controllers contain 2 buttons to open website or call phone number listed
  
Backend
  - API: https://paper.dropbox.com/doc/Mental-Health-API-Spec--AchqvyA2wpGND6d3xgUwf7z5AQ-N8vhlp4KTNcUEOrU2q77Z
  - Uses SQLAlchemy
  - Deployed to Google Cloud
 
# Screen Images
[https://github.com/luOlivia/CUMentalHealth/blob/master/IMG_2360.PNG|alt=img1]
