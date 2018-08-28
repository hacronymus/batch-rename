# batch-rename

Powershell script that renames files in a folder and subfolders using a CSV file.

-Script will ask for folder to work in when started.
-Script will ask for CSV file to reference.
	-CSV should have a 'NEW' and 'OLD' column
-Script does a find and replace of strings in the file.
-Script only matches beginning of string and will ignore differences at the end
e.g:
File_01_V01
File_01_V02

if the string in the 'OLD' column is "File_01" both files will be selected and renamed by what is in the 'NEW' column.

*NOTE* Watch for 'OLD' names that are not unique enough!

e.g.
RENAME
RENAME - Copy(1)
RENAME - Copy(2)

If "RENAME" and "RENAME - Copy(1)" are both in the 'OLD' column "RENAME" will rename all of the files and "RENAME - Copy(1)" will not find a matching file.

-Script reports files that are in the folder but no in the 'OLD' list
-Script reports files that are in the 'OLD' list but not in the folder.