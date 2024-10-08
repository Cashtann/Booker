# Special thanks to "uxwing.com" and "unsplash.com" for great and free asstets

cmake_minimum_required(VERSION 3.16)

project(Booker VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_AUTORCC ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)

qt_standard_project_setup()

qt_add_executable(appBooker
    main.cpp
)

qt_add_qml_module(appBooker
    URI Booker
    VERSION 1.0
    QML_FILES
        Main.qml
        QML_FILES AppHeaderSection.qml
        QML_FILES AppStyle.qml
        SOURCES
        QML_FILES HeaderText.qml
        QML_FILES IconButton.qml
        QML_FILES MainPage.qml
        SOURCES
        QML_FILES OfferPage.qml
        SOURCES OffersController.h OffersController.cpp
        QML_FILES
        RESOURCES
        QML_FILES OffersList.qml
        RESOURCES res.qrc
        SOURCES
        SOURCES
        SOURCES CategoryInfo.h CategoryInfo.cpp
        SOURCES ElementInfo.h ElementInfo.cpp
        SOURCES
        SOURCES ElementModel.h ElementModel.cpp
        QML_FILES ScrollPageTemplate.qml
        SOURCES Manager.h Manager.cpp
        QML_FILES ColoredIcon.qml
        QML_FILES RoundIconButton.qml
        SOURCES Utilities.h Utilities.cpp
        SOURCES LocationInfo.h LocationInfo.cpp
        SOURCES LocationModel.h LocationModel.cpp
        QML_FILES IconText.qml
        QML_FILES StarRating.qml
        QML_FILES AboutPage.qml
        QML_FILES ColoredButton.qml
        QML_FILES ColoredInput.qml
        QML_FILES PopupWindow.qml
        SOURCES CartController.h CartController.cpp
        QML_FILES SquareIconButton.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appBooker PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appBooker
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appBooker
    PRIVATE Qt6::Quick
)

set_target_properties(appBooker PROPERTIES QT_WASM_INITIAL_MEMORY "150MB")

include(GNUInstallDirs)
install(TARGETS appBooker
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
