function K = rbf_kernel(X1,X2)

sigma = .1;
numData_X1 = size(X1, 1);
numData_X2 = size(X2, 1);

for i=1:numData_X1
	for j=1:numData_X2
		D(i,j) = mydist(X1(i,:), X2(j,:)');
	end
end

K = exp(-D/(2*sigma^2));

end

