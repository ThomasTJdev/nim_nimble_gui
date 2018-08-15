import ui, uibuilder, osproc, os

var builder = newBuilder()
builder.load(getAppDir() & "/nimbleguipkg/nimblegui.glade")

var winMain       = (Window)builder.getWidgetById("mainWin")
var winInfo       = (Window)builder.getWidgetById("mainInfoWin")
var winInput      = (Window)builder.getWidgetById("mainInputWin")
var btnInfo       = (Button)builder.getWidgetById("btnInfo")
var btnInputGo    = (Button)builder.getWidgetById("btnInputGo")
var btnInstall    = (Button)builder.getWidgetById("btnInstall")
var btnInstalled  = (Button)builder.getWidgetById("btnInstalled")
var btnAllPackages  = (Button)builder.getWidgetById("btnAllPackages")
var btnNimbleVersion = (Button)builder.getWidgetById("btnNimbleVersion")
var btnRefresh    = (Button)builder.getWidgetById("btnRefresh")
var btnRemove     = (Button)builder.getWidgetById("btnRemove")
var btnSearch     = (Button)builder.getWidgetById("btnSearch")
var entryMain     = (Entry)builder.getWidgetById("entryMain")
var infoText      = (MultilineEntry)builder.getWidgetById("infoText")

winInfo.hide()
winInput.hide()

var choice = ""
var entryMainValue = ""


btnRefresh.onclick = proc() =
  choice = "refresh"
  winMain.msgBox("Nimble", execProcess("nimble refresh"))

btnInstalled.onclick = proc() =
  choice = "list -i"
  winInfo.show()
  infoText.text = choice
  infoText.text = execProcess("nimble list -i")

btnAllPackages.onclick = proc() =
  choice = "list"
  winInfo.show()
  infoText.text = choice
  infoText.text = execProcess("nimble list")

btnNimbleVersion.onclick = proc() =
  choice = "version"
  winMain.msgBox("Nimble version", "Nimble:\n" & execProcess("nimble --version") & "\nNim:\n" & execProcess("nim --version") )

#
# Use btnInputGo.onclick
#
btnInstall.onclick = proc() =
  choice = "install"
  winInput.show()

btnRemove.onclick = proc() =
  choice = "remove"
  winInput.show()

btnSearch.onclick = proc() =
  choice = "search"
  winInput.show()

btnInfo.onclick = proc() =
  choice = "info"
  winInput.show()

btnInputGo.onclick = proc() =
  entryMainValue = entryMain.text
  infoText.text = choice
  winInput.hide()

  case choice

  of "info":
    winInfo.hide()
    let info = execProcess("nimble search " & entryMain.text & " --ver")
    let path = execProcess("cd;nimble path " & entryMain.text)
    winMain.msgBox("Package info", "Package info:\n" & info & "\nInstall path:\n" & path)

  of "install", "remove":
    winInfo.show()
    let output = execProcess("nimble " & choice & " " & entryMain.text & " -y")
    infoText.text = output

  else:
    winInfo.show()
    let output = execProcess("nimble " & choice & " " & entryMain.text)
    infoText.text = output


builder.run()