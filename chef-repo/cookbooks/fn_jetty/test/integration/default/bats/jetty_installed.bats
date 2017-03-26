#!/usr/bin/env bats

@test "git binary is found in PATH" {
  run service jetty status
  [ "$status" -eq 0 ]
}
