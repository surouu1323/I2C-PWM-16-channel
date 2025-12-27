
    // ==== WRITE SEQUENCE ====
    task i2c_write(
        input [7:0] reg_address, 
        input [15:0] wdata
        );
        integer i;
        begin
            $display("[WRITE ] addr = 0x%d | data = 0x%0h", reg_address, wdata);
            tb.ack_respone = 0;
            i2c_start();
            i2c_send_byte({SLAVE_ADD, 1'b0});  i2c_slave_ack();

            i2c_send_byte(reg_address);  i2c_slave_ack();
            i2c_send_byte(wdata[15:8]      );  i2c_slave_ack();
            i2c_send_byte(wdata[7 :0]      );  i2c_slave_ack();

            i2c_stop();

            if(!tb.ack_respone) begin
                $display("NACK: Slave not respone");
                tb.error = tb.error + 1;
            end
            else begin
                // $display("ACK: Slave respone");
            end

        end
    endtask

    // ==== WRITE SEQUENCE ====
    task i2c_read(
        input [7:0] reg_address, 
        input [15:0] cmp_data
        );
        integer i;
        reg [15:0] rdata;
        begin
            $display("[READ ] read data at addr = 0x%0d", reg_address);
            tb.ack_respone = 0;
            rdata = 0;
            i2c_start();
            i2c_send_byte({SLAVE_ADD, 1'b0});  i2c_slave_ack();
            i2c_send_byte(reg_address);  i2c_slave_ack();

            i2c_start();
            i2c_send_byte({SLAVE_ADD, 1'b1});  i2c_slave_ack();

            i2c_read_byte(rdata[15:8]      );  i2c_master_ack(1);
            i2c_read_byte(rdata[7 :0]      );  i2c_master_ack(0);

            i2c_stop();

            if(!tb.ack_respone) begin
                $display("NACK: Slave not respone");
                tb.error = tb.error + 1;
            end
            else begin
                // $display("ACK: Slave respone");
                if(cmp_data !== rdata) begin
                    $display("[FAIL ] rdata mismatch | expect = 0x%0h | recv = 0x%0h", cmp_data, rdata);
                    tb.error = tb.error + 1;
                end
                else $display("[PASS ] rdata match    | expect = 0x%0h | recv = 0x%0h", cmp_data, rdata);
            end

        end
    endtask


    // Task start condition
    task i2c_start();
        begin
            @(negedge tb.clk) tb.scl_en = 0; tb.sda_drive = 1;
            @(negedge tb.clk)  tb.sda_drive = 0;   tb.scl_en = 1;
            @(posedge tb.clk)  ;
        end
    endtask

    task i2c_slave_ack();
        begin
            @(negedge tb.clk) tb.sda_drive = 1;
            @(posedge tb.clk) tb.ack_respone = ~tb.sda;
            @(negedge tb.scl) ;
        end
    endtask

     task i2c_master_ack(input ack);
        begin
            
            @(negedge tb.clk) tb.sda_drive = ~ack;
            @(posedge tb.clk) ;
            @(negedge tb.scl) tb.sda_drive = 1;
        end
    endtask

    // Task stop condition
    task i2c_stop();
        begin
            @(negedge tb.clk) tb.sda_drive = 0;
            @(posedge tb.clk) tb.scl_en = 0;   
            @(negedge tb.clk) tb.sda_drive = 1; 
        end
    endtask

    // Task gửi 1 byte qua I2C
    task i2c_send_byte(input [7:0] data);
        integer i;
        begin
            for (i=8; i > 0; i=i-1) begin
                @(negedge tb.clk)  tb.sda_drive = data[i-1];
                @(negedge tb.scl) ;
            end
        end
    endtask

    task i2c_read_byte(output [7:0] data);
        integer i;
        
        begin
            tb.sda_drive = 1;
            for (i=8; i > 0; i=i-1) begin
                @(posedge tb.scl)  data[i-1] = tb.sda;
            end
            @(negedge tb.scl);
        end
    endtask
