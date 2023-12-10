import merged ::* ;

module mktester_flag(Empty);

Reg#(int) clk <- mkReg(0) ;
Reg#(int) count <- mkReg(1) ;

MulIfc mul <- mkmul() ;

Bit#(64) pyld1, pyld2, pyld3, pyld4, pyld5, pyld6, pyld7, pyld8 ;

//underflow
pyld1=64'b0000000000000000000000000000000000000000000000000000000000000001;
pyld2=64'b0000000000000000000000000000000000000000000000000000000000000001;

//overflow
pyld3=64'b0011111111111111111111111111111111111111111111111111111111111111;
pyld4=64'b0011111111111111111111111111111111111111111111111111111111111111;

pyld5=64'b0111110111111000000000000000000000000000000000000000000000000000;

pyld6=64'b0111111111110100000000000000000000000000000000000000000000000000;

pyld7=64'b1111110111110100000000000000000000000000000000000000000000000000;

pyld8=64'b1111111111110000000000000000000000000000000000000000000000000000;


rule timer;
      clk <= clk +1 ;

      if(clk == 25) begin 
         $finish;
      end

      
    
endrule

rule data;

if(clk == 1 ) // Underflow
begin 
      
      mul.fp1(pyld1);
      mul.fp2(pyld2);
end

if(clk == 2 ) // Overflow
begin 
      
      mul.fp1(pyld3);
      mul.fp2(pyld4);
end

if(clk == 3 ) // Positive Infinite
begin 
      
      mul.fp1(pyld5);
      mul.fp2(pyld6);
end

if(clk == 4 ) // Negative Infinite
begin 
      
      mul.fp1(pyld6);
      mul.fp2(pyld7);
end

if(clk == 5 ) // NaN
begin 
      
      mul.fp1(pyld6);
      mul.fp2(pyld8);
end

endrule

rule outputd;

if(clk<15) begin
         let a <-mul.output1;
         let b <-mul.outputflag;
         $display ("Sample no: %0d",count) ;
         $display ("Output: %b",a) ;
         $display ("Flags: %b",b) ;
         count<=count+1;
      end

endrule

endmodule



