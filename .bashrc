export LANG=en_US.UTF-8
export PATH=/home/buggy/.local/bin:$PATH
export PATH=/home/buggy/.gem/ruby/2.7.0/bin:$PATH
alias reddit='ttrv --enable-media'

function pdfpextr()
{
    # this function uses 3 arguments:
    #     $1 is the first page of the range to extract
    #     $2 is the last page of the range to extract
    #     $3 is the input file
    #     output file will be named "inputfile_pXX-pYY.pdf"
    gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER \
	-dFirstPage=${1} \
	-dLastPage=${2} \
	-sOutputFile=${3%.pdf}_p${1}-p${2}.pdf \
	${3}
    }
