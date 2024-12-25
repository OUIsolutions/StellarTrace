stellar = require("stellar")

watcher = stellar.create_root_watcher("debug.txt")
watcher.stream("teste")
watcher.stream("teste")
watcher.stream("teste")
watcher.stream("teste")
