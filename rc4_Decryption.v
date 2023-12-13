`timescale 1ns / 1ps

module Decryption(
	input clk,
	input reset,
	input [7:0] key,      	// 8-bit key for simplicity
	input [7:0] ciphertext,   // 8-bit ciphertext
	output reg [7:0] decrypted_text
);

// Internal variables
reg [7:0] S [0:255];  // The permutation array
integer i, j;
reg init_done;  // Flag to indicate if initialization is done

// Initialization
always @(posedge reset) begin
	i = 0; j = 0;
	// Initial permutation of S
	for (i = 0; i < 256; i = i + 1) begin
    	S[i] = i;
	end

	j = 0;
	for (i = 0; i < 256; i = i + 1) begin
    	j = (j + S[i] + key[i % 8]) % 256;
    	// Swap S[i] and S[j]
    	{S[i], S[j]} = {S[j], S[i]};
	end
end

// Keystream generation and decryption
always @(posedge clk) begin
	i = (i + 1) % 256;
	j = (j + S[i]) % 256;
    
	// Swap S[i] and S[j]
	{S[i], S[j]} = {S[j], S[i]};

	// Generate keystream byte and decrypt
	decrypted_text = ciphertext ^ S[(S[i] + S[j]) % 256];
end

endmodule
