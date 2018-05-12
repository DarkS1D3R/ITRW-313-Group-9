;;;======================================================
;;;     Vending machine FSM
;;;
;;;     This is a finite state vending machine.
;;;
;;;     To execute, merely load, reset and run.
;;;======================================================
;//NOTE: not complete or working

;//templates   
(deftemplate current-value(slot cval))
(deftemplate products(slot product))
(deftemplate current-balance(slot x))  

;//initialize the current-value of the machine
(deffacts vending-machine
   (current-value(cval 0))) 
   
;//ask the client to select a product  
(defrule product-selection (products(product ?product))
=>
(printout t "Please select the product you want and place the amount due in coins into the machine" crlf)
(printout t "Product 1: Orange R10.00" crlf)
(printout t "Product 2: Cola R8.50" crlf)
(printout t "Product 3: Chocolate R15.00" crlf)
(printout t "Product 4: Sweets R12.50" crlf)

(bind ?product (read))
(assert(product ?product)))

;//determine the product select	
(defrule determine_Orange (products(product ?product))
(test (eq ?product Orange))
=>
(assert (product Orange))
(assert (current-value (cval 10.00)))
(printout t "Product selected: Orange R10.00" crlf))
	
(defrule determine_Cola (products(product ?product))
(test (eq ?product Cola))
=>
(assert (product Cola))
(assert (current-value(cval 8.50)))
(printout t "Product selected: Cola R8.50" crlf))

(defrule determine_Chocolate (products(product ?product))
(test (eq ?product Chocolate))
=>
(assert (product Chocolate))
(assert (current-value (cval 15.00)))
(printout t "Product selected: Chocolate R15.00" crlf))

(defrule determine_Sweets (products(product ?product))
(test (eq ?product Sweets))
=>
(assert (product Sweets))
(assert (current-value (cval 12.50)))
(printout t "Product selected: Sweets R12.50" crlf))

;//ask the customer for a coin 
(defrule ask-coin-rule
	?f1 <- (current-balance (x ?x1))
	?f2 <- (current-value (cval ?cval1))
	(test (<= ?x1 ?cval1))
	=>
	(printout t "Please place a 10c, 20, 50c, R1, R2, R5 coin into the machine to add to the total amount of " ?x1 "c -->" crlf)
	(bind ?coin (read))
	(if (or (eq ?coin 10c) (eq ?coin 10)) 
		 then
		(bind ?sum (+ ?x1 0.10) )
		(modify  ?f1 (x ?sum))
	 else
		(if (or (eq ?coin 20c) (eq ?coin 20)) 
		 	then
			(bind ?sum (+ ?x1 0.20) )
			(modify  ?f1 (x ?sum)) )
	else
		(if (or (eq ?coin 50c) (eq ?coin 50c))
			then
			(bind ?sum (+ ?x1 0.50))
			(modify ?f1 (x ?sum)))
	else
		(if (or (eq ?coin R1) (eq ?coin 1))
			then
			(bind ?sum (+ ?x1 1))
			(modify ?f1 (x ?sum)))
	else
		(if (or (eq ?coin R2) (eq ?coin 2))
			then
			(bind ?sum (+ ?x1 2))
			(modify ?f1 (x ?sum)))
	else
		(if (or (eq ?coin R5) (eq ?coin 5))
			then
			(bind ?sum (+ ?x1 5))
			(modify ?f1 (x ?sum)))
	)
	
	(printout t "The new total amount is : R" ?sum  crlf)
	(printout t "" crlf)
)

	


