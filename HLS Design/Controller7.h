#include"stdio.h"
#include <iostream>

using namespace std;

#include "hls_math.h"
#include "ap_fixed.h"
#include "math.h"
#include "hls_stream.h"
#include "ap_axi_sdata.h"
#include "assert.h"
#include "ap_int.h"


#define INPUT_SIZE 16//970//1000
#define timeSteps 1
//#define OUTPUT_SIZE 64
//#define M_WEIGHT_SIZE 65536 //850000//60000// 300000 //

#define hiddenUnitsLayer1 15//0 ///20 //
#define hiddenUnitsLayer2 15//0 ///20 //
#define hiddenUnitsLayer3 15//0 ///20 //

#define hiddenUnitsLayer 31 //512
#define hiddenUnitsLayer1_1 30 //512

#define maxHidden 15 //20//
#define MaxW_input1 160//0 //80 //
#define MaxW_recur1 6400//00 //1600 //
#define biasSize1 161 //81 //
#define gateInWsize 40 //0 //20 //
#define gateReWsize 1600 //00 //400 //

#define gateReWsize1 465 //0 //262144 //262144 //400 //
#define gateReWsize2 465
#define gateReWsize3 465
// Not Necessary
//#define depth1 4000
#define depth2 2048 //131072
//#define depth3 117312 //115712
/*
#define range1 29328 //28928 //(gateReWsize-depth2)
#define range2 101744 //102144 //(2*depth2-gateReWsize)
#define range3 58656 //57856 //2*(gateReWsize-depth2)
#define range4 72416 //73216 //(3*depth2-2*gateReWsize)
#define range5 87984 //86784 //3*(gateReWsize-depth2)
#define range6 43088 //44288 //(4*depth2-3*gateReWsize)
#define range7 117312 //115712 //4*(gateReWsize-depth2)
*/
#define value0 16 //1601//MaxW_input1+1
#define value1 31 //2001//MaxW_input1+hiddenUnitsLayer1+1
#define value2 46 //2401//MaxW_input1+2*hiddenUnitsLayer1+1
#define value3 61 //2801//MaxW_input1+3*hiddenUnitsLayer1+1
#define value4 76 //3201//MaxW_input1+4*hiddenUnitsLayer1+1

#define value5 91 //1601//MaxW_input1+1
#define value6 106 //2001//MaxW_input1+hiddenUnitsLayer1+1
#define value7 121 //2401//MaxW_input1+2*hiddenUnitsLayer1+1
#define value8 136 //2801//MaxW_input1+3*hiddenUnitsLayer1+1
#define value9 151 //3201//MaxW_input1+4*hiddenUnitsLayer1+1

#define value10 166 //1601//MaxW_input1+1
#define value11 181 //2001//MaxW_input1+hiddenUnitsLayer1+1
#define value12 196 //2401//MaxW_input1+2*hiddenUnitsLayer1+1
#define value13 211 //2801//MaxW_input1+3*hiddenUnitsLayer1+1
#define value14 226 //3201//MaxW_input1+4*hiddenUnitsLayer1+1


//#define value7 121//2*hiddenUnitsLayer1+1
//#define value6 81//3*hiddenUnitsLayer1+1
//#define value5 41//hiddenUnitsLayer1+1

#define HSIZE1 31
#define HSIZE2 30
#define HSIZE3 30

/*
#define hiddenUnitsLayer1 20 //
#define hiddenUnitsLayer2 30
#define maxHidden 20//
#define MaxW_input1 80 //
#define MaxW_recur1 1600 //
#define biasSize1 81 //
#define gateInWsize 20 //
#define gateReWsize 400 //
*/

typedef ap_fixed<16,8> fp1;
typedef ap_fixed<16,8> fp2;
typedef ap_fixed<16,8> fp3;

/*typedef ap_fixed<8,4, AP_RND, AP_SAT> fp1;
typedef ap_fixed<8,4, AP_RND, AP_SAT> fp2;
typedef ap_fixed<12,8, AP_TRN, AP_SAT> fp5;//12,8
typedef ap_fixed<12,8, AP_RND, AP_SAT> fp6;//16,12*/

/*typedef ap_fixed<12,6, AP_RND, AP_SAT> fp1;
typedef ap_fixed<12,6, AP_RND, AP_SAT> fp2;
//typedef ap_fixed<12,8, AP_RND, AP_SAT> fp3;
//typedef ap_fixed<12,8, AP_TRN, AP_SAT> fp5;
typedef ap_fixed<16,8, AP_RND, AP_SAT> fp6;*/

