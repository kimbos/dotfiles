#/bin/bash
declare -A Routers
Routers=(["10.0.102.10"]="ro-sisk" ["10.0.102.20"]="ro-butj" ["10.0.102.30"]="ro-kalv" ["10.0.102.50"]="ro-sitj" ["10.0.102.60"]="ro-sotj" ["10.0.102.70"]="ro-snur" ["10.0.102.90"]="ro-gsk" ["10.0.102.100"]="ro-lysg" ["10.0.102.110"]="ro-sosk" ["10.0.102.120"]="ro-stbs" ["10.0.102.130"]="ro-prest" ["10.0.102.170"]="ro-rens") 
Routers=(["10.0.102.10"]="ro-sisk")
 
TestFile="/tmp/testfile.dat"
#---------------------------------

echo "Writing test-file..."
dd if=/dev/urandom of=$TestFile  bs=1024  count=20000

Result="<html><head><style>table { font-family:'Trebuchet MS', Arial, Helvetica, sans-serif; font-size:12px; width:100%; border-collapse:collapse; }	td, th { border:1px solid black; padding:5px; } th { background-color:Gray; color:White; }</style></head><body>"
Result+="<table border='1' cellpadding='0' cellspacing='0'><tr><th>Router</th><th>Download (Mb/s)</th><th>Upload (Mb/s)</th></tr>"

for i in "${!Routers[@]}"
do
   echo "${Routers["$i"]} ($i)"
   Result+="<tr><td>${Routers["$i"]} ($i)</td>"
   down_speed=$(scp -v $TestFile "$i:$TestFile" 2>&1 | \
     grep "Bytes per second" | \
     sed "s/^[^0-9]*\([0-9.]*\)[^0-9]*\([0-9.]*\).*$/\1/g")

   down_speed=$(echo "scale=1; ((($down_speed*0.0009765625*100.0+0.5)/1*0.00001)*8)/1" | bc)
   echo "  Down: $down_speed Mb/s"
   Result+="<td>$down_speed</td>"

   up_speed=$(scp -v "$i:$TestFile" $TestFile 2>&1 | \
     grep "Bytes per second" | \
     sed "s/^[^0-9]*\([0-9.]*\)[^0-9]*\([0-9.]*\).*$/\2/g")

   up_speed=$(echo "scale=1; ((($up_speed*0.0009765625*100.0+0.5)/1*0.00001)*8)/1" | bc)
   echo "  Up:   $up_speed Mb/s"
   Result+="<td>$up_speed</td>"
done

Result+="</tr></table></body></html>"
echo -e $Result | mail -s "Speed" -a "Content-Type: text/html" "kb@mgk.no"
