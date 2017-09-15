#! /usr/local/bin/zsh


# browser history

make_history() {
    IN=$1
    OUT=$2
    cp ~/Library/Application\ Support/Google/Chrome/Default/History $IN
    sqlite3 -csv $IN >$OUT <<\END
    select datetime(last_visit_time/1000000-11644473600,'unixepoch') as 'date',url,title from  urls order by last_visit_time desc;
END
}

prepare_chrome_hist() {
    echo "prep chrome hist"
    IN="$HOME/temp/History"
    OUT="$HOME/temp/chrome_hist.csv"
    make_history $IN $OUT
    LOCAL_SOURCES+="$OUT"
}



# grep tool

G=ag 

show_results() {
    echo "\n"
    echo "[START:$f]----------------------------------------------------------------------"
    "$G" $1 $f
    echo "[END:$f]------------------------------------------------------------------------"
}

LOCAL_SOURCES=($HOME/Dropbox/writing \
                $HOME/Dropbox/todo \
                $HOME/Dropbox/jrnl)



### Main

prepare_chrome_hist

for f in $LOCAL_SOURCES; do
    show_results $1 $f
done 
