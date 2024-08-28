cmake_minimum_required(VERSION 3.16)

list(APPEND CMAKE_PREFIX_PATH "-DQt6_DIR=~/Qt6_DIR/")

project(compas_direction_averaging VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

# set(CMAKE_BUILD_TYPE Release)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick Test)

qt_standard_project_setup()

qt_add_executable(appcompas_direction_averaging
    main.cpp
)

qt_add_qml_module(appcompas_direction_averaging
    URI compas_direction_averaging
    VERSION 1.0
    QML_FILES
        Main.qml
        SOURCES DirectionAvg.h DirectionAvg.cpp
    SOURCES
        DirectionAvg.cpp
        DirectionAvg.h
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appcompas_direction_averaging PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appcompas_direction_averaging
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appcompas_direction_averaging
    PRIVATE Qt6::Quick
)



enable_testing()

function(add_qt_test TARGET)
    add_executable(${TARGET} ${ARGN})
    add_test(NAME ${TARGET} COMMAND ${TARGET})
    target_link_libraries(${TARGET} PRIVATE Qt6::Quick Qt6::Test)
endfunction()

# add_qt_test(test_direction_avg_calculation directionavgtest.cpp)

include(GNUInstallDirs)
install(TARGETS appcompas_direction_averaging
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
