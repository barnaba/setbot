cd /home/barnex/kod/setbot
curl -d "viewType=0&itemType=S&itemTypeInv=S&itemNo=&downloadType=T" http://www.bricklink.com/catalogDownload.asp\?a\=a | sed '1,3d' > sets.tsv
sqlite3 sets.sqlite < load.sql
