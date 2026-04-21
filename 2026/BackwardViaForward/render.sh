for j in {1..3}; do
    bibtex BackwardViaForward
    lualatex -shell-escape BackwardViaForward.tex
done
