import os, osproc, webgui

let app = newWebView(currentHtmlPath(), title = "Nimble GUI", height = 666)

template justDoIt(button, command: string) =
  app.js("document.querySelector('#" & button & "').disabled = true;" &
    app.addText("#output", execProcess("nimble --noColor " & command) & "\n") &
    "document.querySelector('#output').scrollTop = document.querySelector('#output').scrollHeight;" &
    "document.querySelector('#" & button & "').disabled = false;")

app.bindProcs("api"):
  proc nimbleRefresh()            = justDoIt "nimbleRefresh", "-y refresh"
  proc nimbleListInstalled()      = justDoIt "nimbleListInstalled", "list -i"
  proc nimbleListAll()            = justDoIt "nimbleListAll", "list"
  proc nimbleVersion()            = justDoIt "nimbleVersion", "--version"
  proc nimbleDump(s: string)      = justDoIt "nimbleDump", "dump " & s
  proc nimbleSearch(s: string)    = justDoIt "nimbleSearch", "search --ver " & s
  proc nimblePath(s: string)      = justDoIt "nimblePath", "path " & s
  proc nimbleInstall(s: string)   = justDoIt "nimbleInstall", "install " & s
  proc nimbleRemove(s: string)    = justDoIt "nimbleRemove", "-y remove " & s
  proc nimbleReinstall(s: string) = justDoIt "nimbleReinstall", "-y remove " & s & "; nimble --noColor install " & s

app.run()
app.exit()
