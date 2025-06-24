INTRODUCTION

Cryptography is a powerful technique used to protect sensitive information by converting readable, plain information (plaintext) into an unreadable, encrypted form (ciphertext). This process utilizes advanced mathematical operations and cryptographic keys to enable only authorized people to decode and read the underlying data. Cryptography has been around for thousands of years, as evidenced by past examples such as the Caesar cipher, which Julius Caesar used to encrypt messages in the military by shifting letters within the alphabet. Cryptographic systems evolved from simple substitution ciphers to advanced systems over the years, such as the Enigma machine utilized during World War II, which started mechanical encryption before the beginning of the digital era.

Current cryptography today employs highly secure algorithms like AES (Advanced Encryption Standard) and RSA (Rivest-Shamir-Adleman) to protect digital communications, financial transactions, and personal data. These methods employ advanced mathematical concepts, including prime factorization and modular arithmetic, to create nearly unbreakable ciphers. As cyberattacks evolve, cryptography remains essential in ensuring privacy, authentication, and data integrity on the internet, from secure messaging apps to blockchain technology. The field keeps progressing, with the new frontier of unbreakable encryption being quantum cryptography.

End-to-end encryption begins when the sender encrypts a message using advanced cryptographic techniques, primarily relying on symmetric or asymmetric encryption. Symmetric encryption, being one of the oldest and fastest techniques, uses a single key for both decryption and encryption, so both the receiver and sender must share this key securely beforehand. Historically, the technique goes back to ancient ciphers like Caesar shift and the advanced Vigenère cipher, later refined into modern algorithms like AES (Advanced Encryption Standard). However, the issue of securely sending the common key without it being intercepted led to the development of asymmetric encryption, a breakthrough in 20th-century cryptography [1].

Asymmetric encryption was developed by Whitfield Diffie and Martin Hellman in 1976, revolutionized protected communication with a pair of mathematically linked keys: a public key for encrypting and a private key for decrypting. This rendered pre-shared keys redundant, enabling secure transfer through untrusted networks, a foundation for products like PGP (Pretty Good Privacy) and modern HTTPS protocols. While symmetric encryption remains useful for the protection of bulk data (e.g., files), asymmetric encryption is critical for key exchange and digital signatures. Together, these technologies are the basis of secure messaging applications, online banking, and blockchain technology today, ensuring privacy even against sophisticated cyberattacks [2].

In secure communications, the important pillars are confidentiality, integrity, and authentication.  These foundational pillars are merely important; they are the bedrock of trust and safety, ensuring that our digital interactions remain shielded from unauthorized access. Yet, traditional cryptographic systems often grapple with significant hindrances, encountering bottlenecks that can break down essential processes. Moreover, lurking within these systems are vulnerabilities that can jeopardize the very data they strive to protect, leaving it exposed to an array of potential threats.

