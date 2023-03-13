/**
 * @name Empty scope
 * @kind problem
 * @problem.severity warning
 * @id python/example/empty-scope
 */

import python

predicate isPythonFile(File f) { f.getExtension() = "py" }

predicate isWithinScope(File f) { f.getAbsolutePath().matches("%target-repo%") }

from File f
where isPythonFile(f) and isWithinScope(f)
select f.getRelativePath() as path

