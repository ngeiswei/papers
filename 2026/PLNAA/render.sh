for j in {1..3}; do
    bibtex PLNAA
    lualatex -shell-escape PLNAA.tex
done
