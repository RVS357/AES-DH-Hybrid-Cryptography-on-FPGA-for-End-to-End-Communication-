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
1.	LITERATURE SURVEY
Recent advancements in digital security have shown the importance of implementing encryption algorithms in hardware to achieve both speed and resistance to software-based attacks. The Advanced Encryption Standard (AES) remains one of the most widely used symmetric encryption algorithms due to its efficiency, security, and support for 128/192/256-bit keys. Literature such as the works by Kumar et al. (2021), Jain et al. (2019), and Khalaf et al. (2020) highlights techniques for optimizing AES on FPGAs, including pipelined and parallel architectures that achieve high throughput with minimal area [6][7][8]. These studies emphasize the use of fixed-point arithmetic, controlled resource allocation, and modular designs to meet timing and area constraints. In this project, these insights informed the development of a fully pipelined AES encryption and decryption engine operating at 512 MHz, using a 128-bit key and designed to comply with strict constraints like limited adders and deterministic output timing [9].
While AES ensures fast and secure data encryption, it relies on the pre-sharing of symmetric keys. To solve this, Diffie-Hellman (DH) key exchange is widely used for establishing symmetric keys over insecure channels. Research such as Sun et al. (2022) and Moses et al. (2016) explores hardware-based DH protocols for secure real-time communication, especially in low-power or embedded environments [10][11]. These works show how modular exponentiation and authenticated handshaking protocols can be implemented securely in hardware, preventing attacks like man-in-the-middle (MITM). Inspired by these, this design includes a dedicated DH module that performs 128-bit modular exponentiation entirely in RTL, using a pipelined and time-multiplexed accumulator structure. This DH block computes public keys and shared secrets autonomously, enabling dynamic key generation between two devices without relying on external processors or memory [12].
The combination of AES and DH forms a hybrid encryption scheme, where DH is used to generate a symmetric key and AES uses that key for fast, secure data encryption. Literature such as D’Souza & Panchal (2017) emphasizes this hybrid approach as a means of combining the scalability and security of public-key cryptography with the speed of symmetric encryption [13][14]. This project implements this concept fully in hardware, achieving end-to-end (E2E) secure communication without relying on software. Once the DH key exchange completes, the derived symmetric key is directly fed into the AES core, ensuring that the encryption process starts immediately, with minimal latency and no software-involved key handoff, a critical feature for real-time systems [15].
The choice of FPGA as the implementation platform is supported by extensive literature, including Botta et al. (2013), which compares hardware and software encryption methods. FPGAs provide benefits such as parallelism, fine-grained pipelining, reconfigurability, and constant-time execution all of which are crucial for cryptographic tasks. This Model leverages these strengths by using custom datapaths, linearly pipelined MAC units, and shift registers to build a high-speed, deterministic crypto engine that is resistant to side-channel attacks and capable of sustaining secure communication under tight timing constraints [16][17][18].
In summary, the referenced literature provided essential design strategies and architectural insights that shaped the core of the AES-DH hybrid system. The project integrates secure key negotiation and symmetric encryption into a single hardware flow, ensuring real-time, low-latency operation. By aligning closely with the best practices in FPGA cryptographic design, this solution successfully delivers a scalable and secure end-to-end communication system, meeting both performance and security goals for embedded and real-time applications [19].

2.	FPGA-BASED END-TO-END SECURE COMMUNICATION USING AES-DH HYBRID CRYPTOGRAPHY
Our project focuses on creating and executing encryption and decryption algorithms based on the Advanced Encryption Standard (AES) on a Field Programmable Gate Array (FPGA). The primary purpose of the implementation was to support secure data transfer between devices. By leveraging the advantages of FPGA architecture, the project greatly improved the speed and dependability of cryptographic operations.
Moreover, the Diffie-Hellman key exchange protocol was developed and carried out on the FPGA platform. This implementation facilitated the secure creation and sharing of symmetric keys. Alongside, implementing AES and DH combination of encryption and decryption on the FPGA. The primary parameters, such as throughput (the speed of successful message delivery), latency (the duration needed for data transmission from sender to receiver), and resource utilization (the effectiveness of FPGA resource usage), were looked after and optimized efficiently. Thus, resulting in a comprehensive end-to-end secure communication framework.
3.1 ADVANCED ENCRYPTION STANDARD
AES (Advanced Encryption Standard) is a highly secure symmetric block cipher that encrypts data in fixed 128-bit blocks using 128 keys. The algorithm's strength lies in its substitution-permutation network structure

