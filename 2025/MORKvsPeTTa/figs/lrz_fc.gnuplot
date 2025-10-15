set title "Forward binary search space (PeTTa vs MORK)"
unset multiplot
set style data lines
set term png
set xlabel "Depth"
set ylabel "Time (ms)"
set autoscale y
set output "lrz_fc.png"
set datafile separator ","
set datafile commentschars "d"
plot "lrz_fc.csv" using 1:2 t "PeTTa" with lines, \
     "lrz_fc.csv" using 1:3 t "MORK" with lines
