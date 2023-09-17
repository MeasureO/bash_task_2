if [ $# -eq 3 ]; then
  if [ -f "$1" ]; then
    sed -i.cache "s/$2/$3/g" "$1"
    rm "$1.cache"


    file_path="src/$1"
    file_size=$(wc -c $1 | awk '{print $1}')
    file_datetime=$(date +"%Y-%m-%d %H:%M")
    file_sha=$(shasum -a 256 $1| awk '{print $1}')
    new_line="$file_path - $file_size - $file_datetime - $file_sha - sha256"

    echo $new_line >> files.log
  else
    echo "Error! No such directory!"
  fi
else
  echo "Error! Wrong number of arguments!"
fi

#echo $#
#echo $file_path
#echo $file_size  
#echo $file_datetime
#echo $file_sha
#echo $new_line