3.1.1 WORKING OF AES KEY GENERATION
The process to generate a key for each round is directly proportional to the bits in the message information. That is:
10 rounds for a 128-bit key
12 rounds for a 192-bit key
14 rounds for a 256-bit  key
The encrypted message is segmented into blocks of 16 bytes. A shared secret key, which can be 128, 192, or 256 bits long, is utilized by both the sender and the receiver. The original key undergoes expansion to generate a series of new keys known as round keys. In our project, we opted for a key length of 128 bits, resulting in the use of 11 keys.
 
Figure 1. Key Expansion for Generating Words
The key expansion for AES-128 involves an original 128-bit cipher key (16 bytes) used as the first-round key, called key 0. From Figure 1, each k represents 1 byte of data or 2 hexadecimal characters as described below.

Taking the Cypher key as 72 61 74 69 73 68 63 6A 69 73 62 6F 72 69 6E 67

The K values are expressed as 

72	73	69	72
61	68	73	69
74	63	62	6e
69	6a	6f	67
W0	W1	W2	W3

W implies Word, which refers to a group of 32 bits (4 bytes). We have 4 words W0-W3 from the table, which are used in Round 0. Round 1 requires words W4-W7, which are calculated as follows.

W[4]=W[0]⊕SubWord(RotWord(W[3]))⊕Rcon[1] 
or in simple formula W[4]=W[0]⊕g(W[3])

The equation is completed in three major steps.

Step 1: 1 round shift

W3	RotWord (X1)
72	69
69	6e
6e	67
67	72

Step 2: In this operation, the subword performs a byte substitution on each byte of its input word using the S-Box 
Rotword (X1)	Subword (Y1)
69	f9
6e	9f
67	85
72	40

Step 3: The result Y1 is XORed with a round constant, Rcon[j] shown below in Table 1. 
Table 1 shows the Rcon[j] constant value table used in the key expansion process, specifically during the generation of round keys for the AES algorithm.

Table 1. Rcon[j] Constants table.
R1	R2	R3	R4	R5	R6	R7	R8	R9	R10
01	02	04	08	10	20	40	80	1B	36
00	00	00	00	00	00	00	00	00	00
00	00	00	00	00	00	00	00	00	00
00	00	00	00	00	00	00	00	00	00
W[4]=W[0]⊕g(W[3])

Y1	11	11	10	01	10	01	11	11	10	00	01	01	01	00	00	00
R1	00	00	00	01	00	00	00	00	00	00	00	00	00	00	00	00
g(W3)	11	11	10	00	10	01	11	11	11	00	00	10	10	10	00	00
W0	01	11	00	11	01	10	00	01	01	11	01	00	01	10	10	01
G(W3)	11	11	10	00	10	01	11	11	11	00	00	10	10	10	00	00
RES:	10	00	10	11	11	11	11	10	11	11	00	01	00	10	10	01

Result W4: 8b fe f1 29

Similarly, all other words W4-W43 are calculated. W[0-3] forms Round Key 1, W[4-7] forms Round Key 2, W[36-39] forms Round Key 9 and finally W[40-43] forms Round Key 10.

Table 2 shows the AES S-Box (Substitution Box), a crucial component that provides non-linearity to the cipher, making it resistant to cryptanalysis. 

