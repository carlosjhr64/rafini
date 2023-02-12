@version
Feature: Testing rafini version

  Background:
    * Given command "rafini"

  Scenario: --version
    * Given option "--version"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout matches /^\d+\.\d+\.\d+$/

  Scenario: -v
    * Given option "-v"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout matches /^\d+\.\d+\.\d+$/
