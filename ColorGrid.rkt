#lang racket/gui


(define frame(new frame%
                  [label "Color grid"]
                  [width 350]
                  [height 445]))

(define(board-setup dc)
  (send dc clear))

(define board(new canvas%
                   [parent frame]
                   [paint-callback
                    (lambda (canvas dc)
                      (board-setup dc))]))



(define(new-grid)
  #(#(222 43 133 64)
    #(44 55 66 77)
    #(118 99 88 77)
    #(6 78 244 33)
    #(45 123 234 90)))



(define(board-paint dc)
  (send dc clear)
  
  (let*([grid(new-grid)]
        [grid-size(vector-length grid)]
        [cell-size(/ 400 grid-size)])
    (for*([row grid-size]
          [col grid-size])
      (let*([x (* cell-size row)]
           [y (* cell-size col)]
           [block (vector-ref(vector-ref grid col)row)]
           [fill-col (make-color block 1 block )])
        
        (send dc set-pen fill-col 1 'solid)
        (send dc set-brush fill-col 'solid)
        (send dc draw-rectangle (add1 x) (add1 y) (sub1 cell-size) (sub1 cell-size))))))
    

(define timer (new timer%
                   [notify-callback (λ () (timer-sent))]
                   [interval #f]
                   [just-once? #t]))

(define (timer-sent)
  (board-paint (send board get-dc)))


(define (run)
  (send frame show #t)
  (send timer start 1000))

  