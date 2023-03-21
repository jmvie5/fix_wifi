## Fix Wifi with bash

Bash script that restarts wifi if needed and checks internet connection afterwards.

I had issues with my laptop not connecting properly to wifi after being on standby, I wrote this small script to automate everyting and add some outputs, but if you have the same problem you can also just run :
```bash
nmcli r wifi off && sleep 3 && nmcli r wifi on
```

Only tested on my personnal laptop with Ubuntu 22.04.2 LTS.

