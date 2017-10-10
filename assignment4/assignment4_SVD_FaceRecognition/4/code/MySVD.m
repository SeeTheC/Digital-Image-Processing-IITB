function [ U S V ] = MySVD( A )
    % Find the SVD of the matrix by using eigen functon
    [m n]=size(A);
    r=min(m,n);    
    AAT=A*A';
    ATA=A'*A;    
    [U Du]=eig(AAT);
    [V Dv]=eig(ATA);    
    %Findin Positive Sqrt for the D
    Du=(Du>0).*Du;
    % Reagrranging Eigen Vectors in increaing order
    [sorted,order]=sort(diag(Du),'descend');
    Du=diag(sorted);
    U=U(:,order);    
    [sorted,order]=sort(diag(Dv),'descend');
    V=V(:,order);    
    
    % Finding Sigular values Dim: mxn
    S=Du.^0.5;
    if(r==n)
        S=S(:,1:r);
    elseif(r==m)
        Z=zeros(m,n-m);
        S=[S Z];       
    end 
    % Eigen Vector can be of inverted sign
    SignChange=sign(diag(U'*A*V));
    for i=1:numel(SignChange)
        if(SignChange(i)==-1)
            U(:,i)=U(:,i)*SignChange(i); 
        end
    end
end

