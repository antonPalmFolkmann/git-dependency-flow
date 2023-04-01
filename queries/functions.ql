/**
 * @name Empty scope
 * @kind problem
 * @problem.severity warning
 * @id python/example/empty-scope
 */

import python

from Function fu, string functionModule, string fileLocation
where
  fu.getLocation().getFile().getAbsolutePath().matches("%target-repo%") and
  functionModule = fu.getEnclosingModule().getName() + "." + fu.getName() and
  fileLocation = fu.getLocation().getFile().getRelativePath()
select functionModule, fileLocation order by functionModule
