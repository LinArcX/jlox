#!/usr/bin/bash
#
# raw command for building:
# javac src/Lox.java -d output/
#
# tools:
# opening/editing files: noevim
# lookup refrences: ctags
# find/replace in single files: neovim
# find/replace: ambr <source_text> <dest_text>
# find file names: ctrl-t | ff <file-name> | fzf | fd
# find text inside files: ft <text> | rg <text> |
# debugging: gdb build/output/linux/debug/$software_name
# find docs of c standard librariy: install man-pages-devel and man <method>

#general_flags="-Wall -std=c++17"
#debug_only_flags="-g -O0"
#release_only_flags="-O3"

software_name="lox"

p() {
  compiler="javac"
  src="src/*.java"
  output_debug="-d build/output/linux/debug/$software_name"
  output_release="-o build/output/linux/release/$software_name"

  commands=("build(debug)" "debug" "run(debug)" "clean(debug)" "build(release)" "run(release)" "clean(release)" "generate tags")
  selected=$(printf '%s\n' "${commands[@]}" | fzf --header="project:")

  case $selected in
    "build(debug)")
      echo ">>> Creating 'build/output/linux/debug' directory"
      mkdir -p "build/output/linux/debug"

      echo ">>> generating tags"
      ctags -R *

      echo ">>> Building app - (debug) mode"
      $compiler $src $output_debug
      ;;
    "debug")
      echo ">>> Debugging $software_name"
      jdb build/output/linux/debug/$software_name
      ;;
    "run(debug)")
      echo ">>> Running $software_name(debug mode)"
      ./build/output/linux/debug/$software_name &
      ;;
    "clean(debug)")
      echo ">>> Cleaning 'build/output/linux/debug' directory"
      rm -r "build/output/linux/debug" ;;
    "build(release)")
      echo ">>> Creating 'build/output/linux/release' directory"
      mkdir -p "build/output/linux/release"

      echo ">>> generating tags"
      ctags -R *

      echo ">>> Building app - (release) mode"
      $compiler $general_compiler_flags $release_only_flags $loader_flags $sdl_include_dir $sdl_include_libs_dir $imgui_dependencies $include_dirs $source_dirs $output_release
      ;;
    "run(release)")
      echo ">>> Running $software_name(release mode)"
      ./build/output/linux/release/$software_name
      ;;
    "clean(release)")
      echo ">>> Cleaning 'build/output/linux/release' directory"
      rm -r "build/output/linux/release" ;;
    "generate tags")
      ctags -R *;;
    *) ;;
  esac
}
