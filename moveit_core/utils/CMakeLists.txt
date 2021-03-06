set(MOVEIT_LIB_NAME moveit_utils)

add_library(${MOVEIT_LIB_NAME} SHARED
  src/lexical_casts.cpp
  # src/xmlrpc_casts.cpp # TODO: solve the conflicts with xmlrpc dependencies
)

include_directories(include)
ament_target_dependencies(${MOVEIT_LIB_NAME} visualization_msgs)
set_target_properties(${MOVEIT_LIB_NAME} PROPERTIES VERSION "${${PROJECT_NAME}_VERSION}")

install(TARGETS ${MOVEIT_LIB_NAME}
        LIBRARY DESTINATION "lib"
        ARCHIVE DESTINATION "lib")

if(BUILD_TESTING)
  find_package(ament_cmake_gtest REQUIRED)
  find_package(moveit_resources REQUIRED)
  set(MOVEIT_TEST_LIB_NAME moveit_test_utils)

  add_library(${MOVEIT_TEST_LIB_NAME}
    src/robot_model_test_utils.cpp)

	include_directories(${moveit_resources_INCLUDE_DIRS})

  target_link_libraries(${MOVEIT_TEST_LIB_NAME}
    ${Boost_LIBRARIES}
    ${urdf_LIBRARIES}
    ${srdfdom_LIBRARIES}
    ${urdfdom_LIBRARIES}
    ${urdfdom_headers_LIBRARIES}
  )

  set_target_properties(${MOVEIT_TEST_LIB_NAME} PROPERTIES VERSION "${${PROJECT_NAME}_VERSION}")

  ament_export_libraries(${MOVEIT_TEST_LIB_NAME} ${MOVEIT_LIB_NAME})
  ament_export_include_directories(include)

  install(TARGETS
    ${MOVEIT_TEST_LIB_NAME}
    LIBRARY DESTINATION "lib"
    ARCHIVE DESTINATION "lib")
endif()

install(DIRECTORY include/ DESTINATION "include")
