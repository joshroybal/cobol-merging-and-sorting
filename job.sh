#!/bin/sh
set -v

time ./csv2flat ~/dat/csv/us-500.csv
mv flat.txt us-500.txt
time ./csv2flat ~/dat/csv/small.csv
mv flat.txt small.txt
time ./csv2flat ~/dat/csv/medium.csv
mv flat.txt medium.txt
time ./csv2flat ~/dat/csv/large.csv
mv flat.txt large.txt
time ./csv2flat ~/dat/csv/great.csv
mv flat.txt great.txt

time ./sortflat us-500.txt
mv sorted.txt us-500.txt
time ./sortflat small.txt
mv sorted.txt small.txt
time ./sortflat medium.txt
mv sorted.txt medium.txt
time ./sortflat large.txt
mv sorted.txt large.txt
time ./sortflat great.txt
mv sorted.txt great.txt

time ./mergeflat us-500.txt small.txt
rm us-500.txt small.txt
mv merged.txt scratch.txt
time ./mergeflat medium.txt scratch.txt
rm medium.txt
mv merged.txt scratch.txt
time ./mergeflat large.txt scratch.txt
rm large.txt
mv merged.txt scratch.txt
time ./mergeflat great.txt scratch.txt
rm scratch.txt great.txt
