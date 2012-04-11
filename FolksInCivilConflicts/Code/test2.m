for i=1:10
    for j=1:10
        A(i,j)=agent();
        A(i,j)=A(i,j).initAgent(i*j);
    end
end
A