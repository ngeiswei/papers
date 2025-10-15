set title "Double a natural (PeTTa vs MORK)"
unset multiplot
set style data lines
set term png
set xlabel "Depth"
set ylabel "Time (ms)"
set autoscale y
set output "double_fc.png"
set datafile separator ","
set datafile commentschars "d"
plot "double_fc.csv" using 1:2 t "PeTTa" with lines, \
     "double_fc.csv" using 1:3 t "MORK" with lines
