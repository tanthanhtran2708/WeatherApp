# WeatherApp

## Introduction

This is an ios application called WeatherApp to retrieve weather information based on their searching criteria and render the searched results on dashboard screen. You can checkout the demo video in the repository. The application is running on an iPhone XSMax version 14.7.1. The minimum OS version to run this application is **14.1**

## Functionalities

- The application is able to retrieve the weather information from OpenWeatherMaps API.
- The application is able to allow user to input the searching term.
- The application is able to proceed searching with a condition of the search term length must be from 3 characters or above.

## Folder structures

WeatherApp </br>
|-> Assets.xcassets: Including Assets [ App icon for example ] </br>
|-> Database: Handle API calling </br>
|-> LottieAnimations: Including animation files downloaded from Lotties </br>
|-> Models: Including application model </br>
|-> ViewModels: Including application view models </br>
|-> Views: Including application view components </br>

## Details

- WeatherApp is an iOS native application built entirely using **Swift** and **SwiftUI framework** in **MVVM [ Models - Views - View Models ]**.
- The main concept here is fetching and handling the weather data that we get supported by **OpenWeatherMaps Api**.
- This application also takes advantage of Lottie Animations for rendering Animation icons.

### Technical keywords

- Swift
- SwiftUI
- MVVM
- Lottie Animations
- OpenWeatherMaps API

## Comment for improvements

- Handling State using Observer / Observable -> The animation is not smooth.
- In order to support auto suggest when user's typing more than three characters, I decided to use raw data of country names and store them inside a Dictionary in CiyViewModel. -> Not Dynamic.
- Handling error: I use generic api calls and **.success / .failure** to handle the result and alert if there's any error.
- Should improve more in Unit testing / UI Testing

## Steps to run

- Cloning the application repo
- Build the application on device
- Remember to Trust the development team on device before launching and using the application.

## Requirement Checklists

| Requirements                                                                                                               | Checklist |
| -------------------------------------------------------------------------------------------------------------------------- | --------- |
| The application is a simple iOS application which is written by Swift.                                                     | ✅        |
| The application is able to retrieve the weather information from OpenWeatherMaps API.                                      | ✅        |
| The application is able to allow user to input the searching term.                                                         | ✅        |
| The application is able to proceed searching with a condition of the search term length must be from 3 characters or above | ✅        |
| The application is able to render the searched results as a list of weather items.                                         | ✅        |
| The application is able to load the weather icons remotely and displayed on every weather item at the right-hand side      | ✅        |
| The application is able to handle failures.                                                                                | ✅        |
| Tests [Unit test & UI Test]                                                                                                | ✅        |
