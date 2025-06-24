module diffie_hellman_user2 #(
    parameter WIDTH = 127
) (
    input  logic         clk,
    input  logic         rst_n,
    output logic [WIDTH:0] public_key_b,    // This user's public key (outgoing)
    output logic [WIDTH:0] symmetric_key,   // Computed shared secret
    output logic         public_key_done,    // Public key ready flag
    output logic         symmetric_key_done, // Shared secret ready flag
    input  logic [WIDTH:0] public_key_a     // Other user's public key (incoming)
);

    // Constants
    localparam [WIDTH:0] PRIME_P = 128'hFFFFFFFF_FFFFFFFF_FFFFFFFF_FFFFFDDD;
    localparam [WIDTH:0] BASE_G  = 128'h00000000_00000000_00000000_00000005;
    localparam [WIDTH:0] PRIV_KEY = 128'h33112211223311223322112233112233;

    // Unified state machine
    typedef enum {
        IDLE,
        COMPUTE_PUBLIC_KEY,
        WAIT_FOR_PEER_KEY,
        COMPUTE_SYMMETRIC_KEY,
        DONE
    } state_t;
    
    state_t current_state;

    // Shared computation registers
    logic [WIDTH:0] mod_result;
    logic [WIDTH:0] mod_base;
    logic [WIDTH:0] mod_exp;
    logic [6:0] bit_counter;
    logic public_key_computed;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            current_state <= IDLE;
            public_key_b <= 0;
            symmetric_key <= 0;
            public_key_done <= 0;
            symmetric_key_done <= 0;
            public_key_computed <= 0;
        end else begin
            // Default assignments
            public_key_done <= 0;
            symmetric_key_done <= 0;

            case (current_state)
                IDLE: begin
                    // Initialize public key computation
                    mod_result <= 1;
                    mod_base <= BASE_G;
                    mod_exp <= PRIV_KEY;
                    bit_counter <= 0;
                    current_state <= COMPUTE_PUBLIC_KEY;
                end

                COMPUTE_PUBLIC_KEY: begin
                    // Compute g^priv_key mod p
                    if (mod_exp[0]) 
                        mod_result <= mod_mult(mod_result, mod_base, PRIME_P);
                    
                    mod_base <= mod_mult(mod_base, mod_base, PRIME_P);
                    mod_exp <= mod_exp >> 1;
                    
                    if (bit_counter == WIDTH) begin
                        // Public key computation complete
                        public_key_b <= mod_result;
                        public_key_done <= 1;
                        public_key_computed <= 1;
                        
                        // Check if peer's key is already available
                        if (public_key_a != 0) begin
                            // Start symmetric key computation immediately
                            mod_result <= 1;
                            mod_base <= public_key_a;  // peer's public key
                            mod_exp <= PRIV_KEY;       // our private key
                            bit_counter <= 0;
                            current_state <= COMPUTE_SYMMETRIC_KEY;
                        end else begin
                            current_state <= WAIT_FOR_PEER_KEY;
                        end
                    end else begin
                        bit_counter <= bit_counter + 1;
                    end
                end

                WAIT_FOR_PEER_KEY: begin
                    // Wait until we receive the peer's public key
                    if (public_key_a != 0) begin
                        mod_result <= 1;
                        mod_base <= public_key_a;
                        mod_exp <= PRIV_KEY;
                        bit_counter <= 0;
                        current_state <= COMPUTE_SYMMETRIC_KEY;
                    end
                end

                COMPUTE_SYMMETRIC_KEY: begin
                    // Compute peer_pub_key^priv_key mod p
                    if (mod_exp[0]) 
                        mod_result <= mod_mult(mod_result, mod_base, PRIME_P);
                    
                    mod_base <= mod_mult(mod_base, mod_base, PRIME_P);
                    mod_exp <= mod_exp >> 1;
                    
                    if (bit_counter == WIDTH) begin
                        // Symmetric key computation complete
                        symmetric_key <= mod_result;
                        symmetric_key_done <= 1;
                        current_state <= DONE;
                    end else begin
                        bit_counter <= bit_counter + 1;
                    end
                end

                DONE: begin

                end
            endcase
        end
    end

    // Optimized modular multiplication with partial reduction
    function automatic [WIDTH:0] mod_mult(
        input [WIDTH:0] a,
        input [WIDTH:0] b,
        input [WIDTH:0] p
    );
        reg [WIDTH:0] result = 0;
        begin
            for (int i = 0; i <= WIDTH; i++) begin
                // Multiply-accumulate with partial reduction
                if (b[i]) 
                    result = (result + (a << i)) % p;
                else if (i % 8 == 0) 
                    result = result % p;  // Periodic reduction to limit growth
            end
            return result;
        end
    endfunction

endmodule