Table 2. AES S-BOX Table
63	7C	77	7B	F2	6B	6F	C5	30	01	67	2B	FE	D7	AB	76
CA	82	C9	7D	FA	59	47	F0	AD	D4	A2	AF	9C	A4	72	C0
B7	FD	93	26	36	3F	F7	CC	34	A5	E5	F1	71	D8	31	15
04	C7	23	C3	18	96	05	9A	07	12	80	E2	EB	27	B2	75
09	83	2C	1A	1B	6E	5A	A0	52	3B	D6	B3	29	E3	2F	84
53	D1	00	ED	20	FC	B1	5B	6A	CB	BE	39	4A	4C	58	CF
D0	EF	AA	FB	43	4D	33	85	45	F9	02	7F	50	3C	9F	A8
51	A3	40	8F	92	9D	38	F5	BC	B6	DA	21	10	FF	F3	D2
CD	0C	13	EC	5F	97	44	17	C4	A7	7E	3D	64	5D	19	73
60	81	4F	DC	22	2A	90	88	46	EE	B8	14	DE	5E	0B	DB
E0	32	3A	0A	49	06	24	5C	C2	D3	AC	62	91	95	E4	79
E7	C8	37	6D	8D	D5	4E	A9	6C	56	F4	EA	65	7A	AE	08
BA	78	25	2E	1C	A6	B4	C6	E8	DD	74	1F	4B	BD	8B	8A
70	3E	B5	66	48	03	F6	0E	61	35	57	B9	86	C1	1D	9E
E1	F8	98	11	69	D9	8E	94	9B	1E	87	E9	CE	55	28	DF
8C	A1	89	0D	BF	E6	42	68	41	99	2D	0F	B0	54	BB	16

3.1.2 WORKING OF AES ENCRYPTION

The AES Encryption process can be broken down into multiple processes. As the input length is 128 bits, 10 rounds are performed to convert to ciphertext. Through the key expansion process, we generate 10 round keys that are required for each round in encryption.
 
Figure 2. AES Encryption for all rounds.
Figure 2 shows the AES-128 encryption uses a 128-bit key expanded into 11 round keys to perform 10 rounds of transformations, including SubBytes, ShiftRows, MixColumns, and AddRoundKey, ensuring strong security through confusion and diffusion. The final round skips MixColumns to maintain reversibility for decryption.

The encryption process begins with arranging the plaintext into a 4*4 matrix of bytes called the state matrix.
d4    	e0	b8	1e
27	bf	b4	41
11	98	5d	52
ae	f1	e5	30
STATE  =







Once the input data is converted into matrix form, the main steps that are involved in encryption are started. The following are the methods involved in encrypting the plaintext:
XORing the plaintext block with the initial round key. 

STEP 1: Sub Byte
Each byte is strategically substituted using the S-box from Table 2, which is a predefined 16*16 lookup table (Mentioned above). This element introduces essential non-linearity to the cipher. The resultant form is given by
STATE[i,j] = S-box(STATE[i,j])
STEP 2: Shift Row
Each row of the 4*4-byte matrix is carefully rotated left by a designated number of bytes depending on the row position. This organized approach helps to scramble the rows and distribute the data effectively. The following pattern depicts how the left shift happens for each row.
 
Before ShiftRows                                         After ShiftRows
87	f2	4d	97
6e	4c	90	ec
46	e7	4a	c3
a6	8c	d8	95

87	f2	4d	97
ec	6e	4c	90
4a	c3	46	e7
8c	d8	95	a6


STEP 3: Mix Column
Each column is then transformed through mathematical operations; the state matrix is multiplied by a finite field known as Galois Field (28). This process effectively rearranges the bytes within each column. 




02	03	01	01
01	02	03	01
01	01	02	03
03	01	01	02

87	f2	4d	97
6e	4c	90	ec
46	e7	4a	c3
a6	8c	d8	95



 






The resultant matrix after performing the GF function is given as:

47	40	a3	4c
37	d4	70	9f
94	e4	3a	42
ed	a5	a6	bc









STEP 4: Add Round Key
The resulting matrix is then XORed with the round-specific key generated from key expansion to enhance security. The equation for this function is given by:

STATE = STATE XOR Round Key[round number]
ac	19	28	57
77	fa	d1	5c
66	dc	29	00
f3	21	41	6a



47	40	a3	4c
37	d4	70	9f
94	e4	3a	42
ed	a5	a6	bc


 




The resultant matrix is given below:

eb	59	8b	1b
40	2e	a1	c3
f2	38	13	42
1e	84	e7	d6

