path=$1

if [ ! -f $1 ]; then
  echo "Error! No such file!"
  exit 1
fi

pattern="^[^-]+ - [0-9]+ - [0-9]+-[0-9]+-[0-9]+ [0-9]+:[0-9]+ - [a-zA-Z0-9]{1,64} - sha256"
while IFS= read -r line
do
  if [[ ! "$line" =~ $pattern ]]; then
    echo "This line is not correct:"
    echo $line
    echo "Error! File is not correct!"
    exit 1
  fi
done < $1 
number_of_lines=$(wc -l $path | awk '{print $1}')

arr=()
brr=()
while IFS= read -r line
do
  #echo $line
  IFS=' - '
  read -a strarr <<< $line
 #echo ${strarr[0]}
  arr+=( ${strarr[0]} )
  brr+=(${strarr[@]})
done < $path

#echo ${brr[@]}
uniq_arr=($(printf "%s\n" "${arr[@]}" | sort -u))


#echo "${uniq_arr[@]}"

echo $number_of_lines "${#uniq_arr[@]}" $(cut -d "-" -f '1,4' files.log | uniq | wc -l)

#for value in ${brr[@]}
#do
#  echo "$value "
#done
#printf "\n"

#echo ${brr[@]}
