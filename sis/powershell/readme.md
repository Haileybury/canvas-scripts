#Diffing Vs Batch SIS Imports

##Warning: It is extremely important that you understand how diffing works before using diffing.

Diffing is essentially a differential import, which only imports the items that have changed sine the last import.  This greatly speeds up the import process.  

Batch imports upload everything that is in the CSV upload and can remove elements that are not in the CSV's.

This directory contains an example of using the sis_imports Canvas API to import a collection of Canvas formatted CSVs as a diff-based or batch-based import into Canvas.
