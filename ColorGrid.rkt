#lang racket/gui
(define frame(new frame%
                  [label "Test GUI"]
                  [width 400]
                  [height 400]))
(define(new-grid)
  #(#(111 222 33 44)
    #(44 55 66 77)
    #(88 99 88 77)
    #(66 55 44 33)))


(define(canvas-paint dc)
  (send dc clear)

  (let*([grid(new-grid)]
        [grid-size(vector-length grid)]
        [cell-size(/ 400 grid-size)])
    (for*([row grid-size]
          [col grid-size])
      (let([x (* cell-size row)]
           [y (* cell-size col)]
           [fill-col (make-color 2 2 (vector-ref(vector-ref grid col)row))])
        (send dc set-pen fill-col 1 'solid)
        (send dc set-brush fill-col 'solid)
        (send dc draw-rectangle (add1 x) (add1 y) (sub1 cell-size) (sub1 cell-size))
        )
      )
    )
  )
