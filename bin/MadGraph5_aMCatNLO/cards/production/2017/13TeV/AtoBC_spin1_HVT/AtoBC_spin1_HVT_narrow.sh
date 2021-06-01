#!/bin/bash

# masses=(600 800 1000 1200 1400 1600 1800 2000 2100 2200 2500 3000 3500 4000 4500 5000 5500 6000 7000)
# masses_bc=(40 60 80 100 120 140 160 180 200 250 300 350 400 450 500 600)
masses=(1200 2000 3000 5000)
masses_bc=(60 80 200 400)

sample=AtoBC_spin1_HVT_narrow_M
templates=template_cards
postfix=(_run_card.dat _customizecards.dat _proc_card.dat _extramodels.dat)

echo ${masses[*]}

for mass in ${masses[*]}; do
    for massB in ${masses_bc[*]}; do
      for massC in ${masses_bc[*]}; do
        if [ $(($mass-$massB-$massC)) -lt 0 ]; then
          echo "Skip for M(A) = ${mass} GeV M(B) = ${massB} M(C) = ${massC}"
        else
          echo "generating cards for M(A) = ${mass} GeV M(B) = ${massB} M(C) = ${massC}"
          mkdir "${sample}${mass}_B${massB}_C${massC}"
          for i in {0..3}; do
            sed "s/<MASS_A>/${mass}/g; s/<MASS_B>/${massB}/g; s/<MASS_C>/${massC}/g;" ${templates}/${sample}${postfix[$i]} > ${sample}${mass}_B${massB}_C${massC}/${sample}${mass}_B${massB}_C${massC}${postfix[$i]}
          done
        fi
      done
    done
done