The Advanced Encryption Standard (AES) is known for its rapid encryption capabilities, while the Diffie-Hellman (DH) protocol is recognized for facilitating secure key exchanges over insecure networks. By integrating these two technologies, we can create an effective hybrid model for encryption and decryption, combining the strengths of both methods to enhance overall optimization. The Advanced Encryption Standard, or AES, is a widely used symmetric key block cipher. It uses the same key for encryption, which converts plaintext into ciphertext. It uses the same key for decryption, which converts the ciphertext back into plaintext. Data Encryption Standard, or DES, which had been in use since the 1970s, was thought to be outdated, with a lower key size and hence more vulnerable to attacks. AES, on the other hand, provides key sizes of 128, 192, or 256 bits, offering a significantly higher level of security that is necessary to secure sensitive data for a variety of applications [3].
The Diffie-Hellman key exchange algorithm is a cryptographic protocol that allows two entities to agree on a shared secret key for secure communication, even via an insecure public channel. This revolutionary system uses mathematical ideas, specifically modular arithmetic, and exponentiation, to enable the secure exchange of cryptographic keys without prior secure encounters or shared secrets [4].
An FPGA (Field-Programmable Gate Array) is a programmable silicon chip that designers use to create custom digital logic circuits after manufacturing. Unlike CPUs or GPUs, which have fixed instruction sets, these contain array of configurable logic blocks (CLBs), programmable interconnects, and memory elements that can be tailored to implement any digital function. This flexibility makes FPGAs ideal for applications requiring parallelism, low-latency processing, and hardware-level customization, such as digital signal processing (DSP), image processing, cryptography, and high-speed data acquisition systems.
One of the key advantages of FPGAs is their support for fine-grained pipelining, which enables high-speed computation by breaking complex logic into stages separated by registers. This allows data to flow continuously through a circuit with minimal delay, maximizing throughput. FPGAs also support massive parallelism, where multiple pipelines or processing blocks can run concurrently without interfering with each other. Additional features such as clock domain crossing, real-time control, high-speed I/O interfaces, and support for fixed-point and floating-point arithmetic further enhance their suitability for time-critical applications like FIR filters, encryption engines, and AI accelerators
Implementing the AES-DH hybrid cryptographic end-to-end system on an FPGA is a smart choice because it gives both speed and security. FPGAs can run many operations at the same time, which means they can handle AES encryption and DH key exchange much faster than a regular processor. This is very useful in systems where you need to protect data quickly, like secure messaging or communication between devices. Also, unlike software that can be hacked or slowed down, FPGAs use dedicated hardware logic, making them harder to break into and more reliable for real-time encryption [5].


FPGA-BASED END-TO-END SECURE COMMUNICATION USING AES-DH HYBRID CRYPTOGRAPHY

Our project focuses on creating and executing encryption and decryption algorithms based on the Advanced Encryption Standard (AES) on a Field Programmable Gate Array (FPGA). The primary purpose of the implementation was to support secure data transfer between devices. By leveraging the advantages of FPGA architecture, the project greatly improved the speed and dependability of cryptographic operations.
Moreover, the Diffie-Hellman key exchange protocol was developed and carried out on the FPGA platform. This implementation facilitated the secure creation and sharing of symmetric keys. Alongside, implementing AES and DH combination of encryption and decryption on the FPGA. The primary parameters, such as throughput (the speed of successful message delivery), latency (the duration needed for data transmission from sender to receiver), and resource utilization (the effectiveness of FPGA resource usage), were looked after and optimized efficiently. Thus, resulting in a comprehensive end-to-end secure communication framework.

ADVANCED ENCRYPTION STANDARD

AES (Advanced Encryption Standard) is a highly secure symmetric block cipher that encrypts data in fixed 128-bit blocks using 128 keys. The algorithm's strength lies in its substitution-permutation network structure

AES Key Expansion:

Expands original key (128 bits) into 10 round keys.
Uses RotWord, SubWord, and Rcon for transformation.
Produces one round key per AES round (plus initial key).

AES Encryption:

Initial Round: XOR input block with initial round key.
Rounds (10): Apply SubBytes → ShiftRows → MixColumns → AddRoundKey.
Final Round: Same as above but without MixColumns.

 AES Decryption:
 
Initial Step: XOR ciphertext with final round key.
Rounds: Apply Inverse ShiftRows → Inverse SubBytes → AddRoundKey → Inverse MixColumns.
Final Round: Skip Inverse MixColumns.


