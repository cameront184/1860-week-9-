load Decoder.hdl,
output-file DecoderTest.out,
output-list in%B1.4.1 a%B1.1.1 b%B1.1.1 c%B1.1.1 d%B1.1.1 e%B1.1.1 f%B1.1.1 g%B1.1.1;

set in[3] 1,
set in[2] 0,
set in[1] 0,
set in[0] 1,
eval,
output;