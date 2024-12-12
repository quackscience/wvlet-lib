# wvlet-lib

Action builder for [wvlet-lib](https://github.com/wvlet/wvlet/tree/main/wvc-lib)

## wvlet-lib vcpkg Package

`wvlet-lib` is a custom library distributed as both static and dynamic binaries for various platforms. This repository provides a `vcpkg` package to simplify the integration of `wvlet-lib` into your projects.

### Features
- Prebuilt static and dynamic libraries.
- Supported platforms:
  - Linux _(x64, arm64)_
  - macOS _(arm64)_

### Example
```json
{
  "dependencies": [
    "wvlet-lib"
  ],
  "overrides": [
    {
      "name": "wvlet-lib",
      "version-string": "0.0.1",
      "repository": "https://github.com/quackscience/wvlet-lib.git"
    }
  ]
}
```
