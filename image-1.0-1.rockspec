
package = "image"
version = "1.0-1"

source = {
   url = "image-1.0-1.tgz"
}

description = {
   summary = "An image processing toolbox, for Torch.",
   detailed = [[
         An image processing toolbox: to load/save images,
         rescale/rotate, remap colorspaces, ...
   ]],
   homepage = "",
   license = "MIT/X11" -- or whatever you like
}

dependencies = {
   "lua >= 5.1",
   "torch",
   "xlua"
}

build = {
   type = "cmake",

   cmake = [[
         cmake_minimum_required(VERSION 2.8)

         set (CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR})

         find_package (Torch REQUIRED)
         find_package (jpeg QUIET)

         set (CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)

         if (JPEG_FOUND)
             include_directories (${JPEG_INCLUDE_DIR} ${TORCH_INCLUDE_DIR} ${PROJECT_SOURCE_DIR})
             add_library (jpeg SHARED jpeg.c)
             target_link_libraries (jpeg ${TORCH_LIBRARIES} ${JPEG_LIBRARIES})
             install_targets (/lib/lua/5.1/ jpeg)
         else (JPEG_FOUND)
             message ("WARNING: Could not find JPEG libraries, jpeg wrapper will not be installed")
         endif (JPEG_FOUND)

         include_directories (${TORCH_INCLUDE_DIR} ${PROJECT_SOURCE_DIR})
         add_library (image SHARED image.c)
         link_directories (${TORCH_LIBRARY_DIR})
         target_link_libraries (image ${TORCH_LIBRARIES})

         install_files(/share/lua/5.1/ image.lua lena.jpg lena.png win.ui)
         install_targets(/lib/lua/5.1/ image)
   ]],

   variables = {
      CMAKE_INSTALL_PREFIX = "$(PREFIX)"
   }
}