;;;; weather.lisp contains all code responsible for displaying a 7-day forecast


(in-package #:simple-weather.weather)


(define-easy-handler (locate :uri "/forecast" :default-request-type :post)(link address)
  (setf (hunchentoot:content-type*) "text/html")
  (let ((forecasts (get-forecast link)))
    (if forecasts
	(with-page (:title address)(:styles *styles*) 
	  (:div :class "banner" (:a :href "/" (:h2 "Simple U.S. Weather" ))
		(:h5 "Just the U.S. weather"))
	  (:br)
	  (:strong :class "outlook" (concatenate 'string address " - 7 day outlook"))
	  (:div :class "main-content"
		(dolist (forecast forecasts)
		  (:div :class "forecast-item" 
			(:h4 :class "main-date" (concatenate 'string
							     (format-timestring nil (simple-weather.forecast::start-time
										     (second forecast)) :format '(:long-weekday))
							     " - "
							     (first forecast)))
			(if (string= (simple-weather.forecast::is-day-time
				      (second forecast)) :TRUE)
			    (:strong :class "Day" "Day")
			    (:strong :class "Night" "Night"))
			
			(:br)
			(:i :class (simple-weather.forecast::icon (second forecast)))
			(:br)
			(:strong "Temperature: ") (:span (concatenate 'string  (write-to-string (simple-weather.forecast::temperature (second forecast))) "F")) (:br)
			(:strong "Wind Speed: ") (:span simple-weather.forecast::(wind-speed (second forecast)))(:br)
			(:strong "Wind Direction: ") (:span simple-weather.forecast::(wind-direction (second forecast)))(:br)
			(:p (simple-weather.forecast::detailed-forecast (second forecast)))
			(when (= (length (cdr forecast)) 2)
			  (:hr)
			  (:div
			   (if (string= (simple-weather.forecast::is-day-time
					 (second (cdr forecast))) :TRUE)
			       (:strong :class "Day" "Day")
			       (:strong :class "Night" "Night"))
			   
			   (:br)
			   (:i :class (simple-weather.forecast::icon (second (cdr forecast))))
			   (:br)
			   (:strong "Temperature: ") (:span (simple-weather.forecast::temperature (second (cdr forecast))))(:br)
			   (:strong "Wind Speed: ") (:span (simple-weather.forecast::wind-speed (second (cdr forecast))))(:br)
			   (:strong "Wind Direction: ") (:span (simple-weather.forecast::wind-direction (second (cdr forecast))))(:br)
			   (:p (simple-weather.forecast::detailed-forecast (second (cdr forecast))))))
			(:br)))))
	(with-page (:title address)(:styles *styles*) 
		     (:div :class "banner" (:a :href "/" (:h2 "Simple U.S. Weather" ))
			   (:h5 "Just the U.S. weather"))
		     (:br)
		     (:div :class "main-content"
			   (:h2 "There was an issue retrieving forecast."))))))
  
  
	      

