# OpenBank - Mobile Test - Marvel Characters

Simple app that shows the Marvel characters and the details of each one

## Starting 🚀
_It was built with twist that is a command line tool that helps me to generate, maintain and interact with Xcode project._

### Requirements 📋

```
- Xcode 13+
- Swift 5
- MacOS BigSur+
```

### Install and Run 🔧

_Just execute the "Marvel.xcworkspace" file and run the project on iOS device._

## Tests execution ⚙️

_To execute the services tests just go to file "MarvelServicesTests" and clic run to the right side of the class **"test_succesGettingMarvelCharacters" and "test_succesGettingMarvelCharacterDetail" tests are network dependency_

_To execute the UI tests just go to file "MarvelUITestsLaunchTests" and clic run to the right side of the class **"test_screenPresentingCharacterDetialSuccess()" test is network dependency because it needs results to navigate to the detail screen_

### Architecture 🧑‍💻

_It was built with MVP architecture but adding a coordinator to manage the navigation. The decision to use it above other architectures was because the app complexity not requires more and MVVM is better for reactive programing._

## Built with 🛠️

* [Tuist](https://github.com/tuist/tuist) - 2.3.2
* [Xcode](https://developer.apple.com/xcode/) - 13
* [Swift](https://www.swift.org/documentation/) - 5


## Developer ✒️

* **Juan Carlos Carrera Reyes** - *Marvel Characters* - [carreracarlosglobant](https://github.com/carreracarlosglobant)


## Licence 📄

This project is under MIT licence - [LICENSE.md](LICENSE.md) for more detail

## Thanks for reading me 🎁
