cls 
set more off
clear
cd "C:\DISCO DAJAV\DAVID JAVIER\2019-1\job\censo2"
use censo_filtro

*gen ciiu = substr(c5_p20_cod,1,2) 
*gen codig = ciiu 

destring c5_p20_cod , g(codigo)  
gen categ = codigo 
*-----------------------------------------------------
 /*label define ciie
A  = 1 "Agro_gan_pesca" - Agricultura
   = 2 , ganadería
   = 3 , silvicultura y pesca

B = 2 "Extractivas"  - Explotación de minas y canteras
C = 3 "Manufactura" - Industrias manufactureras
D = 4 "Energía" - Suministro de electricidad, gas, vapor y aire acondicionado 
E = 5 "Agua" - Suministro de agua; evacuación de aguas residuales, gestión de desechosydescontaminación
F = 6 "Construcción" - Construcción
G = 7 "Comercio_vehi" -Comercio al por mayor y al por menor; reparación de vehículos automotores y motocicletas
H = 8 "Transporte_almacen" -  Transporte y almacenamiento
I = 9 "Alojamiento_comida" - Actividades de alojamiento y de servicio de comidas
J = 10 "Info_comunica" - Información y comunicaciones 
K = 11 "Finanzas" - Actividades financieras y de seguros 
L = 12 "Inmobilirias" - Actividades inmobiliarias
M = 13 "Prof_science_tec" - Actividades profesionales, científicas y técnicas 
N = 14 "Administrativos" - Actividades de servicios administrativos y de apoyo
O = 15 "Sector_publico" - Administración pública y defensa; planes de seguridad social de afiliación obligatoria 
P = 16 "Enseñanza" - Enseñanza 
Q = 17 "Salud" - Actividades de atención de la salud humana y de asistencia social
R = 18 "Arte_entreten" - Actividades artísticas, de entretenimiento y recreativas 
S = 19 "Otros_servicios" - Otras actividades de servicios
T = 20 "Actividades_hogares" - Actividades de los hogares como empleadores; actividades no diferenciadas de los 
hogares como productores de bienes y servicios para uso propio 
U = 21 "Organizaciones_extraterritorio" - Actividades de organizaciones y órganos extraterritoriales
*/
* SECCION  "A"
*solo Agro 
replace categ = 1 if 110<codigo & codigo <131  
replace categ = 1 if 149<codigo & codigo <162
replace categ = 1 if 162<codigo & codigo <165
* solo ganaderia 
replace categ = 2 if 140 <codigo & codigo <150 
replace categ = 2 if codigo ==162 // apoyo
replace categ = 2 if codigo == 170  // caza 
* solo silvicultura
replace categ = 3 if 209<codigo & codigo <241
* solo pesca y acuicultura
replace categ = 4 if 310<codigo & codigo <323

* SECCION "B" 
* solo mineria 
replace categ = 5 if 509<codigo & codigo <521
replace categ = 5 if 709<codigo & codigo <900
replace categ = 5 if codigo==990 
* solo hidrocarburos 
replace categ = 6 if 609<codigo & codigo<621
replace categ = 6 if codigo ==910 
* SECCION "C"
* manufacturas
replace categ =7 if 1009<codigo & codigo<3321
* SECCION "D"
* energia
replace categ =8 if 3509<codigo & codigo<3531
* SECCION "E"
* agua 
replace categ = 9 if 3599<codigo & codigo<3901
* SECCION "F"  - Construccion
replace categ = 10 if 4099<codigo & codigo <4391
* SECCION "G" - Comercio 
replace categ = 11 if 4509<codigo & codigo<4800
* SECCION "H" - Transporte y almacenamiento
replace categ = 12 if 4910<codigo & codigo <5321
* SECCION "I" - Actividades de Alojamiento y servicio de comidas
replace categ = 13 if 5509<codigo & codigo<5631
* SECCION "J" - Informacion y comunicaciones
replace categ = 14 if 5810<codigo & codigo<6400
* SECCION "K" - Actividades financieras y seguros 
replace categ = 15 if 6410<codigo & codigo<6631
* SECCION "L" - Actividades inmobiliarias
replace categ = 16 if 6809<codigo & codigo<6821
* SECCION "M" - Actividades profesionales, cientificas y tecnicas
replace categ = 17 if 6909<codigo & codigo<7501
* SECCION "N" - Actividades de servicios administrativos y apoyo
replace categ = 18 if 7709<codigo & codigo<8300
* SECCION "O" - Administracion publica y debensa; planes 
* de seguridad social de afiliacion obligatoria
replace categ = 19 if 8410<codigo & codigo<8431
* SECCION "P" - Enseñanza
replace categ = 20 if 8509<codigo & codigo<8551
* SECCION "Q" - Actividades de atencion de la salud humana y 
* de asistencia social  
replace categ = 21 if 8609<codigo & codigo<8891
* SECCION "R" - Actividades artisticas, de entretenimiento y recreativas
replace categ = 22 if 8999<codigo & codigo<9330 
* SECCION "S" - Otras actividades de servicios
replace categ = 23 if 9410<codigo & codigo<9610
* SECCION "T" - "Actividades_hogares" - Actividades de los hogares como
* empleadores; actividades no diferenciadas de los hogares como 
* productores de bienes y servicios para uso propio 
replace categ = 24 if 9699<codigo & codigo<9821
* SECCION "U" - Actividades de organizaciones y organos extraterritoriales
replace categ = 25 if codigo==9900

label define CIU 1 "Agricultura" 2 "Ganaderia" 3 "Silvicultura" 4 "Pesca_acuic" 5 "Mineria" ///
 6 "Hidrocarburos" 7  "Manufactura" 8 "Energía" 9 "Agua" 10 "Construcción" 11 "Comercio_vehi" /// 
 12 "Transporte_almacen" 13 "Alojamiento_comida" 14 "Info_comunica" 15 "Finanzas" ///
 16 "Inmobilirias" 17 "Prof_science_tec" 18 "Administrativos" 19 "Sector_publico" /// 
 20 "Enseñanza" 21 "Salud" 22 "Arte_entreten" 23 "Otros_servicios" ///
 24 "Actividades_hogares" 25 "Orga_extraterritorio"
 label values  categ CIU

save "Censo_editado2" ,replace

** ------------------------------------------------------------------
* PEA OCUPADA
gen mayores =1 if 14<= c5_p4_1 
gen peao_1 = 1 if c5_p16 ==1 & 14<= c5_p4_1  // los que si trabajaron
replace peao_1 = 1 if (c5_p17==1 | c5_p17==2 | c5_p17==3 | c5_p17==4 | c5_p17==5 ) & 14<= c5_p4_1 
replace peao_1 = 0 if peao_1 ==.
labe variable peao_1 "PEA ocupada"
* PEA DESOCUPADA 
gen pea_des = 1 if c5_p18 ==1 & 14<= c5_p4_1
replace pea_des = 0 if pea_des==.
label variable pea_des "PEA desocupada"
* NO PEA
gen nopea = 1 if  (c5_p17==6 | c5_p17==7) & pea_des==0 & 14<= c5_p4_1
replace nopea = 0 if nopea==.
label variable nopea "No PEA" 

save "Censo_editado2" , replace