These four steps are repeated for each intermediate round, depending on the length of the input data. Except for the last round, there are only 3 rounds involved, such as SubBytes, ShiftRows, and AddRoundKeys. Since we are using a 128-bit length, 10 rounds are required, and thus 10 keys are generated for each round, respectively.

3.1.3 WORKING OF DECRYPTION (REVERSE OF AES ENCRYPTION)

Table 3. AES Inverse S-BOX Table
52	09	6A	D5	30	36	A5	38	BF	40	A3	9E	81	F3	D7	FB
7C	E3	39	82	9B	2F	FF	87	34	8E	43	44	C4	DE	E9	CB
54	7B	94	32	A6	C2	23	3D	EE	4C	95	0B	42	FA	C3	4E
08	2E	A1	66	28	D9	24	B2	76	5B	A2	49	6D	8B	D1	25
72	F8	F6	64	86	68	98	16	D4	A4	5C	CC	5D	65	B6	92
6C	70	48	50	FD	ED	B9	DA	5E	15	46	57	A7	8D	9D	84
90	D8	AB	00	8C	BC	D3	0A	F7	E4	58	05	B8	B3	45	06
D0	2C	1E	8F	CA	3F	0F	02	C1	AF	BD	03	01	13	8A	6B
3A	91	11	41	4F	67	DC	EA	97	F2	CF	CE	F0	B4	E6	73
96	AC	74	22	E7	AD	35	85	E2	F9	37	E8	1C	75	DF	6E
47	F1	1A	71	1D	29	C5	89	6F	B7	62	0E	AA	18	BE	1B
FC	56	3E	4B	C6	D2	79	20	9A	DB	C0	FE	78	CD	5A	F4
1F	DD	A8	33	88	07	C7	31	B1	12	10	59	27	80	EC	5F
60	51	7F	A9	19	B5	4A	0D	2D	E5	7A	9F	93	C9	9C	EF
A0	E0	3B	4D	AE	2A	F5	B0	C8	EB	BB	3C	83	53	99	61
17	2B	04	7E	BA	77	D6	26	E1	69	14	63	55	21	0C	7D

Decryption is the process of obtaining the original message from the ciphertext using the reverse encryption process and inverse mathematical operations, since the symmetric key concept uses a similar key for decoding the ciphertext.
 
Figure 3. AES Decryption for all rounds.
The initial method is arranging the ciphertext into a 4*4 state matrix and is represented as:

eb	59	8b	1b
40	2e	a1	c3
f2	38	13	42
1e	84	e7	d6

STATE= 






STEP 1: Add Round Key
The first step is to XOR the ciphertext with the last round key. This is the reverse procedure from encryption.
eb	59	8b	1b		ac	19	28	57
40	2e	a1	c3	⊕	77	fa	d1	5c
f2	38	13	42		66	dc	29	00
1e	84	e7	d6		f3	21	41	6a





          



The resultant matrix is given below:

47	40	a3	4c
37	d4	70	9f
94	e4	3a	42
ed	a5	a6	bc









STEP 2: Inverse Mix Columns
Each column is then transformed through inverse mathematical operations, and the state matrix is multiplied by a finite field known as Galois Field (28). This process effectively rearranges the bytes within each column.

47	40	a3	4c		0e	0b	0d	09
37	d4	70	9f                           	X	09	0e	0b	0d
94	e4	3a	42		0d	09	0e	0b
ed	a5	a6	bc		0b	0d	09	0e
   








The resultant matrix after performing the GF function is given as:

87	f2	4d	97
6e	4c	90	ec
46	e7	4a	c3
a6	8c	d8	95










STEP 3: Inverse Shift Rows
Each row is shifted to the right depending on the position of the row. This is the inverse operation of what happened in encryption. The following pattern is followed on each row:


Before ShiftRows                                      After ShiftRows
87	f2	4d	97
ec	6e	4c	90
4a	c3	46	e7
8c	d8	95	a6

87	f2	4d	97
6e	4c	90	ec
46	e7	4a	c3
a6	8c	d8	95


STEP 4: Inverse Sub Bytes
Each byte is strategically substituted using an AES Inverse S-box from Table 3, which is a predefined 16*16 lookup table (Mentioned above). This element introduces essential non-linearity to the cipher. The resultant form is given by

