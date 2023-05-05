#!/usr/bin/bash
#
# we're our terminal/shell as our IDE! it's a unixy way to develop software :)
# there's a project.sh in roof of the project. before doing anything, source it: . project.sh
#
# opening/editing files: noevim
#   folding/unfolding: z Shift+m, z Shift+r
#   switch between source/header: F1
#
# lookup refrences: ctags
# opening/editing files: noevim
# find/replace in single file: neovim
# find/replace in whole project: ambr <source_text> <dest_text>
# find files: ctrl-t | ff <file-name> | fzf | fd
# find string/text in single file: neovim (/)
# find string/text in whole project: ft <text> | rg <text>
# find docs of c standard librariy: install man-pages-devel and man <method>
#
# debugging: jdb $build_dir/$mode/$app
#   set breakpoint: b 1
#   start debugging: start
#   from this phase, for faster moving between files and methods, you can switch to single-key-mode: C-x s. and here are the commands in this mode:
#     q - quit, exit SingleKey mode.
#     c - continue
#     d - down
#     f - finish
#     n - next
#     r - run
#     s - step
#     u - up
#     v - info locals
#     w - where

app="Lox"
mode="debug"
build_dir="build/output/linux"

p() {
  # raw command for building:
  # javac src/Lox.java -d output/

  compiler="javac"
  src="src/*.java"
  output="-d $build_dir/$mode"

  commands=("build" "debug" "run" "clean" "generate tags")
  selected=$(printf '%s\n' "${commands[@]}" | fzf --header="project:")

  case $selected in
    "build")
      echo ">>> Creating '$build_dir/$mode' directory"
      mkdir -p "$build_dir/$mode"

      echo ">>> generating tags"
      ctags --languages=java -R src/*

      echo ">>> Building $app - $mode"
      $compiler $src $output
      ;;
    "debug")
      if [ "$mode" == "debug" ]; then
        echo ">>> Debugging $app"
        jdb $build_dir/$mode/$app
      else
        echo "you're not in debug mode!"
      fi
      ;;
    "run")
      echo ">>> Running $app - $mode"
      cd $build_dir/$mode
      java $app
      cd ../../../..
      ;;
    "clean")
      echo ">>> Cleaning '$build_dir/$mode' directory"
      rm -r "$build_dir/$mode" ;;
    "generate tags")
      ctags --languages=java -R src/*;;
    *) ;;
  esac
}
