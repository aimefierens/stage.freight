# Stage Freight

Aimé Fierens


## Video Capture macOS

Video capture in Processing on macOS Catalina [is broken](https://github.com/processing/processing-video/issues/134). 

[Follow the solution here.](https://github.com/processing/processing-video/issues/134#issuecomment-550000519)

1. Go to `~/Documents/Processing/libraries` and delete the video folder, if it's there.
2. Download a new ZIP release from the [releases page](https://github.com/processing/processing-video/releases).
3. Unzip the folder into `~/Documents/Processing/libraries`.
4. Open the Terminal and type:

    cd ~/Documents/Processing/libraries
    xattr -r -d com.apple.quarantine video

