cmake_minimum_required(VERSION 3.8)

project(fcitx5-table-cjeb VERSION 1.0.0)

find_package(ECM 1.0 REQUIRED)
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH} "${CMAKE_CURRENT_SOURCE_DIR}/cmake" ${CMAKE_MODULE_PATH})

include(FeatureSummary)
include(GNUInstallDirs)
include(ECMUninstallTarget)

find_package(Gettext REQUIRED)
find_package(LibIMETable REQUIRED)
find_package(Fcitx5Core REQUIRED)

set(MB_FILE)
set(CONF_FILE)

fcitx5_translate_desktop_file("cjeb.conf.in" "cjeb.conf")
add_custom_command(OUTPUT "cjeb.main.dict"
	DEPENDS "cjeb.txt"
	COMMAND LibIME::tabledict ARGS "${CMAKE_CURRENT_SOURCE_DIR}/cjeb.txt"
	"${CMAKE_CURRENT_BINARY_DIR}/cjeb.main.dict")
set(MB_FILE ${MB_FILE} "${CMAKE_CURRENT_BINARY_DIR}/cjeb.main.dict")
set(CONF_FILE ${CONF_FILE} "${CMAKE_CURRENT_BINARY_DIR}/cjeb.conf")

add_custom_target(table_data ALL DEPENDS ${MB_FILE})

install(FILES ${CONF_FILE} DESTINATION "${FCITX_INSTALL_PKGDATADIR}/inputmethod")
install(FILES ${MB_FILE} DESTINATION "${FCITX_INSTALL_PKGDATADIR}/table")

feature_summary(WHAT ALL FATAL_ON_MISSING_REQUIRED_PACKAGES)
