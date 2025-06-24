`timescale 1ns / 1ps

module Decryption(
    input clk,
    input reset,
    input logic enc_done,                // <-- Added: starts decryption when 1
    input logic [0:127] Enc_data,       // encrypted data to be decrypted
    input logic [0:127] key [0:10],     // decryption keys (reversed encryption keys)
    output logic [0:127] Processed_data, // Final decrypted data
    output logic done                   // Signal indicating decryption is complete
    );
                      // internal flag to start process

    // Inverse S-Box table (unchanged, as in your original code)
    localparam logic [7:0] inv_s_table [0:15][0:15] = '{
    '{8'h52, 8'h09, 8'h6a, 8'hd5, 8'h30, 8'h36, 8'ha5, 8'h38, 8'hbf, 8'h40, 8'ha3, 8'h9e, 8'h81, 8'hf3, 8'hd7, 8'hfb},
    '{8'h7c, 8'he3, 8'h39, 8'h82, 8'h9b, 8'h2f, 8'hff, 8'h87, 8'h34, 8'h8e, 8'h43, 8'h44, 8'hc4, 8'hde, 8'he9, 8'hcb},
    '{8'h54, 8'h7b, 8'h94, 8'h32, 8'ha6, 8'hc2, 8'h23, 8'h3d, 8'hee, 8'h4c, 8'h95, 8'h0b, 8'h42, 8'hfa, 8'hc3, 8'h4e},
    '{8'h08, 8'h2e, 8'ha1, 8'h66, 8'h28, 8'hd9, 8'h24, 8'hb2, 8'h76, 8'h5b, 8'ha2, 8'h49, 8'h6d, 8'h8b, 8'hd1, 8'h25},
    '{8'h72, 8'hf8, 8'hf6, 8'h64, 8'h86, 8'h68, 8'h98, 8'h16, 8'hd4, 8'ha4, 8'h5c, 8'hcc, 8'h5d, 8'h65, 8'hb6, 8'h92},
    '{8'h6c, 8'h70, 8'h48, 8'h50, 8'hfd, 8'hed, 8'hb9, 8'hda, 8'h5e, 8'h15, 8'h46, 8'h57, 8'ha7, 8'h8d, 8'h9d, 8'h84},
    '{8'h90, 8'hd8, 8'hab, 8'h00, 8'h8c, 8'hbc, 8'hd3, 8'h0a, 8'hf7, 8'he4, 8'h58, 8'h05, 8'hb8, 8'hb3, 8'h45, 8'h06},
    '{8'hd0, 8'h2c, 8'h1e, 8'h8f, 8'hca, 8'h3f, 8'h0f, 8'h02, 8'hc1, 8'haf, 8'hbd, 8'h03, 8'h01, 8'h13, 8'h8a, 8'h6b},
    '{8'h3a, 8'h91, 8'h11, 8'h41, 8'h4f, 8'h67, 8'hdc, 8'hea, 8'h97, 8'hf2, 8'hcf, 8'hce, 8'hf0, 8'hb4, 8'he6, 8'h73},
    '{8'h96, 8'hac, 8'h74, 8'h22, 8'he7, 8'had, 8'h35, 8'h85, 8'he2, 8'hf9, 8'h37, 8'he8, 8'h1c, 8'h75, 8'hdf, 8'h6e},
    '{8'h47, 8'hf1, 8'h1a, 8'h71, 8'h1d, 8'h29, 8'hc5, 8'h89, 8'h6f, 8'hb7, 8'h62, 8'h0e, 8'haa, 8'h18, 8'hbe, 8'h1b},
    '{8'hfc, 8'h56, 8'h3e, 8'h4b, 8'hc6, 8'hd2, 8'h79, 8'h20, 8'h9a, 8'hdb, 8'hc0, 8'hfe, 8'h78, 8'hcd, 8'h5a, 8'hf4},
    '{8'h1f, 8'hdd, 8'ha8, 8'h33, 8'h88, 8'h07, 8'hc7, 8'h31, 8'hb1, 8'h12, 8'h10, 8'h59, 8'h27, 8'h80, 8'hec, 8'h5f},
    '{8'h60, 8'h51, 8'h7f, 8'ha9, 8'h19, 8'hb5, 8'h4a, 8'h0d, 8'h2d, 8'he5, 8'h7a, 8'h9f, 8'h93, 8'hc9, 8'h9c, 8'hef},
    '{8'ha0, 8'he0, 8'h3b, 8'h4d, 8'hae, 8'h2a, 8'hf5, 8'hb0, 8'hc8, 8'heb, 8'hbb, 8'h3c, 8'h83, 8'h53, 8'h99, 8'h61},
    '{8'h17, 8'h2b, 8'h04, 8'h7e, 8'hba, 8'h77, 8'hd6, 8'h26, 8'he1, 8'h69, 8'h14, 8'h63, 8'h55, 8'h21, 8'h0c, 8'h7d}
    };

  // Internal registers
    logic [0:127] Dec_data_temp, next_Dec_data;
    logic [3:0] round, next_round;
    logic processing, next_processing;
    logic next_done;
    
    // Intermediate computation registers
    logic [0:127] inv_shift_out, inv_sbox_out, roundkey_out, inv_mix_out;

    // Combinational next-state logic
    always_comb begin
        // Default assignments
        next_Dec_data = Dec_data_temp;
        next_round = round;
        next_processing = processing;
        next_done = 1'b0;
        
        // Compute intermediate values
        inv_shift_out = InvShift_rows(Dec_data_temp);
        inv_sbox_out = InvS_box(inv_shift_out);
        roundkey_out = Add_roundkey(round, inv_sbox_out);
        inv_mix_out = InvMix_columns(roundkey_out);

        // State transition logic
        if (enc_done && !processing) begin
            // Initial round
            next_Dec_data = Enc_data ^ key[10];  // AddRoundKey with key[10]
            next_round = 9;
            next_processing = 1'b1;
        end
        else if (processing) begin
            if (round > 0) begin
                // Main rounds
                next_Dec_data = inv_mix_out;
                next_round = round - 1;
            end
            else begin
                // Final round (round 0)
                next_Dec_data = roundkey_out;  // Skip InvMixColumns for final round
                next_processing = 1'b0;
                next_done = 1'b1;
                next_round = 10;  // Reset for next decryption
            end
        end
    end

    // Sequential logic with non-blocking assignments
    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            Dec_data_temp <= 128'h0;
            Processed_data <= 128'h0;
            round <= 10;        // Start with round 10 for decryption
            done <= 1'b0;
            processing <= 1'b0;
        end else begin
            Dec_data_temp <= next_Dec_data;
            round <= next_round;
            done <= next_done;
            processing <= next_processing;
            
            // Register final output
            if (next_done) begin
                Processed_data <= next_Dec_data;
            end
        end
    end

    function [0:127] Add_roundkey(input integer n, input [0:127] in);
        logic [0:127] out;
        out = in ^ key[n];
        return out;
    endfunction
    
    function [0:127] InvShift_rows(input [0:127] in);
        logic [0:127] out;
        
        out[0+:8]   = in[0+:8]; out[32+:8]  = in[32+:8];
        out[64+:8]  = in[64+:8]; out[96+:8]  = in[96+:8];
        
        out[8+:8]   = in[104+:8]; out[40+:8] = in[8+:8];
        out[72+:8]  = in[40+:8];  out[104+:8] = in[72+:8];
        
        out[16+:8]  = in[80+:8];  out[48+:8] = in[112+:8];
        out[80+:8]  = in[16+:8];  out[112+:8] = in[48+:8];
        
        out[24+:8]  = in[56+:8];  out[56+:8] = in[88+:8];
        out[88+:8]  = in[120+:8]; out[120+:8] = in[24+:8];
        
        return out;
    endfunction

    function logic [0:127] InvS_box(input logic [0:127] in);
        logic [0:127] out;
        out = {inv_s_table[in[0:3]][in[4:7]], inv_s_table[in[8:11]][in[12:15]],
               inv_s_table[in[16:19]][in[20:23]], inv_s_table[in[24:27]][in[28:31]],
               inv_s_table[in[32:35]][in[36:39]], inv_s_table[in[40:43]][in[44:47]],
               inv_s_table[in[48:51]][in[52:55]], inv_s_table[in[56:59]][in[60:63]],
               inv_s_table[in[64:67]][in[68:71]], inv_s_table[in[72:75]][in[76:79]],
               inv_s_table[in[80:83]][in[84:87]], inv_s_table[in[88:91]][in[92:95]],
               inv_s_table[in[96:99]][in[100:103]], inv_s_table[in[104:107]][in[108:111]],
               inv_s_table[in[112:115]][in[116:119]], inv_s_table[in[120:123]][in[124:127]]};
        return out;
    endfunction

    function logic [0:127] InvMix_columns(input logic [0:127] in);
        logic [0:127] out;
        for (int i = 0; i < 4; i++) begin
            out[(i*32)+:8] = multiply0e(in[(i*32)+:8]) ^ multiply0b(in[(i*32 + 8)+:8]) ^ multiply0d(in[(i*32 + 16)+:8]) ^ multiply09(in[(i*32 + 24)+:8]);
            out[(i*32 + 8)+:8] = multiply09(in[(i*32)+:8]) ^ multiply0e(in[(i*32 + 8)+:8]) ^ multiply0b(in[(i*32 + 16)+:8]) ^ multiply0d(in[(i*32 + 24)+:8]);
            out[(i*32 + 16)+:8] = multiply0d(in[(i*32)+:8]) ^ multiply09(in[(i*32 + 8)+:8]) ^ multiply0e(in[(i*32 + 16)+:8]) ^ multiply0b(in[(i*32 + 24)+:8]);
            out[(i*32 + 24)+:8] = multiply0b(in[(i*32)+:8]) ^ multiply0d(in[(i*32 + 8)+:8]) ^ multiply09(in[(i*32 + 16)+:8]) ^ multiply0e(in[(i*32 + 24)+:8]);
        end
        return out;
    endfunction

    // Multiplication functions for InvMixColumns
    function logic [0:7] multiply09(input logic [0:7] in);
        return multiply2(multiply2(multiply2(in))) ^ in;
    endfunction

    function logic [0:7] multiply0b(input logic [0:7] in);
        return multiply2(multiply2(multiply2(in)) ^ in) ^ in;
    endfunction

    function logic [0:7] multiply0d(input logic [0:7] in);
        return multiply2(multiply2(multiply2(in) ^ in)) ^ in;
    endfunction

    function logic [0:7] multiply0e(input logic [0:7] in);
        return multiply2(multiply2(multiply2(in) ^ in) ^ in);
    endfunction

    function logic [0:7] multiply2(input logic [0:7] in);
        return (in[0] ? (in << 1) ^ 8'h1b : in << 1);
    endfunction
  
endmodule