
#!/bin/bash
rm -f tests.out 2>&1 >/dev/null
echo -e "\nRunning make clean"
make -f makefile clean
echo -e "\nRunning make prog2"
make
rc=$?
total=0
if [[ $rc == 0 ]]; then
  tests=( "abs 12"
          "abs -25"
          "mult7div8 9"
          "mult7div8 25"
          "mult7div8 -9"
          "mult7div8 -64"
          "area 0 0 0"
          "area 2 2 2"
          "area 3 3 3"
          "area 4 4 4"
          "max 11 77 22 44"
          "max -11 -22 -33 -44"
          "max 10 20 30 40"
          "max -30 -20 -10 0"
          "sort 1 2 3 4 5 6 7 8"
          "sort 8 7 6 5 4 3 2 1"
          "sort 8 2 4 7 5 1 3 6"
          "sort -5 5 -4 4 3 -3 2 -2"
          "reverse bla bli blo blu bly"
          "reverse 100 200 300 400 500"
          "reverse Monday Tuesday Wednesday Thursday Friday"
          "reverse 500 400 300 200 100"
          "sum apple 3 kiwi 5 lemon 2 pear 4"
          "sum Emma 400 Helen 100 Paul 400 Lily 100"
          "sum Monday 65 Tuesday 71 Wednesday 78 Thursday 68"
          "sum Jan -10 Feb 10 Mar -5 Apr 5"
          "product 3.5 4.5 2.5 2.0 2.0 2.0"
          "product 3.5 4.5 2.5 0.5 0.5 0.5"
          "product 0.5 2.0 0.5 2.0 0.5 2.0"
          "product 4.0 6.0 8.0 0.5 2.0 0.5"
        )

  for test in "${tests[@]}"; do
    total=$((total + 1))
    echo -e "\nTest $total with args: $test"
    ./prog2 $test | tee -a tests.out
  done
paste -d '|' tests.out tests.reference | grep -Po '^(.*)\|+\K\1$' > out
count=0
input="./out"
while IFS= read -r line
do
  count=$((count + 1))
done < "$input"

if [[ $count == 30 ]]; then
   echo -e "\nAll tests passed"
   echo -e "Score: 90/90\n"
   exit 0
else
   echo -e "\n$count out of 30 passed"
   count=$((count * 3))
   echo -e "Score: $count /90\n"
   exit 1
fi

fi
