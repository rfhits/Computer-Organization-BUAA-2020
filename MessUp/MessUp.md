# MessUp

这是一个记录自己犯的错误的文件夹。  
**不要笑！！！**

## Verilog

### 常数定义

[位数]'[进制][数值]  
![const](/MessUp/Verilog-1-literal.jpg)  
亮点见[位数]

### reg在端口前

![reg_before_ports](/MessUp/Verilog-4-reg_before_ports.jpg)

### 端口定义

在定义时，常常把忘了input改成output  
![ports_error](/MessUp/Verilog-2-ports_error.jpg)  
我说这C咋一直都不变呢？？  

### 三目运算符下的算数右移

三目运算符下其他无符号数导致了 $signed(A)>>>B 被当作无符号数处理  
![sra_error](/MessUp/Verilog-3-ternary_operator_sra.jpg)  
至于为什么多套一个 $signed() ，就能得到符合预期的结果，，未解之谜。  
若要求稳，always(*)，避免三目运算符。  

### case后面不要加上冒号

![no_colon_behind_case](/MessUp/Verilog-5-no_colon_behind_case.jpg)  

### 常数拼接线位后用大括号并起来

![brace_the_const](/MessUp/Verilog-6-brace_the_const.jpg)  
这个是观察学长代码发现的。

## MIPS

### load address

都是对寄存器里面存值，但是  
load immediate  
load address  
对load的东西要区分开
![load address](/MessUp/MIPS-1-li_and_la.jpg)