![image](https://github.com/user-attachments/assets/abbff36a-dda2-44df-96b7-d26f0c31fb8e)


DIFFIE-HELLMAN KEY EXCHANGE

![image](https://github.com/user-attachments/assets/98a1d9f0-9f96-4d4d-96d0-0dacf3c6843f)


In a typical Diffie-Hellman key exchange, individuals agree on a large prime number and a base known as a generator. Each participant selects a private key that they keep confidential and uses it to calculate the public value through exponentiation. These public values are then openly exchanged between the participants. Upon receiving the public value from the other party, each one performs another exponentiation with their private key, eventually resulting in the same shared secret key. This key can then be utilized in symmetric encryption algorithms to ensure the confidentiality and integrity of their communications.
The elegance of the Diffie-Hellman approach is found in its capacity to securely create a shared secret without the necessity for the two participants to physically meet or exchange their private keys, thereby addressing major risks linked to key distribution in conventional communication methods. Consequently, it provides a strong solution for secure communication in an environment where eavesdropping and the interception of public channels are common.

STEP 1:
Consider two individuals Shiva and Parikshith, they select a prime number ‘p’ and base generator ‘g’. These values are meant to be public.

STEP 2:
Shiva picks a private key: a (Values: 1 < a < p-1)
Parikshith picks a private key: b (Values: 1 < b < p-1)
They compute public keys, which is given by:
Shiva: A = ga mod p
Parikshith: B = gb mod p

STEP 3:
After exchanging the public keys, Shiva computes the shared secret S = Ba mod p, and Parikshith computes shared secret S = Ab mod p. The shared secret key remains common for both participants due to modular arithmetic. Thus, symmetric key is generated for encrypting and decrypting the communication


Hybrid Model for End-to-End Communication

![image](https://github.com/user-attachments/assets/3aa28db1-c36b-43ac-9b26-f0c6d6f1e60a)


Figure 5 illustrates how asymmetric encryption enables secure end-to-end communication between two users, Shiva, and Parikshith. Shiva encrypts a thier message using Parikshith’s public key, ensuring that only Parikshith can decrypt it using his private key. Even if the message is intercepted during transmission, it remains unreadable to others, as only the corresponding private key can unlock it. This method ensures confidentiality, authenticity, and data protection, making it ideal for secure digital communication.
Taking an example of WhatsApp, it utilizes the Signal Protocol for end-to-end encryption, which employs Curve25519 for key exchange, AES-256 for symmetric encryption, and HMAC-SHA256 for message authentication. The Signal Protocol also incorporates the Double Ratchet Algorithm and X3DH (Extended Triple Diffie-Hellman) handshake to ensure strong security. Similarly, WhatsApp, this project uses AES-128 for symmetric and Diffie-Hellman for Key Exchange. This implies the key generated initially is generated from the Diffie-Hellman key exchange protocol, and the AES Key generation algorithm uses this key to generate 10 separate round keys for encryption and decryption of ciphertext.
3.4 FPGA (Field Programmable Gate Array)
It is an integrated circuit that can be programmed and reconfigured based on user expectations after fabrication. The major advantage of using an FPGA is the capability to parallelize processes for logical operations, unlike regular sequential processes in a CPU.


METHODOLOGY AND WORKING

![image](https://github.com/user-attachments/assets/557f94fc-6009-4de1-9106-44a10e2d2e14)

 
Shiva to Parikshith Communication Line
Figure shows the one-way communication step between Users Shiva and Parikshith. In this diagram, as data is sent from Shiva to Parikshith, Encryption takes place in Shiva’s block, and Decryption in Parikshith’s block. Each user’s block contains a Diffie-Hellman Module, an Encryption module, a Decryption module, and a key generation module.
The initial stage (1) starts with the User’s DH blocks containing their unique private key and the same prime number p and g. Using the mod function, the initial public keys are generated and exchanged between the two users. As Shiva attains Parikshith’s public key and vice versa, using the same mod function, Shiva uses the exchanged public key to generate a symmetric key, and Parikshith also performs the same. The resulting public keys are the same, which can be generated into the same 10-round keys by the AES key generation block as shown in step (2). The data/plaintext to be sent from Shiva is now encrypted (3) using the round keys, and the ciphertext is now transferred to Parikshith (4). In the end, this data is finally decrypted (5) by the decryption module using the same round keys, and the plaintext is obtained. 
The exchanged data between the 2 users is the public keys and the encrypted key. If one gets hold of this data, public keys cannot be used to crack the ciphertext unless the value of the Prime number p and g from the Diffie-Hellman modules are known. This way, the data can be exchanged securely between users.

![image](https://github.com/user-attachments/assets/cc935cac-3ee6-4851-83ae-441ac9f7e323)

 
Parikshith to Shiva Communication Line
Figure explains the end-to-end communication between Shiva and Parikshith, where reverse communication takes place. Parikshith sends the data to Shiva, where initially the public keys are exchanged, and the symmetric keys are generated for the respective DH blocks, and the round keys are generated, which allows Parikshith to encrypt the data and Shiva to decrypt the message.



SIMULATION RESULTS 
The widely accepted tools and techniques for developing the operational model of this project consist of:

•	Design Software: Utilized AMD Xilinx Vivado for the design, synthesis, and implementation of FPGA/ASIC.
•	Verification Tools: Utilized Synopsys Virtuoso SV and UVM for enhanced validation.
•	Languages: Utilized System Verilog for RTL design and UVM for developing the testbench.
•	Methodologies: Adopted the UVM framework to create organized and reusable testing environments.
•	Process: Comprehensive design (Vivado) and testing (Virtuoso/UVM) for complete validation.
•	FPGA Development Board: Nexus A-100T

The tools utilized for the design, verification, and hardware simulation of the Hybrid Model are depicted in Figure 9.


The Simulation results of the Design Model are shown below:

After the design model was completed, we performed testing of the model with the following text message.

Starting Test
Original Message: HelloDiffie12345
Message as 128-bit: 48656c6c6f4469666669653132333435

We tried the text message as “HelloDiffie12345” which got converted into hexadecimal and is formatted to 128-bit length as shown above.

Waiting for key exchange to complete...

[1385.00 ns] Public Keys Generated:
User A's public key: b9df3fe51ca2d4731df01f9e4866c0cd
User B’s public key: ecc9312947fe7343815160e85e1dbabd

While the key expansion is performed backend, the model generates the public keys for both users. These public keys are 128-bit long and are unique for each user.

KEYS EXCHANGED
Shared Secret A: 84ea4189a9406fa0e0eabe3826098c95
Shared Secret B: 84ea4189a9406fa0e0eabe3826098c95

The last phase of the Diffie-Hellman method involves creating the shared key. This key is identical for both parties and is fed into the AES cryptography's key expansion model to produce the round keys, which are crucial for both encryption and decryption.

AES KEYS GENERATED:
Key[0]: 84ea4189a9406fa0e0eabe3826098c95
Key[1]: 848e6b7e2dce04decd24bae6eb2d3673
Key[2]: 5e8be4977345e049be615aaf554c6cdc
Key[3]: 73db626b009e8222beffd88debb3b451
Key[4]: 1656b38216c831a0a837e92d43845d7c
Key[5]: 591aa3984fd29238e7e57b15a4612669
Key[6]: 96ed5ad1d93fc8e93edab3fc9abb9595
Key[7]: 3cc77069e5f8b880db220b7c41999ee9
Key[8]: 52cc6eeab734d66a6c16dd162d8f43ff
Key[9]: 3ad678328de2ae58e1f4734ecc7b30b1
Key[10]: 2dd2b079a0301e2141c46d6f8dbf5dde

These keys are used for each round in encryption to convert the plaintext to ciphertext. Similar keys are used in reverse fashion while decrypting to get back the original message.

ENCRYPTION COMPLETE
Encrypted Data: 61f49091c51b7e21ebfe2b159392dc39
Char 0: 48 'H'
Char 1: 65 'e'
Char 2: 6c 'l'
Char 3: 6c 'l'
Char 4: 6f 'o'
Char 5: 44 'D'
Char 6: 69 'i'
Char 7: 66 'f'
Char 8: 66 'f'
Char 9: 69 'i'
Char 10: 65 'e'
Char 11: 31 '1'
Char 12: 32 '2'
Char 13: 33 '3'
Char 14: 34 '4'
Char 15: 35 '5'

This describes the conversion of the message “HelloDiffie12345” into the respective ciphertext, indicating the encryption model worked successfully.

DECRYPTION COMPLETE
Decrypted Data: 48656c6c6f4469666669653132333435
Original Message: HelloDiffie12345
Decrypted Message: HelloDiffie12345

The result is to receive the original message. Thus, with the help of the decryption model, we successfully got the original message and proved that the design model is working as required.

TEST PASSED: Exact 128-bit match!
String content verified!

Performance Metrics:
Total simulation time: 2905 ns
Total clock cycles: 280

The parameter depicts the clock utilization for a complete 1 round of end-to-end communications. 

WAVEFORMS

![image](https://github.com/user-attachments/assets/6bd1c1d4-d9d2-4cf8-8380-3309408fd6f4)

![image](https://github.com/user-attachments/assets/2854ea5f-3d16-4ab1-898c-9b3130fc7b24)

![image](https://github.com/user-attachments/assets/11cb2353-23c1-48e2-8f95-3e6bcc86c9f5)

![image](https://github.com/user-attachments/assets/3a99585a-1606-4d8a-8cf3-a05c9c694fbd)


 

Figure 10. Simulation Waveforms for Hybrid Model
From Figure, we see the complete waveform generation of Public Keys, Symmetric Keys, Ready and Done signals for each module, Encryption, Key Generation, and Decryption Modules.
Initially, most amount the clock cycles after RESET are consumed by the DH model generating the public keys and symmetric keys over 256 clock cycles. The next 21 clock cycles are used by the AES model to encrypt and decrypt the data. Overall, under 280 clock cycles, the entire operation is completed.

 

Simulation Waveform for AES Pipelined Model
Figures show how the waveforms generated are pipelined to perform the Key generation operation and Encryption in 11 clock cycles. In Figure 10, we see the initial 11 cycles used to generate the ciphertext and the next 10 cycles used to decrypt the ciphertext back to plain text. Therefore, in 21 clock cycles, the AES cycle is completed. Figure 12 shows the total resource utilization after synthesis on VIVADO.

CONCLUSION

Modern-day security systems are no longer secure with a single cryptographic algorithm due to increasingly sophisticated attack techniques and other threats. Single-layer cryptographic algorithms that rely solely on symmetric or asymmetric algorithms are exposed to vulnerabilities such as side attacks or key exposure. This is where hybrid cryptographic systems like AES-DH are needed. AES (Advanced Encryption Standard) provides fast and efficient symmetric encryption for bulk data, while Diffie-Hellman (DH) enables secure asymmetric key exchange, ensuring the AES key is shared safely over public networks. Together, they deliver a robust, end-to-end encryption system that is efficient, scalable, and secure. 

Implementing the AES-DH hybrid cryptography on an FPGA offers significant advantages for real-time, end-to-end encryption. FPGAs provide high throughput, low latency, parallel, and pipelining processing capabilities, making them ideal for managing AES encryption and DH key exchange. Unlike software implementations, FPGA-based solutions can be customized to optimize power, speed, and resource utilization, ensuring secure encryption even in constrained environments. Moreover, compared to software, hardware-based implementations are more resistant to side-channel attacks, such as timing and power analysis, further improving the security and reliability of the AES-DH hybrid in modern end-to-end encrypted communication.

Software-based cryptographic systems often face security vulnerabilities and inconsistent performance. This project overcomes these issues by implementing a hybrid cryptographic system using AES for rapid data encryption and Diffie-Hellman (DH) for secure key exchange.

Deploying the AES-DH hybrid approach on FPGA hardware enhances overall performance, scalability, security, and power efficiency. This makes the FPGA-based solution particularly well-suited for secure end-to-end encrypted communications and other sensitive real-time applications
