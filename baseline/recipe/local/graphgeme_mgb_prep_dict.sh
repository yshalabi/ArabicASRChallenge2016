#!/bin/bash

# Copyright 2014 QCRI (author: Ahmed Ali)
# Apache 2.0


# run this from ../
dir=data/local/dict
mkdir -p $dir
lexdir=$1

# (1) Get QCRI dictionary
#wget http://alt.qcri.org//resources/speech/dictionary/ar-ar_lexicon_2014-03-17.txt.bz2  || exit 1;
#bzcat ar-ar_lexicon_2014-03-17.txt.bz2 | sed '1,3d' | awk '{print $1}' | sed -e 's:a::g' -e 's:{:}:g' > tmp_$$
#cat $MGBAR/all.train | cut -d ' ' -f5- | tr -s " " "\n" >> tmp_$$
#sort -u tmp_$$ > tmp$$
#cat tmp$$ | sed 's:\(\):\1 :g' | sed -e 's:  : :g' -e 's:  : :g' -e 's:  : :g' -e 's:  : :g' -e  's:\*:V:g' > tmp_$$
#paste -d ' ' tmp$$ tmp_$$ | sed -e 's:  : :g' -e 's:  : :g' -e 's:  : :g' -e 's:  : :g'  | grep -v "^ $" | grep -v [0-9] > $dir/lexicon.txt
#rm -fr ar-ar_lexicon_2014-03-17.txt.bz2 tmp_$$ tmp$$

#(2) Dictionary preparation:

# silence phones, one per line.
echo SIL > $dir/silence_phones.txt
echo SIL > $dir/optional_silence.txt

# nonsilence phones; on each line is a list of phones that correspond
# really to the same base phone.
cp $lexdir/crpx.dct $dir
mv $dir/crpx.dct $dir/lexicon.txt
cat $dir/lexicon.txt | cut -d ' ' -f2- | tr -s ' ' '\n' |\
sort -u >  $dir/nonsilence_phones.txt || exit 1;
#cat $lexdir/crpx_phonelist.txt | egrep -v "SIL" > $dir/nonsilence_phones.txt
# cut -d ' ' -f2- | tr -s ' ' '\n' |\
#sort -u >  $dir/nonsilence_phones.txt || exit 1;


sed -i '1i<UNK> SIL' $dir/lexicon.txt
 
echo Dictionary preparation succeeded
