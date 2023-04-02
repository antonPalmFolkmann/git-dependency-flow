/**
 * @name Empty scope
 * @kind problem
 * @problem.severity warning
 * @id python/example/empty-scope
 */

import python

from Class c, string classModule, string fileLocation
where c.getLocation().getFile().getAbsolutePath().matches("%target-repo%")
    and classModule = c.getEnclosingModule().getName() + "." + c.getName()
    and fileLocation = c.getLocation().getFile().getRelativePath()
select classModule, fileLocation order by classModule