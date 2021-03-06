;;;; simple-weather.asd

(asdf:defsystem #:simple-weather
  :description "Simple-weather is just a simple interface for weather.gov's local forecast apis"
  :author "Brian Beegan brianbeegan@protonmail.com"
  :license  "MIT License"
  :version "0.0.1"
  :serial t
  :depends-on (#:drakma
	       #:hunchentoot
	       #:spinneret
	       #:spinneret/ps
	       #:parenscript
	       #:st-json
	       #:str
	       #:local-time
	       #:quri)
  :components ((:file "package")
	       (:module "app"
		:serial t
		:components ((:file "common")
			     (:file "server")
			     (:file "landing")
			     (:file "forecast")
			     (:file "location")
			     (:file "weather")))
	       (:file "simple-weather")))
