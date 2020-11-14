for i in range(32):
    print("lui $"+str(i)+", 1")
for i in range(2,32):
     print("addu $"+str(i)+", $"+str(i-1)+", $"+str(i-2))
for i in range(1,31):
    print("sw $"+str(i)+", "+str(i*4)+"($0)")