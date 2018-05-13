;;;======================================================
;;;     Vending machine FSM
;;;
;;;     This is a finite state vending machine.
;;;
;;;     To execute, merely load, reset and run.
;;;======================================================

(deffunction add_coins (?response)
        (if (or (eq ?response R5) (or (eq ?response r5) (eq ?response 5))) then
                (return 5))
        (if (or (eq ?response R2) (or (eq ?response r2) (eq ?response 2))) then
                (return 2))
        (if (or (eq ?response R1) (or (eq ?response r1) (eq ?response 1))) then
                (return 1))
        (if (or (eq ?response 50c) (or (eq ?response 50C) (eq ?response 0.50))) then
                (return 0.50))
        (if (or (eq ?response 20c) (or (eq ?response 20C) (eq ?response 0.20))) then
                (return 0.20))
        (if (or (eq ?response 10c) (or (eq ?response 10C) (eq ?response 0.10))) then
                (return 0.10)))

(deffunction selected-item-price (?answer)
        (if (eq ?answer 1) then
                (bind ?total-price 9.50))
        (if (eq ?answer 2) then
                (bind ?total-price 10.00))
        (if (eq ?answer 3) then 
                (bind ?total-price 13.50))
        (if (eq ?answer 4) then
                (bind ?total-price 15.00))
        (printout t "You have chosen an item you want to buy, You must pay: R" ?total-price "0"crlf)
        (while (> ?total-price 0)
                (printout t "Enter amount : (10c, 20c, 50c, R1, R2, R5)" crlf)
                (bind ?total-price (- ?total-price (add_coins (read))))
                (if (>= ?total-price 0) then
                (printout t "Left to pay: " ?total-price crlf)))
        (printout t "You have no outstanding amount, your change is : R" (* ?total-price -1) crlf))


(deftemplate total_paid (slot balance))
(deftemplate fizzy_drink (slot price))
(deftemplate simba_chips (slot price))
(deftemplate peanuts (slot price))
(deftemplate jelly_beans (slot price))

(deffacts item-prices
        (fizzy_drink (price 9.50))
        (simba_chips (price 10.00))
        (peanuts (price 13.50))
        (jelly_beans (price 15.00)))

(defrule vending-questions
        =>        
        (printout t "Choose item you want to purchase, enter number (1-4): " crlf
                    "1. Fizzy Drink 330 ml: R9.50" crlf
                    "2. Simba Chips 330 g: R10.00" crlf
                    "3. Peanuts: R13.50" crlf
                    "4. Jelly Beans: R15.00" crlf)
        (selected-item-price(read))
(printout t crlf))