STATE[i,j] = Inverse S-box(STATE[i,j])

These four steps are repeated for each intermediate round, depending on the length of the input data. Except for the last round, there are only 3 rounds involved, such as Inverse SubBytes, Inverse ShiftRows, and AddRoundKeys. Since we are using a 128-bit length, 10 rounds are required, and thus 10 keys are generated for each round, respectively. After which, we obtain the original message back.

3.2 DIFFIE-HELLMAN KEY EXCHANGE
In a typical Diffie-Hellman key exchange, individuals agree on a large prime number and a base known as a generator. Each participant selects a private key that they keep confidential and uses it to calculate the public value through exponentiation. These public values are then openly exchanged between the participants. Upon receiving the public value from the other party, each one performs another exponentiation with their private key, eventually resulting in the same shared secret key. This key can then be utilized in symmetric encryption algorithms to ensure the confidentiality and integrity of their communications.
The elegance of the Diffie-Hellman approach is found in its capacity to securely create a shared secret without the necessity for the two participants to physically meet or exchange their private keys, thereby addressing major risks linked to key distribution in conventional communication methods. Consequently, it provides a strong solution for secure communication in an environment where eavesdropping and the interception of public channels are common.
3.2.1 WORKING OF DIFFIE-HELLMAN
 
Figure 4. Diffie-Hellman Key Exchange
 STEP 1: Generating public parameters
Two participants, as shown in Figure 4, ‘Shiva’ and ‘Parikshith’, come to a shared consensus on a prime number called ‘p’ and an associated generator referred to as ‘g’. Both elements are made publicly available, ensuring that they are accessible not only to the two individuals involved but also to any outside observers. This openness is essential in cryptographic protocols, as it lays the groundwork for secure communication, while still protecting the confidentiality of the private information exchanged subsequently. The prime number ‘p’ acts as a critical element in numerous cryptographic algorithms, providing a secure foundation for encryption, while the generator ‘g’ is crucial for producing the necessary keys for their exchange.

 STEP 2: Generating Private and Public Keys
Each participant independently selects a private key:
Shiva selects a random private integer a, where 1 < a < p-1.
Parikshith selects a random private integer a, where 1 < b < p-1.
 With their private keys, they compute their corresponding public keys, which are given by:
 Shiva computes A = ga mod p
Parikshith computes B = gb mod p
 After which, User 1 shares A to User 2 and User 2 shares B to User 1 over the public channel.
 STEP 3: Computation of the Shared Secret
After exchanging public keys:
Shiva computes the shared secret S = Ba mod p
Parikshith computes the shared secret S = Ab mod p
Using the mathematical idea of modular arithmetic, we produce a comparable result, which is presented as follows.:
S = (gb)a mod p = (ga)b mod p
As a result, Shiva and Parikshith both obtain the identical shared secret S. This shared secret is now suitable to serve as the key for a symmetric encryption algorithm, safeguarding subsequent communication between Shiva and Parikshith.

3.3 AES-DH HYBRID MODEL
Hybrid cryptographic models combine the strengths of both symmetric and asymmetric encryption methods to achieve secure and efficient communication. To understand the hybrid model, we need to understand the differences between symmetric and asymmetric algorithms, especially the pros and cons of each model. The tables below show the strengths, weaknesses, and details of the algorithms.

Symmetric Cryptography
	Strengths	Details
1	Fast and efficient	Much faster than asymmetric; ideal for bulk data encryption (e.g., AES in hardware).
2	Low computational overhead	Requires less CPU/memory; well-suited for embedded systems.
3	Simpler algorithms	Easier to implement and analyze securely.
	Weakness	Details
1	Key distribution problem	Requires a secure out-of-band channel to share the same secret key
Asymmetric Cryptography
	Strengths	Details
1	Solves key distribution	Public keys can be shared openly; no need for a secure channel to distribute keys
2	Scales well	Each user has one key pair; it works well in large networks.
	Weakness	Details
