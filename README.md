# SAMS ios-main
## _SAMS Proximity - iOS mobile application_

![Website status](https://img.shields.io/website-up-down-green-red/http/wegorz.uk)

SAMS Proximity is an application build for iOS operating system (iPhone) that allows user to check their attendance without any hassle and effortlessly. The only thing that is required to start attendance checking is to login into the application and the system will automatically hold background processes and communication with the API. Additionally, user have to give permissions for using bluetooth, location and background access. The system only connect to the API if and only if the beacon that send the signal is assigned to developers account. Therefore, the location is not tracked outside the university.

### _The API can be accessed from_:
- [API - ```requires additional input. Otherwise 404```][api/*] 

### _API choices are (replace * with one from below)_:
- room/<optional int>
- attendance/<optional int>
- building/<optional int>
- course/<optional int>
- module/<optional int>
- users/<optional int>

## Features

- Login to system with existing credentials
- Check if your attendance has been correctly recognised
- See your name, username and email
- See room details once you are inside
- GET user and room data from api
- POST attendance data to api

## Requires additional work in future

> As every piece of software, SAMS Proximity requires additional work 
> in order to improve the way it works and its performance.
> Until now there are few issues recognised with this software.

### _To improve:_
- [ ] Stability of the application once in background
- [ ] Fix issue with login
- [ ] Improve the code quality (Add MVC for better maintability)
- [ ] Improve user interface (Currently works best with devices with bigger screen. Tested iPhone 12 Pro Max) - Storyboards -> SwiftUI
- [ ] Update estimote SDK

# Tech

SAMS ios-main utilises Cocoa pods dependency manager with three dependencies.

### Programming languages

- [Swift 5.2][swift-lang] - The application was created using swift language and swift Storyboards for the User Interface

### SDKs

- [EstimoteProximitySDK v1.6.1][estimote] - Estimote SDK for beacons

### Cocoa dependencies

- [EstimoteProximitySDK v1.6.1][estimote] - Estimote SDK for beacons
- [Alamofire v5.2][alamo] - Used for API calls
- [SwiftKeychainWrapper v. latest][keychain] - Keychain wrapper utilies iphone keychain for storing user credentials


# Installation

SAMS Proximity runs on 
- [ ] &nbsp; \(Not supported) &nbsp; ~~Android~~ 
- [x] &nbsp; iOS

Preparing application to run

1. Download the repository [iOS][sams-ios] and [pods][sams-ios-pods] 
2. Create a new folder and change its name to something meaningful e.g. SAMS Proximity ios
3. Put both repositories in the directory you have just created
4. Run file with .xcworkspace extension

```sh
cd sams-python-wlan
python3 -m pip install -r requirements.txt
```
_Check if any errors occurred. If there are any errors report them to the [Owner][my_email]. In message provide error log from swift or screenshot with the issue._

If there are no errors run the application:
1. ```Connect your phone to mac```
2. ```Select your device from the devices list *```
3. ```Hit button that looks like 'Play'```
4. ```Unlock your phone```
5. ```Grant the permissions```
6. ```Login **```


\
``` * ``` &nbsp; ``` Program runs only on real devices. Simulator will not work```\
``` ** ``` &nbsp; ``` Application may not login on the first go. Just try again```


### Accessing the website 
To check if the program is running correctly wait until the application will notify you that attendance has been sent to the system and go to [API][api/att] to confirm that the attendance is there. 
```Remember that the application will only work with the beacons that has appropriate tags set to them and only if the owner has them in their own account```


# Related repositories

![Github badge](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white) ![iOS badge](https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=ios&logoColor=white)
[iOS pods required for the app][sams-ios-pods]

![Github badge](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white) ![Django badge](https://img.shields.io/badge/Django-092E20?style=for-the-badge&logo=django&logoColor=white) ![MongoDB badge](https://img.shields.io/badge/MongoDB-4EA94B?style=for-the-badge&logo=mongodb&logoColor=white) ![Ubuntu badge](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)
[Smart Attendance Monitoring System][sams] 

![Github badge](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white) ![iOS badge](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
[SAMS python script for Raspberry PI][sams-py-wlan] 

![](https://img.shields.io/badge/Microsoft_Outlook-0078D4?style=for-the-badge&logo=microsoft-outlook&logoColor=white) ![](https://img.shields.io/badge/Ask%20me-anything-1abc9c.svg)
[My university email][my_email]


[api/*]: <https://wegorz.uk/api/*>
[api/att]: <https://wegorz.uk/api/attendance>
[swift-lang]: <https://developer.apple.com/swift/>

[estimote]: <https://cocoapods.org/pods/EstimoteProximitySDK>
[keychain]: <https://cocoapods.org/pods/SwiftKeychainWrapper>
[alamo]: <https://cocoapods.org/pods/Alamofire#520>
[my_email]: <mailto:P17237274@my365.dmu.ac.uk>

[sams-ios]: <https://github.com/wegosh/sams-ios-main>
[sams-ios-pods]: <https://github.com/wegosh/sams-ios-pods>
[sams-py-wlan]: <https://github.com/wegosh/sams-python-wlan>
[sams]: <https://github.com/wegosh/FYP-smart-attendance-system>
