/**
 * @name Empty scope
 * @kind problem
 * @problem.severity warning
 * @id python/example/empty-scope
 */

 import python

 from Module m, string fileLocation, string moduleName
 where m.getFile().getAbsolutePath().matches("%target-repo%")
     and fileLocation = m.getFile().getRelativePath()
     and moduleName = m.getName()
 select moduleName, fileLocation order by moduleName