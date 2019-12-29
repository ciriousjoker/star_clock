# Star Clock

This is my entry for the [Flutter Clock Face Contest](https://flutter.dev/clock).

Build instructions below.
TLRD: Clone with `--recurse-submodules`

![https://www.youtube.com/watch?v=ZuHLtdbaXqc](./star_clock/third_party/youtube-logo/yt_logo_rgb_light.png =250x250)

### Screenshots

| Day mode (sunny)                   | Night mode                        |
| ---------------------------------- | --------------------------------- |
| ![Sunny](./screenshots/cloudy.png) | ![Night](./screenshots/night.png) |

#### Weather (other)

| Cloudy                              | Foggy                             | Rainy                             |
| ----------------------------------- | --------------------------------- | --------------------------------- |
| ![Cloudy](./screenshots/cloudy.png) | ![Foggy](./screenshots/foggy.png) | ![Rainy](./screenshots/rainy.png) |

| Snowy                             | Thunderstorm                                    | Windy                             |
| --------------------------------- | ----------------------------------------------- | --------------------------------- |
| ![Snowy](./screenshots/snowy.png) | ![Thunderstorm](./screenshots/thunderstorm.png) | ![Windy](./screenshots/windy.png) |

### Building

-   `git clone --recurse-submodules https://github.com/ciriousjoker/star_clock`
-   `cd star_clock`
-   `flutter create .`
-   `flutter pub run flutter_launcher_icons:main`
-   `flutter run --release`

### Notes

-   If Android produces a build error (something about plugins), delete the MainActivity.kt file and try again. This bug appeared in flutter beta. I couldn't reproduce it on flutter stable, but who knows what happens.
-   The web version has issues:
    -   shadow bug on hud
    -   performance issue
    -   WAY too strong glow on moon
    -   thunderstorm freezes the page
    -   svg icon doesn't render
