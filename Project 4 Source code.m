%For the problem 1:
%a)	Method 1:
a1=input('a1=');        %enter the probability that the packet is switched to port 1
a2=1-a1;
p_matrix=[a1,0.5*a2,0.5*a2,0;      %set the transition matrix
          a1^2,a1*a2,a1*a2,a2^2;
          a1^2,a1*a2,a1*a2,a2^2;
          0,0.5*a1,0.5*a1,a2];
state=[1,0,0,0];
limit=1000000;
for it=1:limit                     %set the total number of calculation loop
    state=state*p_matrix;
end
tptotal=(state(1)+state(4)+2*(state(2)+state(3)))*10^6          %compute the throughput for       each output port and the overall throughput 
tp1=(state(1)+state(2)+state(3))*10^6
tp2=(state(4)+state(2)+state(3))*10^6

%b)	Method 2:
a1=input('a1=');        %enter the probability that the packet is switched to port 1
limit=1000000;            %set the total number of loop
sum=0;                      %initialize the accumulator of packets
singleport=[0,0];
output=[2,2];             %set the first state 
for j=1:limit             %the loop begins
    if output(1)==output(2)
        sum=sum+1;        %decide the throughput of the each output port
        singleport(output(1))=singleport(output(1))+1;
        if rand<a1        %decide the destination of the new packet
            output(1)=1;
        else
            output(1)=2;
        end
    else  
        sum=sum+2;        %decide the throughput of the each output port
        singleport(1)=singleport(1)+1;
        singleport(2)=singleport(2)+1;
        x=rand(1,2);
        for i=1:2         %decide the destination of the new packet
            if x(i)<a1
                output(i)=1;
            else
                output(i)=2;
            end
        end
    end
end
tptotal=sum               %compute the throughput for each output port and the overall throughput 
tp1=singleport(1)
tp2=singleport(2)

%For the problem 2:
%a)	Balanced traffic:
N=input('Enter total number of input ports N=');   %enter total number of input ports
limit=1000000;                                               %set the total number of loop

singleport=zeros(1,N);
output=zeros(1,N)+1;       %set the first state
sum=0;                        %initialize the accumulator of packets
for i=1:N                    %define the probability of the each output port
    a(i)=1/N;
end
prob(1)=a(1);               %create the array of the probability
for i=2:N
    prob(i)=a(i)+ prob(i-1);
end
for j=1:limit               %the loop begins
    sum=sum+length(unique(output));         %decide the throughput of the single output port
    k=unique(output);
    for i=1:length(x)
        singleport(x(i))=singleport(x(i))+1;
    end
    for i=1:length(x)        %decide the destination of the new packet
        position=find(output==x(i));
        P(i)=position(1);
        m=1;
        q=rand;
        while q>prob(m)
            m=m+1;
        end
        output(P(i))=m;      %the destination of the replaced packet
    end
end
tptotal=sum               %compute and return the throughput for each output port and the overall throughput
singleport 

%b)	Hot-spot traffic:
N=input('Enter total number of input ports N=');   %enter total number of input ports
k=input('Enter the parameter k=');                    %specify the parameter k
singleport=zeros(1,N);
limit=1000000;
output=zeros(1,N)+1;     %set the first state
sum=0;                      %initialize the accumulator of packets
a(1)=1/k;                  %define the probability of the each output port
for i=2:N
    a(i)=(1/(N-1))*((k-1)/k);
end
prob(1)=a(1);            %create the array of the probability
for i=2:N
    prob(i)=a(i)+ prob(i-1);
end
for j=1:limit           %the loop begins
    sum=sum+length(unique(output));    %decide the throughput of the single output port
    x=unique(output);
    for i=1:length(x)
        singleport(x(i))=singleport(x(i))+1;
    end
    for i=1:length(x)                    %decide the destination of the new packet
        position=find(output==x(i));
        P(i)=position(1);
        m=1;
        q=rand;
        while q>prob(m)
            m=m+1;
        end
        output(P(i))=m;       %the destination of the replaced packet
    end
end
tptotal=sum                  %compute and return the throughput for each output port and the overall throughput
singleport 


