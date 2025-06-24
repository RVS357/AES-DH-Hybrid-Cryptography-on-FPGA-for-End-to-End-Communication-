`timescale 1ns / 1ps

module aes_key_gen(
  input  logic        clk,          // Clock signal
  input  logic        reset,        // Active-high reset
  input  logic        start,        // Start signal (initiates key expansion)
  input  logic [0:127] in_key,      // Input 128-bit initial key
  output logic [0:127] key [0:10],  // Output 11 round keys
  output logic        ready,         // High when all keys are ready
  output logic        begin_enc
);

  // S-box table (byte substitution)
  localparam logic [7:0] s_box [0:255] = '{
    8'h63, 8'h7c, 8'h77, 8'h7b, 8'hf2, 8'h6b, 8'h6f, 8'hc5, 8'h30, 8'h01, 8'h67, 8'h2b, 8'hfe, 8'hd7, 8'hab, 8'h76,
    8'hca, 8'h82, 8'hc9, 8'h7d, 8'hfa, 8'h59, 8'h47, 8'hf0, 8'had, 8'hd4, 8'ha2, 8'haf, 8'h9c, 8'ha4, 8'h72, 8'hc0,
    8'hb7, 8'hfd, 8'h93, 8'h26, 8'h36, 8'h3f, 8'hf7, 8'hcc, 8'h34, 8'ha5, 8'he5, 8'hf1, 8'h71, 8'hd8, 8'h31, 8'h15,
    8'h04, 8'hc7, 8'h23, 8'hc3, 8'h18, 8'h96, 8'h05, 8'h9a, 8'h07, 8'h12, 8'h80, 8'he2, 8'heb, 8'h27, 8'hb2, 8'h75,
    8'h09, 8'h83, 8'h2c, 8'h1a, 8'h1b, 8'h6e, 8'h5a, 8'ha0, 8'h52, 8'h3b, 8'hd6, 8'hb3, 8'h29, 8'he3, 8'h2f, 8'h84,
    8'h53, 8'hd1, 8'h00, 8'hed, 8'h20, 8'hfc, 8'hb1, 8'h5b, 8'h6a, 8'hcb, 8'hbe, 8'h39, 8'h4a, 8'h4c, 8'h58, 8'hcf,
    8'hd0, 8'hef, 8'haa, 8'hfb, 8'h43, 8'h4d, 8'h33, 8'h85, 8'h45, 8'hf9, 8'h02, 8'h7f, 8'h50, 8'h3c, 8'h9f, 8'ha8,
    8'h51, 8'ha3, 8'h40, 8'h8f, 8'h92, 8'h9d, 8'h38, 8'hf5, 8'hbc, 8'hb6, 8'hda, 8'h21, 8'h10, 8'hff, 8'hf3, 8'hd2,
    8'hcd, 8'h0c, 8'h13, 8'hec, 8'h5f, 8'h97, 8'h44, 8'h17, 8'hc4, 8'ha7, 8'h7e, 8'h3d, 8'h64, 8'h5d, 8'h19, 8'h73,
    8'h60, 8'h81, 8'h4f, 8'hdc, 8'h22, 8'h2a, 8'h90, 8'h88, 8'h46, 8'hee, 8'hb8, 8'h14, 8'hde, 8'h5e, 8'h0b, 8'hdb,
    8'he0, 8'h32, 8'h3a, 8'h0a, 8'h49, 8'h06, 8'h24, 8'h5c, 8'hc2, 8'hd3, 8'hac, 8'h62, 8'h91, 8'h95, 8'he4, 8'h79,
    8'he7, 8'hc8, 8'h37, 8'h6d, 8'h8d, 8'hd5, 8'h4e, 8'ha9, 8'h6c, 8'h56, 8'hf4, 8'hea, 8'h65, 8'h7a, 8'hae, 8'h08,
    8'hba, 8'h78, 8'h25, 8'h2e, 8'h1c, 8'ha6, 8'hb4, 8'hc6, 8'he8, 8'hdd, 8'h74, 8'h1f, 8'h4b, 8'hbd, 8'h8b, 8'h8a,
    8'h70, 8'h3e, 8'hb5, 8'h66, 8'h48, 8'h03, 8'hf6, 8'h0e, 8'h61, 8'h35, 8'h57, 8'hb9, 8'h86, 8'hc1, 8'h1d, 8'h9e,
    8'he1, 8'hf8, 8'h98, 8'h11, 8'h69, 8'hd9, 8'h8e, 8'h94, 8'h9b, 8'h1e, 8'h87, 8'he9, 8'hce, 8'h55, 8'h28, 8'hdf,
    8'h8c, 8'ha1, 8'h89, 8'h0d, 8'hbf, 8'he6, 8'h42, 8'h68, 8'h41, 8'h99, 8'h2d, 8'h0f, 8'hb0, 8'h54, 8'hbb, 8'h16
  };

  // Round constants
  localparam logic [31:0] rcon [0:9] = '{
    32'h01000000, 32'h02000000, 32'h04000000, 32'h08000000, 32'h10000000,
    32'h20000000, 32'h40000000, 32'h80000000, 32'h1B000000, 32'h36000000
  };

  // Internal signals
  logic [0:31] key_schedule [0:43];  // 44 words in key schedule
  logic [3:0]  round_count;          // Round counter (0 to 10)
  logic        key_exp_done;         // Flag indicating key expansion complete

  // FSM states
 typedef enum logic [1:0] {
  IDLE,
  EXPANDING,
  DONE
} state_t;

state_t state;

// --- Combinational Logic for Key Expansion ---
logic [0:31] temp_word;      // RotWord + SubWord + Rcon result
logic [0:31] new_words [4];  // Generated words for this round

always_comb begin
  temp_word = '0;
  new_words = '{default: '0};

  if (state == EXPANDING && round_count <= 10) begin
    temp_word = {key_schedule[round_count*4 - 1][8:31], 
                key_schedule[round_count*4 - 1][0:7]};
    temp_word = {s_box[temp_word[0:7]], 
                s_box[temp_word[8:15]], 
                s_box[temp_word[16:23]], 
                s_box[temp_word[24:31]]};
    temp_word = temp_word ^ rcon[round_count-1];
    new_words[0] = key_schedule[(round_count-1)*4]   ^ temp_word;
    new_words[1] = key_schedule[(round_count-1)*4+1] ^ new_words[0];
    new_words[2] = key_schedule[(round_count-1)*4+2] ^ new_words[1];
    new_words[3] = key_schedule[(round_count-1)*4+3] ^ new_words[2];
  end
end

// --- Sequential Logic with `begin_enc` ---
always_ff @(posedge clk or negedge reset) begin
  if (!reset) begin
    state <= IDLE;
    round_count <= 0;
    key_exp_done <= 0;
    ready <= 0;
    begin_enc <= 0;  // Reset begin_enc
    for (int i = 0; i < 11; i++) key[i] <= 128'b0;
    for (int i = 0; i < 44; i++) key_schedule[i] <= 32'b0;
  end else begin
    begin_enc <= 0;  // Default to 0 (pulse for 1 cycle only)
    case (state)
      IDLE: begin
        if (start) begin
          key_schedule[0] <= in_key[0:31];
          key_schedule[1] <= in_key[32:63];
          key_schedule[2] <= in_key[64:95];
          key_schedule[3] <= in_key[96:127];
          key[0] <= in_key;
          round_count <= 1;
          state <= EXPANDING;
          begin_enc <= 1;  // Pulse high when first round starts
        end
      end

      EXPANDING: begin
        if (round_count <= 10) begin
          key_schedule[round_count*4]   <= new_words[0];
          key_schedule[round_count*4+1] <= new_words[1];
          key_schedule[round_count*4+2] <= new_words[2];
          key_schedule[round_count*4+3] <= new_words[3];
          key[round_count] <= {new_words[0], new_words[1], new_words[2], new_words[3]};
          round_count <= round_count + 1;
          if (round_count == 10) state <= DONE;
        end
      end

      DONE: begin
        ready <= 1;
      end
    endcase
  end
end

endmodule