for j in {1..3}; do
    bibtex MetaReasoningMeTTa
    lualatex -shell-escape MetaReasoningMeTTa.tex
done
