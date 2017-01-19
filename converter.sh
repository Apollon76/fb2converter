SCRIPTPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
temp=`mktemp -d`
echo "Downloading"
wget -E -H -k -K -p -c -q --no-directories --convert-links --restrict-file-names=nocontrol --directory-prefix=$temp -erobots=off "$1"
temp2=`mktemp -d`
wget --content-disposition -q --restrict-file-names=nocontrol --directory-prefix=$temp2 "$1"
filename=`ls $temp2 | sort -n | head -1`
filename=`basename $filename`
rm -rf $temp2
if [[ "$filename" != *.html ]]
then
    #mv "$temp/$filename" "$temp/$filename.html"
    filename="$filename.html"
fi
echo "Page filename: $filename"
page_title=`python3 $SCRIPTPATH/get_title.py $1`
echo "Conversion is started"
ebook-convert $temp/$filename "$page_title.fb2" 1> /dev/null
echo "Done"
rm -rf $temp
