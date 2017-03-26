#!/usr/bin/env bats

@test "Verify that asterisk is runnning" {
  run asterisk -rvx 'reload'
  [ "$status" -eq 0 ]
}

@test "Recordings folder is own by asterisk" {
  run stat -c %U '/var/lib/fonoster/recordings'
  [ "$output" = "asterisk" ]
}

