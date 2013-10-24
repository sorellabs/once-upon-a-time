hifive = require 'hifive'
tap    = require 'hifive-tap'
specs  = require './specs'

(hifive.run specs, tap!).otherwise -> process?.exit 1
