# Package
version       = "0.1.2"
author        = "Thomas T. Jarløv (https://github.com/ThomasTJdev)"
description   = "Nimble with GUI"
license       = "MIT"
bin           = @["nimblegui"]
skipDirs      = @["private"]
skipExt       = @["glade"]

# Dependencies
requires "nim >= 0.18.1"
requires "uibuilder >= 0.2.1"
requires "ui >= 0.9.2"


# Checks
import distros
task setup, "Setup started":
  if detectOs(Windows):
    echo "Cannot run on Windows"
    quit()
