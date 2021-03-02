#! /usr/bin/env bash
set -e
icecc `echo $@ | sed 's/-o /-Wno-unreachable-code -Wno-parentheses-equality -Wno-constant-logical-operand -Wno-parentheses-equality -Wno-logical-op-parentheses -Wno-zero-as-null-pointer-constant -Wno-unevaluated-expression -Wno-unreachable-code-return -o/'`
