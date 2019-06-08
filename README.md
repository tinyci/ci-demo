# tinyCI demo repository

This repository contains the vagrant demo for tinyCI. It, by default, runs one
instance of the tinyCI VM for UI and other services, and another for a docker
runner (overlay-runner). You can customize it to run multiple runners.

* Setup an [oauth account](https://github.com/settings/developers).
* Create a `customize.rb` from the sample file. Be sure to include the values from the step above!
* Run `make setup`.
* Assuming `make setup` succeeds, run `make start`.
