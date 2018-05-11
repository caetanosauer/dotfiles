#!/bin/bash
ninja -t compdb $(awk '/^rule (C|CXX)_COMPILER__/ { print $2 }' rules.ninja) > compile_commands.json
