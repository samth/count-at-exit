#lang racket/kernel

(#%provide count)

(define-values (counts) (make-hasheq))
(define-values (flush?) #f)

(define-values (count)
  (lambda (v)
    (if flush?
        (void)
        (plumber-add-flush!
         (current-plumber)
         (lambda _
           (hash-for-each
            counts
            (lambda (k v)
              (log-message (current-logger)
                           'info
                           (format "count: ~s ~s" k v)
                           (current-continuation-marks)))))))
    (set! flush? #t)
    (hash-set! counts v (add1 (hash-ref counts v 0)))))
                                   


                

