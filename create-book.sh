fileName=index
output=$fileName
echo "*** Producing HTML ***"
asciidoctor $fileName.adoc -o $output.html
echo "*** Producing DOCBOOK ***"
asciidoctor -n -b docbook -d book $fileName.adoc -o krltemp.xml 
sed -e s/language=\"groovy\"/language=\"java\"/ krltemp.xml > $fileName.xml
rm krltemp.xml
echo "*** Producing EPUB ***"
pandoc -f docbook -t epub $fileName.xml -o $output.epub
echo "*** Producing MOBI ***"
ebook-convert $output.epub $output.mobi
echo "*** Producing PDF ***"
asciidoctor-pdf $fileName.adoc -o $output.pdf