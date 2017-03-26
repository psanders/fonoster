#!/usr/bin/env bats

@test "Verify if lame is installed" {
  run which lame
  [ "$status" -eq 0 ]
}

@test "Verify if sox is installed" {
  run which sox
  [ "$status" -eq 0 ]
}

@test "Does fonoster user exist?" {
  run id -u fonoster
  [ "$status" -eq 0 ]
}
