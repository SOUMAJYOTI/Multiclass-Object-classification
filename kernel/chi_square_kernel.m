function K = chi_square_kernel(Si,Sj)
numData_Si = size(Si, 1);
numData_Sj = size(Sj, 1);

sum = 0;
for i=1:numData_Si
	for j=1:numData_Sj
		D(i,j) = chi_square_statistics(Si(i,:), Sj(j,:));
		sum = sum+D(i,j);
	end
end

sum_mean = sum/(numData_Si*numData_Sj);

for i=1:numData_Si
	for j=1:numData_Sj
		K(i,j) = exp(-D(i,j)/sum_mean);
	end
end


end

