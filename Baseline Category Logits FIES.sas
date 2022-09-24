data catdata.fiessort;
set catdata.fiesproj;
if 'Type of Building/House'n = 'Single house' then House =1;
if 'Type of Building/House'n = 'Duplex' then House =2;
if 'Type of Building/House'n = 'Multi-unit residential' then House =3;
if 'Type of Household'n = 'Extended Family' then ExtendedFamily = 1;
else ExtendedFamily = 0;
if 'Type of Household'n = 'Two or More Nonrelated Persons/Members' then NonRelated=1;
else NonRelated = 0;
run;

proc sort data = catdata.fiessort;
by House;
run;

proc freq data = catdata.fiessort;
table House;
run;

title "Full Model";
proc logistic data = catdata.fiessort order = data; 
model House = ExtendedFamily NonRelated 'Total Food Expenditure'n 'Clothing, Footwear and Other Wea'n
'Housing and water Expenditure'n 'Medical Care Expenditure'n  'Transportation Expenditure'n 
'Communication Expenditure'n 'Education Expenditure'n / ctable corrb link = glogit 
alpha = 0.05 clparm = wald clodds = wald influence ctable;
units 'Total Food Expenditure'n = 2000 
'Clothing, Footwear and Other Wea'n = 2000
'Housing and water Expenditure'n = 2000 
'Medical Care Expenditure'n = 2000
'Transportation Expenditure'n = 2000
'Communication Expenditure'n = 2000
'Education Expenditure'n = 2000;
output out = results1 p = predicted;
oddsratio ExtendedFamily;
oddsratio NonRelated;
run;

title "Backward Selection";
proc logistic data = catdata.fiessort order = data; 
model House = ExtendedFamily NonRelated 'Total Food Expenditure'n 'Clothing, Footwear and Other Wea'n
'Housing and water Expenditure'n 'Medical Care Expenditure'n  'Transportation Expenditure'n 
'Communication Expenditure'n 'Education Expenditure'n / ctable corrb link = glogit selection = backward slentry = 0.05 slstay = 0.05
alpha = 0.05 clparm = wald clodds = wald influence;
units 'Total Food Expenditure'n = 2000 
'Clothing, Footwear and Other Wea'n = 2000
'Housing and water Expenditure'n = 2000 
'Medical Care Expenditure'n = 2000
'Transportation Expenditure'n = 2000
'Communication Expenditure'n = 2000
'Education Expenditure'n = 2000;
output out = results1 p = predicted;
oddsratio ExtendedFamily;
run;