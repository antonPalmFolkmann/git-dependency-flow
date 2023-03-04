/**
 * @name Empty scope
 * @kind problem
 * @problem.severity warning
 * @id python/example/empty-scope
 */

import python

predicate isPythonFile(File f) {
  f.getExtension() = "py" and f.getAbsolutePath().matches("%FlowMethod%")
}

class ImportedFile extends File {
  string fullPath() { result = super.getAbsolutePath() }

  string shortPath() { result = super.getRelativePath() }

  ImportedFile() { isPythonFile(this) }
}

class ImportedModule extends Import {
  string getModules() {
    if this.isFromImport() 
      then result = this.getAName().getValue().(ImportMember).getImportedModuleName()
      else result = this.getAName().getValue().(ImportExpr).bottomModuleName()
  }

  ImportedModule() { exists(this) }
}


from ImportedFile f, ImportedModule im
where
  im.getEnclosingModule().getFile().toString() = f.fullPath() 
select f.shortPath() as path, im.getModules() as modulePath order by path




  /* 
  // Ignore the following code. Used to experiment and finding the solution.


  string getImportedModuleName() {
    exists(string bottomName | bottomName = this.bottomModuleName() |
      if this.isTop() then result = this.topModuleName() else result = bottomName
    )
  }

  from ImportedFile f, ImportExpr i, ImportMember im
where
  im.getEnclosingModule().getFile().toString() = f.fullPath() and
  i.getEnclosingModule().getFile().toString() = f.fullPath()
select f.shortPath() as path, im.getImportedModuleName() as modulename, i.topModuleName() as topname
 */
