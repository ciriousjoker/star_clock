# Star Clock

This is my entry for the [Flutter Clock Face Contest](https://flutter.dev/clock).

Build instructions below.
**TLRD:** Clone with `--recurse-submodules`

#### Here's a small demo video:

<a href='https://www.youtube.com/watch?v=ZuHLtdbaXqc'><img alt='Watch demo on YouTube' src='assets_readme/youtube-banner/YouTube Banner v2.png' height="32px"/></a>

### Screenshots

| Day mode (sunny)                                | Night mode                                      |
| ----------------------------------------------- | ----------------------------------------------- |
| ![Sunny](./assets_readme/screenshots/sunny.png) | ![Night](./assets_readme/screenshots/night.png) |

#### Weather (other)

| Cloudy                                            | Foggy                                           | Rainy                                           |
| ------------------------------------------------- | ----------------------------------------------- | ----------------------------------------------- |
| ![Cloudy](./assets_readme/screenshots/cloudy.png) | ![Foggy](./assets_readme/screenshots/foggy.png) | ![Rainy](./assets_readme/screenshots/rainy.png) |

| Snowy                                           | Thunderstorm                                                  | Windy                                           |
| ----------------------------------------------- | ------------------------------------------------------------- | ----------------------------------------------- |
| ![Snowy](./assets_readme/screenshots/snowy.png) | ![Thunderstorm](./assets_readme/screenshots/thunderstorm.png) | ![Windy](./assets_readme/screenshots/windy.png) |

### Building

-   `git clone --recurse-submodules https://github.com/ciriousjoker/star_clock`
-   `cd star_clock`
-   `flutter create --org de.ciriousjoker .`
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

### Legal

This project is licensed under the [MIT License](LICENSE).

The weather icon collection has its own license as described [here](https://github.com/erikflowers/weather-icons/#licensing).
At the time of writing this, this means OFL for the icons, MIT for the code & CC BY 3.0 for the documentation.

©2020 Google LLC All rights reserved. YouTube is a trademark of Google LLC.