/*typedef ap_fixed<10,6, AP_RND, AP_SAT> fp1;
typedef ap_fixed<10,6, AP_RND, AP_SAT> fp2;
//typedef ap_fixed<12,8, AP_RND, AP_SAT> fp3;
//typedef ap_fixed<12,8, AP_TRN, AP_SAT> fp5;
typedef ap_fixed<16,8, AP_RND, AP_SAT> fp6;*/

typedef ap_fixed<8,8, AP_RND, AP_SAT>convert;
/*typedef ap_fixed<8,4> fp2;
typedef ap_fixed<12,8> fp3;
typedef ap_fixed<12,8> fp5;
typedef ap_fixed<12,8> fp6;*/

typedef ap_int<3> int3;
typedef ap_uint<1> uint1;

////typedef float fp1;
////typedef float fp2;
////typedef float fp3;

//typedef float fp4;
//typedef float fp6;
//typedef float fp5;


///typedef float fp1;
///typedef float fp2;
///typedef float fp3;

/*
typedef ap_int<4> int4;
typedef ap_int<6> int6;
typedef ap_int<8> int8;
typedef ap_int<10> int10;
typedef ap_int<12> int12;

/////typedef ap_int<14> int14;
typedef ap_int<24> int24;
typedef ap_int<28> int28;

typedef ap_int<16> int16;

typedef ap_int<14> int18;

typedef ap_int<20> int20;
typedef ap_int<22> int22;
typedef ap_int<30> int30;
typedef ap_int<32> int32;

typedef ap_uint<8> uint8;
typedef ap_uint<4> uint4;
typedef ap_uint<3> uint3;
typedef ap_uint<10> uint10;
typedef ap_uint<12> uint12;
typedef ap_uint<16> uint16;
typedef ap_uint<18> uint18;
typedef ap_uint<20> uint20;
typedef ap_uint<22> uint22;
typedef ap_uint<30> uint30;
typedef ap_uint<28> uint28;
typedef ap_uint<38> uint38;
*/
///typedef ap_axis<8,0,0,0> AXI_VAL1;
///typedef ap_axis<16,0,0,0> AXI_VAL2;



/*typedef struct ap_hls1{
	float data;
//	fp1 data;
	//uint8 data;
//	ap_uint<2> keep;
    ap_uint<1> last;
}AXI_VAL1;

typedef struct ap_hls3{
	float data;
	//fp2 data;
	//int8 data;

    ap_uint<1> last;
}AXI_VAL3;

typedef struct ap_hls2{
	float data;
//	fp6 data;
	//int12 data;
//	ap_uint<2> keep;
    ap_uint<1> last;
}AXI_VAL2;*/



//void Controller(hls::stream<AXI_VAL1> &in_stream, hls::stream<AXI_VAL3> &weight_stream, hls::stream<AXI_VAL2> &out_stream, configuration *Config, int new_net);
//void Controller(hls::stream<AXI_VAL1> &in_stream, hls::stream<AXI_VAL2> &out_stream, configuration *Config, int new_net, int conv);

//void Controller(float in_stream[600000], float out_stream[50], int3 new_net);
///void Controller(float in_stream[4000], float param_stream1[160000], float param_stream2[160000], float param_stream3[160000], float param_stream4[160000], float out_stream[50], int3 new_net);

void Controller(float in_stream[512], float param_stream1[depth2], float param_stream2[depth2], float param_stream3[depth2], float param_stream4[depth2], float out_stream[1], int3 new_net);
///void Controller(float in_stream[512], fp2 param_stream1[depth2], fp2 param_stream2[depth2], fp2 param_stream3[depth2], fp2 param_stream4[depth2], float out_stream[1], int3 new_net);

void forgetGate(fp2  ReW1[gateReWsize2], fp1 hid1[hiddenUnitsLayer], fp2 b1[hiddenUnitsLayer1], int hsize1, int HSIZE, fp3 ot1[maxHidden], int numInputs1);
void inputGate(fp2  ReW2[gateReWsize2],  fp1  hid2[hiddenUnitsLayer], fp2 b2[hiddenUnitsLayer1], int hsize2, int HSIZE, fp3 ot2[maxHidden], int numInputs2);
void cellGate(fp2  ReW3[gateReWsize2],   fp1  hid3[hiddenUnitsLayer], fp2 b3[hiddenUnitsLayer1], int hsize3, int HSIZE, fp3 ot3[maxHidden], int numInputs3);
void outputGate(fp2  ReW4[gateReWsize2], fp1  hid4[hiddenUnitsLayer], fp2 b4[hiddenUnitsLayer1], int hsize4, int HSIZE, fp3 ot4[maxHidden], int numInputs4);



template<class T, class U>
T sig(U x);

template<class T, class U>
T tan(U x);

