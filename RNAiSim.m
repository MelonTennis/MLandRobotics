function yeild = RNAiSim(genenum)
if(genenum>50)
    display('Error: genenum must be from 1 to 50');
end

y1 = 2;
y2 = 5.5;
if(genenum==10)
    yeild = max(0,y2 + randn);
else
    yeild = max(0,y1 + randn);
end

end