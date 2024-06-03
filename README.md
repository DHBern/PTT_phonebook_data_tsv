# PTT_phonebook_data_tsv


This data and the online search platform historic.localsearch makes old telephone telephone directory entries through a public and free online database accessible to everyone. historic.localsearch was created through the collaboration between the PTT archive, the Digital Humanities at the University of Bern and localsearch.

<h2>Data</h2>
The aim is to make historical data accessible to a broad public.

This repository contains the basis of historic.localsearch.ch.
All tsv are in the folder "tsv". The tsv can be loaded to the SQL-DB.

All data has been processed automatically, based on the OCRed phone book data. OCR errors are to be expected on several levels
- Error in recognized characters (no specific training for used printings)
- Error in the layout identification. In several cases the columns have not been correctly identified, mixing the entries
- Mixing advertisment with phone number entries.


<h2>Application</h2>

In the folder "code_manual_replacement" a bash script and a document of the replaced strings can be found.