1	Computationally expensive	Slower than symmetric methods; impractical for encrypting large data.
2	Requires larger key sizes	To match symmetric security (e.g., 2048-bit RSA, 112-bit AES).
3	Complex math and implementation	Increases the risk of side-channel or implementation flaws.
Therefore, combining the strengths of Symmetric and Asymmetric cryptographies, we get Simpler algorithms with low computational overhead, fast and efficient algorithms with secure key distribution. Here, AES and DH are combined to form a strong End-to-End Hybrid model as shown in Figure 5 below.
 
Figure 5. Hybrid Model for End-to-End Communication
Figure 5 illustrates how asymmetric encryption enables secure end-to-end communication between two users, Shiva, and Parikshith. Shiva encrypts a thier message using Parikshith’s public key, ensuring that only Parikshith can decrypt it using his private key. Even if the message is intercepted during transmission, it remains unreadable to others, as only the corresponding private key can unlock it. This method ensures confidentiality, authenticity, and data protection, making it ideal for secure digital communication.
Taking an example of WhatsApp, it utilizes the Signal Protocol for end-to-end encryption, which employs Curve25519 for key exchange, AES-256 for symmetric encryption, and HMAC-SHA256 for message authentication. The Signal Protocol also incorporates the Double Ratchet Algorithm and X3DH (Extended Triple Diffie-Hellman) handshake to ensure strong security. Similarly, WhatsApp, this project uses AES-128 for symmetric and Diffie-Hellman for Key Exchange. This implies the key generated initially is generated from the Diffie-Hellman key exchange protocol, and the AES Key generation algorithm uses this key to generate 10 separate round keys for encryption and decryption of ciphertext.
3.4 FPGA (Field Programmable Gate Array)
It is an integrated circuit that can be programmed and reconfigured based on user expectations after fabrication. The major advantage of using an FPGA is the capability to parallelize processes for logical operations, unlike regular sequential processes in a CPU.

The basic building blocks of an FPGA consist of:

1) Configurable Logic Block: Core center for computations, and each CLB includes a look-up table (LUT), flip-flops, and multiplexers.
2) Routing Matrix: An Interconnect network that links logic blocks to complete the required logical connection or a network.
3) Input-Output Blocks: These blocks play a vital role in linking external features like sensors, memory processors, etc, to interface with an FPGA.
4) Embedded Resources: This consists of Digital Signal Processing (DSP) for complex mathematical operations, block RAMs for local storage, and a Phase-Locked Loop (PLL) for managing time-related concepts.
 
Figure 6. Nexys A7 FPGA
Nexys A7-100T is an Xilinx Artix-7 XC7A100T-based FPGA development board that offers a compromise of performance and logic resources suitable for educational and advanced digital design applications. It is equipped with over 15,000 logic slices, high block RAM, and DSP slices, and thus suitable for designing complex systems like pipelined processors, encryption cores, and communications protocols. It includes in-board USB-JTAG and UART for serial programming and communication, and simple-to-use I/O devices such as switches, LEDs, buttons, VGA interface, and seven-segment displays. It also supports interfacing externally through Pmod ports and can be used with the Vivado Design Suite, and is a general-purpose platform for real-time hardware development and experimentation in areas such as cryptography, signal processing, and embedded systems.
3.	METHODOLOGY AND WORKING
 
Figure 7. Shiva to Parikshith Communication Line
Figure 7 shows the one-way communication step between Users Shiva and Parikshith. In this diagram, as data is sent from Shiva to Parikshith, Encryption takes place in Shiva’s block, and Decryption in Parikshith’s block. Each user’s block contains a Diffie-Hellman Module, an Encryption module, a Decryption module, and a key generation module.
The initial stage (1) starts with the User’s DH blocks containing their unique private key and the same prime number p and g. Using the mod function, the initial public keys are generated and exchanged between the two users. As Shiva attains Parikshith’s public key and vice versa, using the same mod function, Shiva uses the exchanged public key to generate a symmetric key, and Parikshith also performs the same. The resulting public keys are the same, which can be generated into the same 10-round keys by the AES key generation block as shown in step (2). The data/plaintext to be sent from Shiva is now encrypted (3) using the round keys, and the ciphertext is now transferred to Parikshith (4). In the end, this data is finally decrypted (5) by the decryption module using the same round keys, and the plaintext is obtained. 
The exchanged data between the 2 users is the public keys and the encrypted key. If one gets hold of this data, public keys cannot be used to crack the ciphertext unless the value of the Prime number p and g from the Diffie-Hellman modules are known. This way, the data can be exchanged securely between users.
 
