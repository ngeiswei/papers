(= (fromNumber $n) (if (<= $n 0) Z (S (fromNumber (- $n 1)))))
(= (double Z) Z)
(= (double (S $k)) (S (S (double $k))))
!(double (fromNumber 5000))
