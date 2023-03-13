/**
 * @name Empty scope
 * @kind problem
 * @problem.severity warning
 * @id python/example/empty-scope
 */

 import python

 predicate isPythonFile(File f) {
   f.getExtension() = "py"
 }
 
 predicate isWithinScope(File f) {
   f.getAbsolutePath().matches("%FlowMethod%")
 }
 
 class ImportedFile extends File {
   string fullPath() { result = super.getAbsolutePath() }
 
   string shortPath() { result = super.getRelativePath() }
 
   ImportedFile() { isPythonFile(this) and isWithinScope(this) }
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