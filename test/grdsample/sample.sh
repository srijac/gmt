#!/bin/sh
#	$Id: sample.sh,v 1.1 2011-06-20 21:55:18 guru Exp $
# Testing grdsample

. ../functions.sh
header "Test grdsample for basic resampling"

ps=sample.ps
Rg=-20/20/-20/20
# Create  grid by evaluating a Kelvin-Bessel * sqrt(r) function
grdmath -R$Rg -I1 0 0 CDIST 0.1 MUL KEI 0 0 CDIST 0.1 MUL SQRT ADD DUP UPPER DIV 10 MUL = tmp.nc
makecpt -Crainbow -T-6/10/1 > t.cpt
# Draw all nodes as open circles
grdimage tmp.nc -JX4.5i -Ct.cpt -P -K -B10f5WSne -Xc -Y0.75i > $ps
psscale -D5i/4.75i/6i/0.15i -O -K -Ct.cpt -E+n >> $ps
# Resample to 0.2 spacing
grdsample tmp.nc -I0.2 -Gout.nc
grdimage out.nc -JX4.5i -Ct.cpt -O -K -B10f5WSne -Xc -Y5i >> $ps
psxy -R$Rp -J -O -T >> $ps
rm -f tmp.nc out.nc t.cpt

pscmp
