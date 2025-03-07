for j in {1..3}; do
    bibtex ProbEstThrmInfCtrl
    lualatex -shell-escape ProbEstThrmInfCtrl.tex
done
