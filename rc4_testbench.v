`timescale 1ns / 1ps

module rc4_testbench;

reg clk;
reg reset;
reg [7:0] key;
reg [7:0] plaintext;
wire [7:0] ciphertext;
wire [7:0] decrypted_text;

// Instantiate the encryption and decryption modules
rc4_Encryption encrypt(
	.clk(clk),
	.reset(reset),
	.key(key),
	.plaintext(plaintext),
	.ciphertext(ciphertext)
);

rc4_Decryption decrypt(
	.clk(clk),
	.reset(reset),
	.key(key),
	.ciphertext(ciphertext),
	.decrypted_text(decrypted_text)
);

// Clock generation
always #10 clk = ~clk;

// Test sequence
initial begin
	// Initialize
	clk = 0;
	reset = 1;
	key = 8'h00;     	// Default key
	plaintext = 8'h00;   // Default plaintext

	// Apply reset
	#20;
	reset = 0;
	#40;
	reset = 1;
	#20;

	// Test Case 1
	key = 8'h1A;     	// Example key
	plaintext = 8'h2B;   // Example plaintext
	#40;

	// Test Case 2
	key = 8'h3C;     	// Another example key
	plaintext = 8'h4D;   // Another example plaintext
	#40;

	// Additional Test Cases
	key = 8'h5E;
	plaintext = 8'h6F;
	#40;

   
	// More test cases can be added here

	// Finish the simulation
	#100;
	$finish;
end

endmodule
