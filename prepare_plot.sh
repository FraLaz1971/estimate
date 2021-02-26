#!/usr/bin/env bash
m=1
cmd="plot '-' w l title 'n^{-1/$m}' ls $m lw 2"
MAXD=9
MAXP=100
TEMPFILE=temp.gp
DATAFILE=temp.dat
echo "set term qt persist" > "$TEMPFILE"
echo "set xrange [0:$MAXP]"  >> "$TEMPFILE"
echo "set yrange [0:1]"  >> "$TEMPFILE"
echo "set xlabel 'points (n)'"  >> "$TEMPFILE"
echo "set ylabel 'dimensions (m)"  >> "$TEMPFILE"
echo "set title  'n^{-1/m}, m \in [1,$(( $MAXD-1 ))]"  >> "$TEMPFILE"
for m in $(eval echo {2..$MAXD});
do
	echo "set style line $m lt $m lw 2" >> "$TEMPFILE"
	cmd=$cmd",'-' w l title 'n^{-1/$m}' ls $m"
	printf "#n^(-1/$m) m=$m\n"
	for n in $(eval echo {1..$MAXP})
	do
		printf "$n %f\n" $(calc -d "$n^(-1/$m)")
	done
	printf "e\n"
done >"$DATAFILE"
echo $cmd >>"$TEMPFILE"
cat "$TEMPFILE" "$DATAFILE" > estimate.gp
