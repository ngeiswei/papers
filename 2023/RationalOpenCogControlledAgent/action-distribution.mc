/* Maxima file. Under emacs type

M-x maxima

then

M-x maxima-send-buffer

to produce the graph for transparent background, save the image in
png, open gimp, add an alpha channel in the layer toolbar, and replace
color by transparent in "Colors->Color to Alpha..." menu. */

/* For Beta distributions */
load(distrib);

/* Count<->confidence SimpleTruthValue conversion. */
k:100.0;
count_to_confidence(cnt):=cnt/(cnt+k);
confidence_to_count(cnf):=(cnf*k)/(1-cnf);

/* Given a SimpleTruthValue strength and confidence, compute the
corresponding alpha and beta parameters of the corresponding beta
distribution. */
prior_a:0.5;
prior_b:0.5;
beta_a(strength, confidence):=prior_a+confidence_to_count(confidence)*strength;
beta_b(strength, confidence):=prior_b+confidence_to_count(confidence)*(1.0-strength);

/* A1 PDF */
A1_s:0.6;
A1_c:0.9;
A1_a:beta_a(A1_s, A1_c);
A1_b:beta_b(A1_s, A1_c);
A₁(x):=pdf_beta(x, A1_a, A1_b);

/* A2 PDF */
A2_s:0.7;
A2_c:0.1;
A2_a:beta_a(A2_s, A2_c);
A2_b:beta_b(A2_s, A2_c);
A₂(x):=pdf_beta(x, A2_a, A2_b);

/* Plot */
plot2d([A₁, A₂],
       [Probability, 0, 1],
       [y, 0, 25],
       [ylabel, "Probability Density"],
       [title, "Second order probabilities of success of actions A₁ and A₂"]);
