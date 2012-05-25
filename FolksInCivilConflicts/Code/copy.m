function new = copy(this)
%COPY
%workaround to provide a deep copy
    save('temp.mat', 'this');
    Foo = load('temp.mat');
    new = Foo.this;
    delete('temp.mat');
end