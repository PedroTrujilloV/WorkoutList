# WorkoutList
This app that displays a list of workout exercises in a beautiful double collum collection view in portratit mode.  When tapping in any exercise collection cell, the app will display a description view of this contained more detailed information about this, image with higher resolution (if availabe), complete description text, category and equipment. 

### Technologies and APIsused:

·         MVVM
·         UICollectionView
·         UICollectionViewCell
·         UIViewController
·         UICollectionViewFlowLayout
·         URLSession
·         RESTful JSON API
·         Image caching 
·         Pagination
·         Generics
·         Delegation
·         Callbacks 
·         Dark mode dynamic colors 
·         Unit Testing
·         etc.

### Instructions for running the app:
Necessary to have Xcode installed before. Download the repository, once downloaded open the xcodeproj file and run it. If the build fase fails, make sure you have a simulator selected, or a real device ( iPhone or iPad ) connected, also make sure you have configured the team and the bundle identifier. 

### Peding or nice to have:

·         More unit testing
·         UI testing
·         Packages for common components
·         Test and improve the image caching 



## iOS Homework Assessment


### Goals

·         Spend 2-3 hours to show us an example of your practical coding knowledge
·         Please use Swift and any dependent libraries you would like to pull in. If you decide to use something new, let us know, but also feel free to use what you're most comfortable with. The goal is not to validate your knowledge of a technology. 

 

### APIs
https://wger.de/en/software/api 
Given an endpoint that returns a JSON response of all exercises:
https://wger.de/api/v2/exercise/?language=2&format=json 
Build a page that displays as many exercises as possible, allowing the user to eventually see all if desired. Each item in the list, should display exercise name & description. When a specific exercise is selected, the user is presented with additional details about the corresponding exercise, including category name, equipment, & thumbnail, which can be retrieved by replacing the exercise id in the following endpoints:
https://wger.de/api/v2/exerciseinfo/<id>/?language=2&format=json
https://wger.de/api/v2/exerciseimage/<id>/thumbnails/?is_main=True&language=2&format=json 

 

 

Things to consider:

·         Exercises may change periodically, so let's make sure to show the most recent list of items

·         Exercises should be sorted by name

·         Code should be maintainable and testable

 

Advice

·         Try to consider this as you would a production quality project to help us see how you write clean, maintainable code. Build something you would be okay with shipping it to a user and building onto over time.

·         If time allows, please write some unit tests and documentation for any key functionality you want to highlight or clarify its use (and for later maintainability)


