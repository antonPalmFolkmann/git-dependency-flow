/**
 * @name Empty scope
 * @kind problem
 * @problem.severity warning
 * @id python/example/empty-scope
 */

import python

/* from Import i, File f
where 
    f.getExtension() = "py" and
    exists(i) 
select  i.getAnImportedModuleName(), i.getEnclosingModule(), i.getEnclosingModule().getFile()
 */

predicate isPythonFile(File f) {
    f.getExtension() = "py"
}

predicate importExists(Import i) {
    exists(i)
}

class ImportedFile extends File{

    string getLocation() {result = super.getAbsolutePath()}

    ImportedFile() {isPythonFile(this)}
}

from ImportedFile f, Import i
where importExists(i)
    and f.getLocation() = i.getEnclosingModule().getFile().toString()
select i.getEnclosingModule().getFile(), i.getAnImportedModuleName(), i.getEnclosingModule()