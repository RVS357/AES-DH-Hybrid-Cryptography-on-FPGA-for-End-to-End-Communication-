module diffie_hellman_top #(
    parameter WIDTH = 127    
) (
    input  logic clk,
    input  logic rst_n,
    input  logic data_signal_a,
    input  logic [WIDTH:0] data_a,
    output logic key_exchange_complete,
    output logic [WIDTH:0] shared_secret_a,
    output logic [WIDTH:0] shared_secret_b,
    output logic [WIDTH:0] key [0:10],
    output logic key_done,
    output logic [WIDTH:0] Enc_data,
    output logic enc_done,
    output logic begin_enc,
    output logic [WIDTH:0] Processed_data,
    output logic Dec_done
);

    // Internal connections
    logic [WIDTH:0] public_key_a;
    logic [WIDTH:0] public_key_b;
    logic public_key_done_a;
    logic public_key_done_b;
    logic symmetric_key_done_a;
    logic symmetric_key_done_b;

    // Instantiate User A
    diffie_hellman_user1 #(.WIDTH(WIDTH)) user_a (
        .clk(clk),
        .rst_n(rst_n),
        .public_key_a(public_key_a),
        .symmetric_key(shared_secret_a),
        .public_key_done(public_key_done_a),
        .symmetric_key_done(symmetric_key_done_a),
        .public_key_b(public_key_b)
    );

    // Instantiate User B
    diffie_hellman_user2 #(.WIDTH(WIDTH)) user_b (
        .clk(clk),
        .rst_n(rst_n),
        .public_key_b(public_key_b),
        .symmetric_key(shared_secret_b),
        .public_key_done(public_key_done_b),
        .symmetric_key_done(symmetric_key_done_b),
        .public_key_a(public_key_a)
    );
    
    // AES key generation from shared secret
    aes_key_gen keys (
        .clk(clk),
        .reset(rst_n),                  // Note: Active high reset
        .start(symmetric_key_done_a),     // Start when User A's DH completes
        .in_key(shared_secret_a),         // Using User A's shared secret
        .key(key),
        .begin_enc(begin_enc),
        .ready(key_done)
    );
    
    Decryption Dec (
        .clk(clk),
        .reset(rst_n),
        .enc_done(enc_done),
        .key(key),
        .Processed_data(Processed_data),
        .Enc_data(Enc_data),
        .done(Dec_done)
     );
    
    Encryption enc (
        .clk(clk),
        .reset(rst_n),
        .valid(data_signal_a),
        .key(key),
        .done(enc_done),
        .in_data(data_a),
        .Enc_data(Enc_data),
        .begin_enc(begin_enc)
     );
     

    // Key exchange completion indicator
    assign key_exchange_complete = symmetric_key_done_a & symmetric_key_done_b;

    // Verification logic (optional)
  //  always @(posedge clk) begin
  //      if (key_exchange_complete && (shared_secret_a != shared_secret_b)) begin
            // This should never happen if DH implementation is correct
  //          $display("Warning: Shared secrets don't match!");
  //      end
 //   end
endmodule