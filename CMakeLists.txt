cmake_minimum_required(VERSION 3.16)

project(CID VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(QT_QML_GENERATE_QMLLS_INI ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

set(CMAKE_AUTORCC ON)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appCID
    main.cpp
)

qt_add_qml_module(appCID
    URI CID
    VERSION 0.1
    QML_FILES
        Main.qml
        HMI/AC.qml
        HMI/App.qml
        HMI/ControlCenter.qml
        HMI/Home.qml
        HMI/Settings.qml
        Components/StatusBar.qml
        Components/LeftNav.qml

    SOURCES
        Interface/Interface.h
        Interface/Interface.cpp
        RESOURCES resources.qrc
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appCID PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appCID
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appCID
    PRIVATE Qt6::Quick
)

install(TARGETS appCID
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
