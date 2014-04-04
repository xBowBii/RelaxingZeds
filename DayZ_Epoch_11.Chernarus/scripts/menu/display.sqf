_pathtotools = "scripts\menu\tools\";
_EXECscript1 = 'player execVM "'+_pathtotools+'%1"';

adminmenu =
		[
			["",true],
				["Show Position", [2], "", -5, [["expression", format[_EXECscript1, "showpos.sqf"]]], "1", "1"],
				["Flip Vehicle", [4],  "", -5, [["expression", format[_EXECscript1,"flipvehicle.sqf"]]], "1", "1"],

				["", [-1], "", -5, [["expression", ""]], "1", "0"],
			["Exit", [13], "", -3, [["expression", ""]], "1", "1"]		
		];

showCommandingMenu "#USER:adminmenu";