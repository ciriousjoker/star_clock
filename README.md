# Star Clock

This is my entry for the [Flutter Clock Face Contest](https://flutter.dev/clock).

Build instructions below.
TLRD: Clone with `--recurse-submodules`

![https://www.youtube.com/watch?v=ZuHLtdbaXqc](./star_clock/third_party/youtube-logo/yt_logo_rgb_light.png =250x250)

### Screenshots

| Day (sunny)  | Night        |
| ------------ | ------------ |
| Content Cell | Content Cell |

#### Weather (other)

| Cloudy       | Foggy        | Rainy        |
| ------------ | ------------ | ------------ |
| Content Cell | Content Cell | Content Cell |

| Snowy        | Thunderstorm | Windy        |
| ------------ | ------------ | ------------ |
| Content Cell | Content Cell | Content Cell |

### Building

-   `git clone --recurse-submodules https://github.com/ciriousjoker/star_clock`
-   `cd star_clock`
-   `flutter create .`
-   `flutter run --android` (tested) or `flutter run --ios` (untested)

### Notes

-   If Android produces a build error (something about plugins), delete the MainActivity.kt file and try again. This bug appeared in flutter beta. I couldn't reproduce it on flutter stable, but who knows what happens.
-   The web version has issues:
    -   shadow bug on hud
    -   performance issue
    -   WAY too strong glow on moon
    -   thunderstorm freezes the page
    -   svg icon doesn't render
