#!/bin/bash

# Install Flutter (if not installed)
if ! command -v flutter &> /dev/null
then
    echo "Flutter not found, installing..."
    git clone https://github.com/flutter/flutter.git -b stable --depth 1
    export PATH="$PATH:`pwd`/flutter/bin"
fi

# Enable web support
flutter config --enable-web

# Install dependencies
flutter pub get

# Build the web version
flutter build web

# Move the built files to the Vercel output directory
cp -r build/web/ public
