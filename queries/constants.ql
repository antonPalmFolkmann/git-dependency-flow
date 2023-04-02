/**
 * @name Empty scope
 * @kind problem
 * @problem.severity warning
 * @id python/example/empty-scope
 */

import python

from AssignStmt astmt, string fileLocation, string constantModule, string expr
where astmt.getASubExpression().getEnclosingModule().getFile().getAbsolutePath().matches("%target-repo%") 
    and fileLocation = astmt.getASubExpression().getEnclosingModule().getFile().getRelativePath()
    and expr = astmt.getTargets().getAnItem().toString()
    and constantModule = astmt.getASubExpression().getEnclosingModule().getName() + "." + expr
select constantModule, fileLocation order by fileLocation