# Travel Buddies
An iOS application designed to connect individual travelers based on desired locations, interests, and schedules.

## Overview
Our app is called Travel Buddy. As the name suggested, the purpose of our app is to help people find travel buddies who have similar desired destinations and travel dates. For instance, a user may be interested in visiting Shanghai, China for spring break 2018. They will login to our app and enter some basic information:

| Feature      | User Selection  |
| ------------ | --------------- |
| Destination  | Shanghai, China |
| Start Date   | March 2         |
| End Date     | March 11        |
| Trip Types   | Sightseeing     |

Our app will store the user inputs in a built-in server, and then produce matches using our sorting algorithms. The application will allow the user to create a trip object with traits based on date, location, and type of trip. A user will be able to input the trip’s attributes and subsequently be connected to another user who has created a trip proposal with matching attributes so that they can fulfill their mutual goals. Users that have been matched will have experienced such because they created a trip object with a matching destination. However, it is also possible that users have been matched due to a common geographic vicinity or set time of travel.
The application will utilize the Google Maps API to geolocate a user and then find other users in a set area with common trip objects. When a user is submitting a trip proposal they will be able to utilize features of Google Maps, namely Google Places, to highlights points of interest and drop pins to be linked to their proposal. Based on both the user’s personal attributes (account characteristics) and trip requirements (trip characteristics), the application will search for a match among other currently “open” proposals. If a match is found, users will be notified and free to connect with each other for their next Travel Buddy-planned excursion.

## Resources
* Lynda.com, CodeAcademy, Youtube Tutorials
* [Start Developing iOS Apps](https://developer.apple.com/library/content/referencelibrary/GettingStarted/DevelopiOSAppsSwift/index.html#//apple_ref/doc/uid/TP40015214-CH2-SW1)
* [Google Maps SDK for iOS](https://developers.google.com/maps/documentation/ios-sdk/start)
* Stack Overflow Q&A’s
* The Swift Programming Language (Swift 4.0.3)
* A Concise Introduction to Software Engineering - Jalote
