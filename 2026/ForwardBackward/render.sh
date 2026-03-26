for j in {1..3}; do
    bibtex ForwardBackward
    lualatex -shell-escape ForwardBackward.tex
done
