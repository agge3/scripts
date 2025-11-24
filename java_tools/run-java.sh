#!/usr/bin/env bash

# Paths to Java and JavaFX
java="/usr/lib/jvm/java-23-openjdk/bin/java"
lib="/usr/lib/jvm/lib"
javafx="javafx-swt.jar,javafx.base.jar,javafx.controls.jar,javafx.fxml.jar,javafx.media.jar,javafx.swing.jar,javafx.web.jar"

# Check if an argument is passed
if [ $# -eq 0 ]; then
    echo "Usage: $0 <JavaFXMainClass>"
    echo "Example: $0 com.example.MainApp"
    exit 1
fi

# JavaFX main class
main_class="$1"

# Run the JavaFX application
"$java" \
    --module-path "$lib" \
    --add-modules "$javafx" \
    "$main_class"
