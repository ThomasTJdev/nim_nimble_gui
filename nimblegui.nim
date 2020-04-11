import os, osproc, webgui

let app = newWebView(currentHtmlPath(), title = "Nimble GUI", height = 666)

template justDoIt(command: string) =
  app.js(app.addText("#output", "\n" & execProcess("nimble --noColor " & command)))

app.bindProcs("api"):
  proc nimbleRefresh()            = justDoIt "-y refresh"
  proc nimbleListInstalled()      = justDoIt "list -i"
  proc nimbleListAll()            = justDoIt "list"
  proc nimbleVersion()            = justDoIt "--version"
  proc nimbleDump(s: string)      = justDoIt "dump " & s
  proc nimbleSearch(s: string)    = justDoIt "search --ver " & s
  proc nimblePath(s: string)      = justDoIt "path " & s
  proc nimbleInstall(s: string)   = justDoIt "install " & s
  proc nimbleRemove(s: string)    = justDoIt "-y remove " & s
  proc nimbleReinstall(s: string) = justDoIt "-y remove " & s & "; nimble --noColor install " & s

app.run()
app.exit()
