LATEX = latex
RM = rm -f

.PHONY: clean all plot.tex plot
all: estimate_latex.gp estimate.eps estimate.tex

estimate.gp: prepare_plot.sh
	bash prepare_plot.sh

estimate_latex.gp: prepare_plot_latex.sh
	bash prepare_plot_latex.sh

estimate.eps: estimate_latex.gp
	gnuplot estimate_latex.gp

estimate.tex: estimate_latex.gp estimate.eps

plot: estimate.gp
	gnuplot estimate.gp

plot.tex: estimate.tex

plot.dvi: plot.tex
	$(LATEX) plot.tex

plot.ps: plot.dvi
	dvips plot.dvi

plot.pdf: plot.ps
	ps2pdf plot.ps

clean:
	$(RM) plot.aux plot.dvi plot.log plot.pdf plot.ps \
		estimate.gp estimate.tex estimate.eps \
		estimate_latex.gp temp.gp temp.dat
