﻿(define (make-account balance password)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define passwords (list password))
  (define (joint-password new-password)
    (set! passwords (cons new-password passwords)))
  (define (dispatch p m)
    (if (memq p passwords)
        (cond ((eq? m 'withdraw) withdraw)
              ((eq? m 'deposit) deposit)
              ((eq? m 'joint-password) joint-password)
              (else "Unknow request -- MAKE-ACCOUNT"))
        (lambda x "Incorrect password")))
  dispatch)

(define (make-joint acc password new-password)
  ((acc password 'joint-password) new-password)
  acc)
(define peter-acc (make-account 100 'open-sesame))
(define paul-acc (make-joint peter-acc 'open-sesame 'rosebud))
((paul-acc 'rosebud 'deposit) 40) ; 140
((peter-acc 'open-sesame 'withdraw) 0) ;140