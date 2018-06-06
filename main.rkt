#lang racket/kernel

(#%provide count)

(define-values (m) (make-hasheq))

(define-values (count)
  (lambda (v)
    (hash-set! m 'n (add1
                     (hash-ref m 'n
                               (lambda ()
                                 (plumber-add-flush!
                                  (current-plumber)
                                  (lambda _
                                    (log-message (current-logger)
                                                 'info
                                                 (format "count: ~s ~s" 'n
                                                         (hash-ref m 'n 0))
                                                 (current-continuation-marks))))
                                 0))))))
                                   


                

