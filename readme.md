This is final project for Hardware synthesis Lab 

[My Github](https://github.com/tumrabert "Github home")

# This is calculator 
that can calculate 4 digits decimal  (-9999 to 9999) with 4 operation(+,-,*,/) which accept input from USB keyboard via UART then display through VGA port using BASYS3 board.

## How to Run this project
1. Clone or download this.

2. Create New Project in Vivado program.(Don't forget to select for board BASYS3)

3. Add every file in folder source into design sourece.

4. Add "\constrs_1\Basys3_Master.xdc" into constraints

5. Run synthesis,Run Implementation,Generate Bitstream respectively.

6. Open Hardware Manager, Open target ,Program Devices.

## How to use
(Input though UART)

1. Input number(-9999 to 9999) (If you want to input negative number press "N" ) then press "Enter"

2. Input operators(press +,-,*,/) then press "Enter"

3. Input number again like 1.

4. A result will be show.

* You can reset everything by press middle button on BASYS3 Board

