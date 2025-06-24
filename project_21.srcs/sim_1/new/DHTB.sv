`timescale 1ns / 1ps

module tb_diffie_hellman_top();
    parameter WIDTH = 127;
    parameter CLK_PERIOD = 10; // 10ns = 100MHz
    
    // Clock and reset
    logic clk;
    logic rst_n;
    
    // Test message (16 characters = 128 bits when using ASCII)
    string test_message = "HelloDiffie12345"; // Exactly 16 characters
    
    // Top module signals
    logic key_exchange_complete;
    logic [WIDTH:0] shared_secret_a;
    logic [WIDTH:0] shared_secret_b;
    logic [WIDTH:0] Enc_data;
    logic [WIDTH:0] key [0:10];
    logic key_done;
    logic enc_done;
    logic data_signal_a;
    logic [WIDTH:0] data_a;
    logic [WIDTH:0] Processed_data;
    logic Dec_done;
    logic begin_enc;
    
    // Received message storage
    string received_message;
    
    // Instantiate top module
    diffie_hellman_top #(.WIDTH(WIDTH)) dut (
        .clk(clk),
        .rst_n(rst_n),
        .key_exchange_complete(key_exchange_complete),
        .shared_secret_a(shared_secret_a),
        .shared_secret_b(shared_secret_b),
        .key(key),
        .key_done(key_done),
        .data_signal_a(data_signal_a),
        .data_a(data_a),
        .begin_enc(begin_enc), 
        .enc_done(enc_done),
        .Enc_data(Enc_data),
        .Processed_data(Processed_data),
        .Dec_done(Dec_done) 
    );
    
    // Function to convert string to 128-bit value (MSB first)
    // Function to convert string to 128-bit value (MSB first)
function automatic logic [127:0] string_to_bits(input string s);
    logic [127:0] result = 0;
    for (int i = 0; i < 16; i++) begin
        logic [7:0] char = (i < s.len()) ? s[i] : 8'h00;
        result[127-i*8 -:8] = char; // Corrected bit selection
    end
    return result;
endfunction

// Function to convert 128-bit value to string (MSB first)
function automatic string bits_to_string(input logic [127:0] bits);
    string result = "";
    for (int i = 0; i < 16; i++) begin
        logic [7:0] char = bits[127-i*8 -:8];
        // Only add non-null characters
        if (char != 0) result = {result, string'(char)};
        // For debugging:
        $display("Char %0d: %h '%s'", i, char, char);
    end
    return result;
endfunction

    
    // Clock generation
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end
    
    // Main test sequence
    initial begin
        // Convert test message to 128-bit value
        data_a = string_to_bits(test_message);
        
        // Initialize
        rst_n = 0;
        data_signal_a = 0;
        #100;
        
        $display("\nStarting Diffie-Hellman Key Exchange Test");
        $display("Original Message: %s", test_message);
        $display("Message as 128-bit: %h", data_a);
        
        // Start test
        rst_n = 1;
        data_signal_a = 1;
        
        // Wait for key exchange completion
        $display("\nWaiting for key exchange to complete...");
        wait(key_exchange_complete);
        if (key_exchange_complete) begin
            $display("KEYS EXCHANGED");
            $display("Shared Secret A: %h", shared_secret_a);
            $display("Shared Secret B: %h", shared_secret_b);
        end
        
        // Wait for key generation
        wait(key_done);
        if (key_done) begin
            $display("\nAES KEYS GENERATED:");
            for (int i = 0; i < 11; i++) begin
                $display("Key[%0d]: %h", i, key[i]);
            end
        end
         
        // Wait for encryption
        wait(enc_done);
        if (enc_done) begin
            $display("\nENCRYPTION COMPLETE");
            $display("Encrypted Data: %h", Enc_data);
        end     
         
        // Wait for decryption
        wait(Dec_done);
        if (Dec_done) begin
            // Convert back to string
            received_message = bits_to_string(Processed_data);
            
            $display("\nDECRYPTION COMPLETE");
            $display("Decrypted Data: %h", Processed_data);
            $display("Original Message: %s", test_message);
            $display("Decrypted Message: %s", received_message);
            
            // Verify exact 128-bit match
            if (data_a === Processed_data) begin
                $display("\nTEST PASSED: Exact 128-bit match!");
            end else begin
                $display("\nTEST FAILED: Data mismatch!");
                $display("Expected: %h", data_a);
                $display("Received: %h", Processed_data);
            end
            
            // Verify string content
            if (test_message == received_message) begin
                $display("String content verified!");
                  $display("\nPerformance Metrics:");
        $display("Total simulation time: %0d ns", $time);
        $display("Total clock cycles: %0d", ($time-100)/CLK_PERIOD);

            end else begin
                $display("String content mismatch!");
            end
            
        end 
        
        #100;
        $finish;
    end
    
    // Monitor progress
    initial begin
        $timeformat(-9, 2, " ns", 10);
        @(posedge dut.public_key_done_a)
            $display("\n[%0t] Public Keys Generated:", $time);
            $display("User A public key: %h", dut.public_key_a);
            $display("User B public key: %h", dut.public_key_b);
          
    end
    
endmodule