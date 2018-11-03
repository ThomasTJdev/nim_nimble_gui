import ui, osproc, os, ospaths, uibuilderpkg/codegen

const path = joinPath(staticExec("pwd"), "nimbleguipkg/nimblegui.glade")

init()

build(path)

mainInfoWin.hide()
mainInputWin.hide()

var choice = ""
var entryMainValue = ""

btnRefresh.onclick = proc() =
  choice = "refresh"
  mainWin.msgBox("Nimble", execProcess("nimble refresh"))

btnInstalled.onclick = proc() =
  choice = "list -i"
  mainInfoWin.show()
  infoText.text = choice
  infoText.text = execProcess("nimble list -i")

btnAllPackages.onclick = proc() =
  choice = "list"
  mainInfoWin.show()
  infoText.text = choice
  infoText.text = execProcess("nimble list")

btnNimbleVersion.onclick = proc() =
  choice = "version"
  mainWin.msgBox("Nimble version", "Nimble:\n" & execProcess("nimble --version") & "\nNim:\n" & execProcess("nim --version") )

#
# Use btnInputGo.onclick
#
btnInstall.onclick = proc() =
  choice = "install"
  mainInputWin.show()

btnRemove.onclick = proc() =
  choice = "remove"
  mainInputWin.show()

btnSearch.onclick = proc() =
  choice = "search"
  mainInputWin.show()

btnInfo.onclick = proc() =
  choice = "info"
  mainInputWin.show()

btnInputGo.onclick = proc() =
  entryMainValue = entryMain.text
  infoText.text = choice
  mainInputWin.hide()

  case choice

  of "info":
    mainInfoWin.hide()
    let info = execProcess("nimble search " & entryMain.text & " --ver")
    let path = execProcess("cd;nimble path " & entryMain.text)
    mainWin.msgBox("Package info", "Package info:\n" & info & "\nInstall path:\n" & path)

  of "install", "remove":
    mainInfoWin.show()
    let output = execProcess("nimble " & choice & " " & entryMain.text & " -y")
    infoText.text = output

  else:
    mainInfoWin.show()
    let output = execProcess("nimble " & choice & " " & entryMain.text)
    infoText.text = output


mainLoop()