Figure 8. Parikshith to Shiva Communication Line
Figure 8 explains the end-to-end communication between Shiva and Parikshith, where reverse communication takes place. Parikshith sends the data to Shiva, where initially the public keys are exchanged, and the symmetric keys are generated for the respective DH blocks, and the round keys are generated, which allows Parikshith to encrypt the data and Shiva to decrypt the message.





4.	SIMULATION RESULTS 
The widely accepted tools and techniques for developing the operational model of this project consist of:

•	Design Software: Utilized AMD Xilinx Vivado for the design, synthesis, and implementation of FPGA/ASIC.
•	Verification Tools: Utilized Synopsys Virtuoso SV and UVM for enhanced validation.
•	Languages: Utilized System Verilog for RTL design and UVM for developing the testbench.
•	Methodologies: Adopted the UVM framework to create organized and reusable testing environments.
•	Process: Comprehensive design (Vivado) and testing (Virtuoso/UVM) for complete validation.
•	FPGA Development Board: Nexus A-100T

The tools utilized for the design, verification, and hardware simulation of the Hybrid Model are depicted in Figure 9.

 
Figure 9. Tools Used for the Project

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

 

Figure 10. Simulation Waveforms for Hybrid Model
From Figure 9, we see the complete waveform generation of Public Keys, Symmetric Keys, Ready and Done signals for each module, Encryption, Key Generation, and Decryption Modules.
Initially, most amount the clock cycles after RESET are consumed by the DH model generating the public keys and symmetric keys over 256 clock cycles. The next 21 clock cycles are used by the AES model to encrypt and decrypt the data. Overall, under 280 clock cycles, the entire operation is completed.

 

Figure 11. Simulation Waveform for AES Pipelined Model
Figures 10 and 11 show how the waveforms generated are pipelined to perform the Key generation operation and Encryption in 11 clock cycles. In Figure 10, we see the initial 11 cycles used to generate the ciphertext and the next 10 cycles used to decrypt the ciphertext back to plain text. Therefore, in 21 clock cycles, the AES cycle is completed. Figure 12 shows the total resource utilization after synthesis on VIVADO.

 
Figure 12. Key vs Encryption Generation Cycle

 
Figure 13. Resource Usage
5.	CONCLUSION
Modern-day security systems are no longer secure with a single cryptographic algorithm due to increasingly sophisticated attack techniques and other threats. Single-layer cryptographic algorithms that rely solely on symmetric or asymmetric algorithms are exposed to vulnerabilities such as side attacks or key exposure. This is where hybrid cryptographic systems like AES-DH are needed. AES (Advanced Encryption Standard) provides fast and efficient symmetric encryption for bulk data, while Diffie-Hellman (DH) enables secure asymmetric key exchange, ensuring the AES key is shared safely over public networks. Together, they deliver a robust, end-to-end encryption system that is efficient, scalable, and secure. 

Implementing the AES-DH hybrid cryptography on an FPGA offers significant advantages for real-time, end-to-end encryption. FPGAs provide high throughput, low latency, parallel, and pipelining processing capabilities, making them ideal for managing AES encryption and DH key exchange. Unlike software implementations, FPGA-based solutions can be customized to optimize power, speed, and resource utilization, ensuring secure encryption even in constrained environments. Moreover, compared to software, hardware-based implementations are more resistant to side-channel attacks, such as timing and power analysis, further improving the security and reliability of the AES-DH hybrid in modern end-to-end encrypted communication.

Software-based cryptographic systems often face security vulnerabilities and inconsistent performance. This project overcomes these issues by implementing a hybrid cryptographic system using AES for rapid data encryption and Diffie-Hellman (DH) for secure key exchange.

Deploying the AES-DH hybrid approach on FPGA hardware enhances overall performance, scalability, security, and power efficiency. This makes the FPGA-based solution particularly well-suited for secure end-to-end encrypted communications and other sensitive real-time applications
