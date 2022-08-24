urlList=(
    "https://adaway.org/hosts.txt" 
    "https://v.firebog.net/hosts/AdguardDNS.txt" 
    "https://v.firebog.net/hosts/Admiral.txt" 
    "https://raw.githubusercontent.com/anudeepND/blacklist/master/adservers.txt" 
    "https://s3.amazonaws.com/lists.disconnect.me/simple_ad.txt" 
    "https://v.firebog.net/hosts/Easylist.txt" 
    "https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext" 
    "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/UncheckyAds/hosts" 
    "https://raw.githubusercontent.com/bigdargon/hostsVN/master/hosts" 
)

for url in ${urlList[@]}; do
    filename=$(basename "$url")
    wget -o - "$url"

    for tempFile in $filename
    do
        sed 's/^#.*//g' $tempFile > "${tempFile}2"
        sed 's/127.0.0.1  localhost//g' "${tempFile}2" > "${tempFile}3"
        sed 's/::1  localhost//g' "${tempFile}3" > "${tempFile}4"
        sed '/^$/d' "${tempFile}4" > "${tempFile}5"
        sed 's/^127.0.0.1 //g' "${tempFile}5" > "${tempFile}6"
        sed 's/$/,/g' "${tempFile}6" > "${tempFile}.csv"
        split -l 1000 -d --additional-suffix=-.csv "${tempFile}.csv" ${tempFile}-
    done
done

mkdir -p result
mv *-*-.csv result