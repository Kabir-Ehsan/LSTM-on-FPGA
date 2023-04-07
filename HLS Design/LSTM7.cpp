#include "Controller7.h"

void Controller(float in_stream[512], float param_stream1[depth2], float param_stream2[depth2], float param_stream3[depth2], float param_stream4[depth2], float out_stream[16], int3 new_net)
//void Controller(float in_stream[512], fp2 param_stream1[depth2], fp2 param_stream2[depth2], fp2 param_stream3[depth2], fp2 param_stream4[depth2], float out_stream[1], int3 new_net)

{

     static fp3  cellState[hiddenUnitsLayer1];
     static fp3  cellStateNext[hiddenUnitsLayer1];

     static fp3  cellState1[hiddenUnitsLayer2];
     static fp3  cellStateNext1[hiddenUnitsLayer2];

     static fp3  cellState2[hiddenUnitsLayer3];
     static fp3  cellStateNext2[hiddenUnitsLayer3];

     static fp3  hiddenStateTemp1[hiddenUnitsLayer1];
     static fp3  hiddenStateTemp2[hiddenUnitsLayer2];
     static fp3  hiddenStateTemp3[hiddenUnitsLayer3];

     static fp3  cellStateTemp1[hiddenUnitsLayer1];
     static fp3  cellStateTemp2[hiddenUnitsLayer1];

     static fp3  cellStateTemp1_1[hiddenUnitsLayer2];
     static fp3  cellStateTemp2_1[hiddenUnitsLayer2];

     static fp3  cellStateTemp1_2[hiddenUnitsLayer2];
     static fp3  cellStateTemp2_2[hiddenUnitsLayer2];

	//test
     static fp1  hiddenStateF[hiddenUnitsLayer];
     static fp1  hiddenStateI[hiddenUnitsLayer];
     static fp1  hiddenStateC[hiddenUnitsLayer];
     static fp1  hiddenStateO[hiddenUnitsLayer];

     static fp1  hiddenStateF1[hiddenUnitsLayer];
     static fp1  hiddenStateI1[hiddenUnitsLayer];
     static fp1  hiddenStateC1[hiddenUnitsLayer];
     static fp1  hiddenStateO1[hiddenUnitsLayer];

     static fp1  hiddenStateF2[hiddenUnitsLayer];
     static fp1  hiddenStateI2[hiddenUnitsLayer];
     static fp1  hiddenStateC2[hiddenUnitsLayer];
     static fp1  hiddenStateO2[hiddenUnitsLayer];

    static fp2  weights[hiddenUnitsLayer1];

    static fp3 finalBias;

    static fp2 forgetReWeight[gateReWsize1];
    static fp2 inputReWeight[gateReWsize1];
    static fp2 cellReWeight[gateReWsize1];
    static fp2 outputReWeight[gateReWsize1];

    static fp2 forgetReWeight1[gateReWsize2];
    static fp2 inputReWeight1[gateReWsize2];
    static fp2 cellReWeight1[gateReWsize2];
    static fp2 outputReWeight1[gateReWsize2];

    static fp2 forgetReWeight2[gateReWsize3];
    static fp2 inputReWeight2[gateReWsize3];
    static fp2 cellReWeight2[gateReWsize3];
    static fp2 outputReWeight2[gateReWsize3];

    static fp2 forgetBias[hiddenUnitsLayer1];
    static fp2 inputBias[hiddenUnitsLayer1];
    static fp2 cellBias[hiddenUnitsLayer1];
    static fp2 outputBias[hiddenUnitsLayer1];

    static fp2 forgetBias1[hiddenUnitsLayer1];
    static fp2 inputBias1[hiddenUnitsLayer1];
    static fp2 cellBias1[hiddenUnitsLayer1];
    static fp2 outputBias1[hiddenUnitsLayer1];

    static fp2 forgetBias2[hiddenUnitsLayer2];
    static fp2 inputBias2[hiddenUnitsLayer2];
    static fp2 cellBias2[hiddenUnitsLayer2];
    static fp2 outputBias2[hiddenUnitsLayer2];

	int a=0,b=0,c=0,d=0,e=0,f=0,g=0,h=0,i=0,j=0,k=0,l=0,m=0,n=0,o=0,p=0,q=0,R=0,s=0,t=0,w=0;

	fp3 final;
	fp3 finalOut[hiddenUnitsLayer1];

	fp3 forget[maxHidden];
	fp3 input[maxHidden];
	fp3 cell[maxHidden];
	fp3 output[maxHidden];

	fp3 forget1[maxHidden];
	fp3 input1[maxHidden];
	fp3 cell1[maxHidden];
	fp3 output1[maxHidden];

	fp3 forget2[maxHidden];
	fp3 input2[maxHidden];
	fp3 cell2[maxHidden];
	fp3 output2[maxHidden];
/*
	initilizationC1:for(a=0;a<hiddenUnitsLayer1;a++)
	{
		cellState[a] = 0;
		cellStateNext[a] = 0;
		cellState1[a] = 0;
		cellStateNext1[a] = 0;
		cellState2[a] = 0;
		cellStateNext2[a] = 0;
		hiddenStateTemp1[a] = 0;
		hiddenStateTemp2[a] = 0;
		hiddenStateTemp3[a] = 0;
		cellStateTemp1[a] = 0;
		cellStateTemp2[a] = 0;
		cellStateTemp1_1[a] = 0;
		cellStateTemp2_1[a] = 0;
		cellStateTemp1_2[a] = 0;
		cellStateTemp2_2[a] = 0;

	}

	initilizationH:for(a=0;a<hiddenUnitsLayer1_1;a++)
	{
		hiddenStateF[a] = 0;
		hiddenStateI[a] = 0;
		hiddenStateC[a] = 0;
		hiddenStateO[a] = 0;

		hiddenStateF1[a] = 0;
		hiddenStateI1[a] = 0;
		hiddenStateC1[a] = 0;
		hiddenStateO1[a] = 0;

		hiddenStateF2[a] = 0;
		hiddenStateI2[a] = 0;
		hiddenStateC2[a] = 0;
		hiddenStateO2[a] = 0;

	}

	hiddenStateF[a] = 0;
	hiddenStateI[a] = 0;
	hiddenStateC[a] = 0;
	hiddenStateO[a] = 0;
*/
	StoreInput1:for(h=0;h<INPUT_SIZE;h++)
	{
		hiddenStateF[h] = in_stream[h];
		hiddenStateI[h] = in_stream[h];
		hiddenStateC[h] = in_stream[h];
		hiddenStateO[h] = in_stream[h];
	}


	 if(new_net==1)
	 {

		WEIGHTS:for(i=0;i<hiddenUnitsLayer1;i++)
		{
			weights[i] = in_stream[value0+i];
		}
		setBias1:for(i=0;i<hiddenUnitsLayer1;i++)
		{
			inputBias[i] = in_stream[value1+i];
			inputBias1[i] = in_stream[value5+i];
			inputBias2[i] = in_stream[value9+i];
		}
		setBias2:for(i=0;i<hiddenUnitsLayer1;i++)
		{
	 	 	forgetBias[i]  = in_stream[value2+i];
	 	 	forgetBias1[i] = in_stream[value6+i];
	 	 	forgetBias2[i] = in_stream[value10+i];
		}
		setBias3:for(i=0;i<hiddenUnitsLayer1;i++)
		{
	 	 	cellBias[i] = in_stream[value3+i];
	 	 	cellBias1[i] = in_stream[value7+i];
	 	 	cellBias2[i] = in_stream[value11+i];
		}
		setBias4:for(i=0;i<hiddenUnitsLayer1;i++)
	    {
	 	 	outputBias[i] = in_stream[value4+i];
	 	 	outputBias1[i] = in_stream[value8+i];
	 	 	outputBias2[i] = in_stream[value12+i];
		}
		finalBias =  in_stream[value13];
//		cout << "Final BIAS:" << finalBias << "\n";


			 SetReWeights1:for(i=0;i<465;i++)//depth2;i++)
			 	 	 	 	 {
				 	 	 	 	 inputReWeight[i]=param_stream1[i];
//				 	 	 	 	 cout<< "inputReWeight:"<<i<< " -- " <<inputReWeight[i] <<'\n';
			 	 	 	 	 }
			 SetReWeights2:for(i=0;i<450;i++)
			 	 	 	 	 {
 	 	 	 	 	 	 	 	 inputReWeight1[i]=param_stream1[i+465];
//				 	 	 	 	 cout<< "inputReWeight1:"<<i<< " -- " <<inputReWeight1[i] <<'\n';
			 	 	 	 	 }
			 SetReWeights3:for(i=0;i<450;i++)
			 	 	 	 	 {
 	 	 	 	 	 	 	 	 inputReWeight2[i]=param_stream1[i+915];
//				 	 	 	 	 cout<< "inputReWeight2:"<<i<< " -- " <<inputReWeight2[i] <<'\n';
			 	 	 	 	 }
			 SetReWeights4:for(i=0;i<465;i++)//range2;i++)
			 	 	 	 	 {
				 	 	 	 	 forgetReWeight[i] = param_stream2[i];//+range1];
			 	 	 	 	 }
			 SetReWeights5:for(i=0;i<450;i++)
			 	 	 	 	 {
 	 	 	 	 	 	 	 	 forgetReWeight1[i] = param_stream2[i+465];
			 	 	 	 	 }
			 SetReWeights6:for(i=0;i<465;i++)
			 	 	 	 	 {
 	 	 	 	 	 	 	 	 forgetReWeight2[i] = param_stream2[i+915];
			 	 	 	 	 }
			 SetReWeights7:for(i=0;i<465;i++)//range4;i++)
			 	 	 	 	 {
				 	 	 	 	 cellReWeight[i] = param_stream3[i];//+range3];
			 	 	 	 	 }
			 SetReWeights8:for(i=0;i<450;i++)
			 	 	 	 	 {
 	 	 	 	 	 	 	 	 cellReWeight1[i] = param_stream3[i+465];
			 	 	 	 	 }
			 SetReWeights9:for(i=0;i<465;i++)
			 	 	 	 	 {
 	 	 	 	 	 	 	 	 cellReWeight2[i] = param_stream3[i+915];
			 	 	 	 	 }
			 SetReWeights10:for(i=0;i<465;i++)//range6;i++)
			 	 	 	 	 {
				 	 	 	 	 outputReWeight[i] = param_stream4[i];//+range5];
			 	 	 	 	 }
			 SetReWeights11:for(i=0;i<450;i++)
			 	 	 	 	 {
				 	 	 	 	 outputReWeight1[i] = param_stream4[i+465];
//				 	 	 	 	 cout<< "outputReWeight:"<<i<< " -- " <<outputReWeight1[i] <<'\n';
			 	 	 	 	 }
			 SetReWeight12:for(i=0;i<450;i++)
			 	 	 	 	 {
				 	 	 	 	 outputReWeight2[i] = param_stream4[i+915];
//				 	 	 	 	 cout<< "outputReWeight:"<<i<< " -- " <<outputReWeight2[i] <<'\n';
			 	 	 	 	 }


//		}
	 }


//-------------------------------end feeding weights-------------------------------------------------

//------------------------------- start feeding inputs-----------------------------------------------

	 TimeSteps:for(t=0;t<1;t++)
	 //TimeSteps:for(t=0;t<2;t++)
	 	 	   {
					 final = 0;
//					 if(t<1)
//					 {
//						 Layers:for(s=0;s<3;s++)
//						 {

//							 if(s==0)
//							 {

								 forgetGate(forgetReWeight, hiddenStateF, forgetBias, hiddenUnitsLayer1, HSIZE1, forget, t);
								 inputGate(inputReWeight, hiddenStateI, inputBias,  hiddenUnitsLayer1, HSIZE1, input, t);
								 cellGate(cellReWeight, hiddenStateC, cellBias, hiddenUnitsLayer1, HSIZE1, cell, t);
								 outputGate(outputReWeight, hiddenStateO, outputBias, hiddenUnitsLayer1, HSIZE1, output, t);

								 cellCandidate:for(c=0;c<hiddenUnitsLayer1;c++)
										 {
											 	 cellStateNext[c] = input[c]*cell[c];
											 	 cellStateTemp1[c] = forget[c]*cellState[c];
//					 							 cout<< "cellState:"<<c<< " -- " <<cellState[c] <<'\n';
										 }

								 cellStatusNew:for(c=0;c<hiddenUnitsLayer1;c++)
										 {

							 	 	 	 	 //cellState[c] = cellState[c]+cellStateNext[c];
												 cellStateTemp2[c] = cellStateTemp1[c]+cellStateNext[c];
						//					 cout<< "cellStatusNew:"<<c<< " -- " <<cellState[c] <<'\n';
										 }

								 hiddenStatus:for(c=0;c<hiddenUnitsLayer1;c++)
									 	 {
					//					 	hiddenStateTemp1[c] = output[c]*tan<fp1,fp1>(cellStateTemp1[c]+cellStateNext[c]);
										 	 hiddenStateTemp1[c] = output[c]*tan<fp3,fp3>(cellStateTemp2[c]);
					//					 	cout<< "hiddenStatus:"<<c<< " -- " <<hiddenState[c] <<'\n';
									 	 }

					/*
					 */
							StoreInput2:for(l=0;l<hiddenUnitsLayer1;l++)
										{
											hiddenStateF1[l] = hiddenStateTemp1[l];
											hiddenStateI1[l] = hiddenStateTemp1[l];
											hiddenStateC1[l] = hiddenStateTemp1[l];
											hiddenStateO1[l] = hiddenStateTemp1[l];
//											cout<< "hiddenStatusLayer1:"<<l<< " -- " <<hiddenStateTemp1[l] <<'\n';
											//cellState1[l] = cellStateTemp2[l];
										}
//							 }

//							 else if(s==1)

//							 {

							nextState1:for(b=0;b<(hiddenUnitsLayer1);b++)
						   {
								 //in_stream>>in1;
		//						 hiddenState[b]  = hiddenStateTemp1[b];
								//test
								 hiddenStateF[b+16] = hiddenStateTemp1[b];
								 hiddenStateI[b+16] = hiddenStateTemp1[b];
								 hiddenStateC[b+16] = hiddenStateTemp1[b];
								 hiddenStateO[b+16] = hiddenStateTemp1[b];
								 //
								 //in_stream>>in1;
								 cellState[b] = cellStateTemp2[b];

						   }

							 //forgetGate(forgetReWeight, hiddenStateF, forgetBias, hiddenUnitsLayer1, HSIZE1, forget, t);
								 forgetGate(forgetReWeight1, hiddenStateF1, forgetBias1, hiddenUnitsLayer2, HSIZE2, forget1, t);
								 inputGate(inputReWeight1, hiddenStateI1, inputBias1,  hiddenUnitsLayer2, HSIZE2, input1, t);
								 cellGate(cellReWeight1, hiddenStateC1, cellBias1, hiddenUnitsLayer2, HSIZE2, cell1, t);
								 outputGate(outputReWeight1, hiddenStateO1, outputBias1, hiddenUnitsLayer2, HSIZE2, output1, t);

								 cellCandidate2:for(c=0;c<hiddenUnitsLayer2;c++)
										 {
											 	 cellStateNext1[c] = input1[c]*cell1[c];
											 	 cellStateTemp1_1[c] = forget1[c]*cellState1[c];
//					 							 cout<< "cellStateNextLayer2:"<<c<< " -- " <<cellStateNext1[c] <<'\n';
										 }

								 cellStatusNew2:for(c=0;c<hiddenUnitsLayer2;c++)
										 {

							 	 	 	 	 //cellState[c] = cellState[c]+cellStateNext[c];
												 cellStateTemp2_1[c] = cellStateTemp1_1[c]+cellStateNext1[c];
						//					 cout<< "cellStatusNew:"<<c<< " -- " <<cellState[c] <<'\n';
										 }

								 hiddenStatus2:for(c=0;c<hiddenUnitsLayer2;c++)
									 	 {
					//					 	hiddenStateTemp1[c] = output[c]*tan<fp1,fp1>(cellStateTemp1[c]+cellStateNext[c]);
										 	 hiddenStateTemp2[c] = output1[c]*tan<fp3,fp3>(cellStateTemp2_1[c]);
					//					 	cout<< "hiddenStatus:"<<c<< " -- " <<hiddenState[c] <<'\n';
									 	 }

							/*
								*/
							StoreInput3:for(l=0;l<hiddenUnitsLayer2;l++)
										{
											hiddenStateF2[l] = hiddenStateTemp2[l];
											hiddenStateI2[l] = hiddenStateTemp2[l];
											hiddenStateC2[l] = hiddenStateTemp2[l];
											hiddenStateO2[l] = hiddenStateTemp2[l];
//											cout<< "hiddenStatusLayer2:"<<l<< " -- " <<hiddenStateTemp2[l] <<'\n';
										}
//							 }

//							 if(s==2)
//							 {
							nextState2:for(b=0;b<(hiddenUnitsLayer1);b++)
							   {
									 //in_stream>>in1;
			//						 hiddenState[b]  = hiddenStateTemp1[b];
									//test
									 hiddenStateF1[b+15] = hiddenStateTemp2[b];
									 hiddenStateI1[b+15] = hiddenStateTemp2[b];
									 hiddenStateC1[b+15] = hiddenStateTemp2[b];
									 hiddenStateO1[b+15] = hiddenStateTemp2[b];
									 //
									 //in_stream>>in1;
									 cellState1[b] = cellStateTemp2_1[b];

							   }

								 forgetGate(forgetReWeight2, hiddenStateF2, forgetBias2, hiddenUnitsLayer3, HSIZE3, forget2, t);
								 inputGate(inputReWeight2, hiddenStateI2, inputBias2,  hiddenUnitsLayer3, HSIZE3, input2, t);
								 cellGate(cellReWeight2, hiddenStateC2, cellBias2, hiddenUnitsLayer3, HSIZE3, cell2, t);
								 outputGate(outputReWeight2, hiddenStateO2, outputBias2, hiddenUnitsLayer3, HSIZE3, output2, t);

								 cellCandidate3:for(c=0;c<hiddenUnitsLayer3;c++)
										 {
											 	 cellStateNext2[c] = input2[c]*cell2[c];
											 	 cellStateTemp1_2[c] = forget2[c]*cellState2[c];
// 					 							 cout<< "cellStateNextLayer3:"<<c<< " -- " <<cellStateNext[c] <<'\n';
										 }

								 cellStatusNew3:for(c=0;c<hiddenUnitsLayer3;c++)
										 {

							 	 	 	 	 //cellState[c] = cellState[c]+cellStateNext[c];
												 cellStateTemp2_2[c] = cellStateTemp1_2[c]+cellStateNext2[c];
						//					 cout<< "cellStatusNew:"<<c<< " -- " <<cellState[c] <<'\n';
										 }

								 hiddenStatus3:for(c=0;c<hiddenUnitsLayer3;c++)
									 	 {
					//					 	hiddenStateTemp1[c] = output[c]*tan<fp1,fp1>(cellStateTemp1[c]+cellStateNext[c]);
										 	 hiddenStateTemp3[c] = output2[c]*tan<fp3,fp3>(cellStateTemp2_2[c]);
//										 	 cout<< "hiddenStatusLayer3:"<<c<< " -- " <<hiddenStateTemp3[c] <<'\n';
									 	 }

								 outStatus:for(c=0;c<hiddenUnitsLayer3;c++)
									 	 {
										 	 //finalOut[c] = hiddenState[c]*weights[c];
										 	 finalOut[c] = hiddenStateTemp3[c]*weights[c];

//										 	 cout<< "FCweights:"<<c<< " -- " <<weights[c] <<'\n';
//										 	cout<< "outStatus:"<<c<< " -- " <<finalOut[c] <<'\n';
									 	 }
					////}
								 result: for(g=0;g<hiddenUnitsLayer3;g++)
								 	 	 {
									 	 	 final = final+finalOut[g];

								 	 	 }

						 	 	 final = final+finalBias;
//								 out_stream[t]=final+biasLayer1[hiddenUnitsLayer1*4];
						 	 	 out_stream[t]= final;
#ifndef __SYNTHESIS__
//						 	 	 cout<< "pred"<<"["<<t<<"]:"<<out_stream[t] <<'\n';
//								 cout<< "predOrg"<<"["<<t<<"]:"<<final <<'\n';
#endif
//							  }

//					}
	 	 	   }


	 nextState3:for(b=0;b<(hiddenUnitsLayer3);b++)
	 	 		   {
						 //in_stream>>in1;
//						 hiddenState[b]  = hiddenStateTemp1[b];
						//test
						 hiddenStateF2[b+15] = hiddenStateTemp3[b];
						 hiddenStateI2[b+15] = hiddenStateTemp3[b];
						 hiddenStateC2[b+15] = hiddenStateTemp3[b];
						 hiddenStateO2[b+15] = hiddenStateTemp3[b];
						 //
						 //in_stream>>in1;
						 cellState2[b] = cellStateTemp2_2[b];
						 //l = l+2;
						 //test

						 //
//							 cellStateNext[b]=0;
#ifndef __SYNTHESIS__
//						cout<< "hiddenState:"<<b<< " -- " <<hiddenStateF[b] <<'\n';
//						cout<< "cellState:"<<b<< " -- " <<cellState[b] <<'\n';
#endif
//						cout<< "cellStateNext:"<<b<< " -- " <<cellStateNext[b] <<'\n';

	 	 		   }

	 	 return;
}
//---------------------------------------------------------------------------------------------------------------------------



//---------------------------------------------------------------------------------------------------------------------------

void forgetGate(fp2  ReW1[gateReWsize2], fp1  hid1[hiddenUnitsLayer], fp2 b1[hiddenUnitsLayer1], int hsize1, int HSIZE, fp3 ot1[maxHidden], int numInputs1)
{
		int i,j,k,l,m,n,p;
		fp3 s1,s2;
//		fp1 reg1;
//		fp2 reg2;
		//fp1 sum[hsize];
//		fp3 sum1[hiddenUnitsLayer1];
		fp3 sum2[hiddenUnitsLayer1];
//		fp3 inMul1[1];
		fp3 inMul2[hiddenUnitsLayer];


		hiddenLayerf:for(l=0;l<maxHidden;l++)
					{
						if(l<hsize1)
						{
							s2=0;
							hiddenMultf:for(m=0;m<hiddenUnitsLayer;m++)
										{
											if(m<HSIZE)
											{
												//cout<< "\nforgetGate_Hidden:" << hid1[m] <<'\n';
												inMul2[m]=hid1[m]*ReW1[m+l*HSIZE];
											}
											else
												break;

										}
							hiddenAccumf:for(n=0;n<hiddenUnitsLayer;n++)
										{
											if(n<HSIZE)
											{
												s2 = s2+inMul2[n];
											}
											else
												break;
										}
	//						ot1[l] = sig<fp3,fp3>(s2+b1[l]);
							sum2[l] = s2;
	//						cout<< "\nforgetGateSUM:" << sum2[l] <<'\n';
						}
						else
							break;
					}

		finalf:for (p=0;p<maxHidden;p++)
				{
					if(p<hsize1)
					{
						ot1[p] = sig<fp3,fp3>(sum2[p]+b1[p]);
//						cout<< "\nforgetGate:" << ot1[p] <<'\n';
					}
					else
						break;

				}

};

void inputGate(fp2  ReW2[gateReWsize2], fp1  hid2[hiddenUnitsLayer], fp2 b2[hiddenUnitsLayer1], int hsize2, int HSIZE, fp3 ot2[maxHidden], int numInputs2)
{
		int i,j,k,l,m,n,p;
		fp3 s3,s4;
//		fp1 reg3;
//		fp2 reg4;
//		fp3 sum3[hiddenUnitsLayer1];
		fp3 sum4[hiddenUnitsLayer1];
		//fp1 sum[hsize];
//		fp3 inMul3[1];
		fp3 inMul4[hiddenUnitsLayer];


		hiddenLayeri:for(l=0;l<maxHidden;l++)
					{
						if(l<hsize2)
						{
							s4=0;
							hiddenMulti:for(m=0;m<hiddenUnitsLayer;m++)
										{
											if(m<HSIZE)
											{
												//cout<< "\ninputGate_Hidden:" << hid2[m] <<'\n';
												inMul4[m]=hid2[m]*ReW2[m+l*HSIZE];
											}
											else
												break;

										}
							hiddenAccumi:for(n=0;n<hiddenUnitsLayer;n++)
										{
											if(n<HSIZE)
											{
												s4 = s4+inMul4[n];
											}
											else
												break;
										}
		//						ot2[l] = sig<fp3,fp3>(s4+b2[l]);
							sum4[l] = s4;
//							cout<< "\ninputGateSUM:" << sum4[l] <<'\n';
						}
					}

		finali:for (p=0;p<maxHidden;p++)
				{
					if(p<hsize2)
					{
						ot2[p] = sig<fp3,fp3>(sum4[p]+b2[p]);
//						cout<< "\ninputGate:" << ot2[p] <<'\n';
					}
					else
						break;
//					cout<< "\ninputGate:" << ot[p] <<'\n';
				}

};

void cellGate(fp2  ReW3[gateReWsize2], fp1  hid3[hiddenUnitsLayer], fp2 b3[hiddenUnitsLayer1], int hsize3, int HSIZE, fp3 ot3[maxHidden], int numInputs3)
{
	int i,j,k,l,m,n,p;
	fp3 s5,s6;
//	fp1 reg5;
//	fp2 reg6;
//	fp3 sum5[hiddenUnitsLayer1];
	fp3 sum6[hiddenUnitsLayer1];

	fp3 inMul6[hiddenUnitsLayer];
	//candidate layer


	hiddenLayerc:for(l=0;l<maxHidden;l++)
				{
					if(l<hsize3)
					{
						s6=0;
						hiddenMultc:for(m=0;m<hiddenUnitsLayer;m++)
									{
										if(m<HSIZE)
										{
											inMul6[m]=hid3[m]*ReW3[m+l*HSIZE];
										}
										else
											break;
									}
						hiddenAccumc:for(n=0;n<hiddenUnitsLayer;n++)
									{
										if(n<HSIZE)
										{
											s6 = s6+inMul6[n];

										}
										else
											break;
									}
	//					ot3[l] = tan<fp3,fp3>(s6+b3[l]);
						sum6[l] = s6;
//					cout<< "\ncellGateSUM:" << sum6[l] <<'\n';
					}
					else
						break;
				}

			finalc:for (p=0;p<maxHidden;p++)
			{
				if(p<hsize3)
				{
					ot3[p] = tan<fp3,fp3>(sum6[p]+b3[p]);
//					cout<< "\ncellGate:" << ot3[p] <<'\n';
				}
				else
					break;
//				cout<< "\ncellGate:" << ot[p] <<'\n';
			}



};

void outputGate(fp2  ReW4[gateReWsize2], fp1  hid4[hiddenUnitsLayer], fp2 b4[hiddenUnitsLayer1], int hsize4, int HSIZE, fp3 ot4[maxHidden], int numInputs4)
{
		int i,j,k,l,m,n,p;
		fp3 s7,s8;
//		fp1 reg7;
//		fp2 reg8;
		//fp1 sum[hsize];
//		fp3 sum7[hiddenUnitsLayer1];
		fp3 sum8[hiddenUnitsLayer1];
//		fp3 inMul7[1];
		fp3 inMul8[hiddenUnitsLayer];

		hiddenLayero:for(l=0;l<maxHidden;l++)
					{
						if(l<hsize4)
						{
							s8=0;
							hiddenMulto:for(m=0;m<hiddenUnitsLayer;m++)
										{
											if(m<HSIZE)
											{
												inMul8[m]=hid4[m]*ReW4[m+l*HSIZE];
											}
											else
												break;
										}
							hiddenAccumo:for(n=0;n<hiddenUnitsLayer;n++)
										{
											if(n<HSIZE)
											{
												s8 = s8+inMul8[n];
											}
											else
												break;
										}

							sum8[l] = s8;
						}
						else
							break;
					}

		finalo:for (p=0;p<maxHidden;p++)
				{
					if(p<hsize4)
					{
						ot4[p] = sig<fp3,fp3>(sum8[p]+b4[p]);
//						cout<< "\noutputGate:" << ot4[p] <<'\n';
					}
					else
						break;
//					cout<< "\noutputGate:" << ot[p] <<'\n';
				}

};


/*template<class T, class U>
T RELU(U x)
{
	if(x<0)
		return 0;
	else
		return x;
};
*/
// Original AF

/*
template<class T, class U>
T sig(U x)
{
	return 1/(1+exp(-x));
};

template<class T, class U>
T tan(U x)
{
	//return (exp(-2*x)-1)/(exp(-2*x)+1);
	return (1 - 2*sig<fp1,fp1>(-2*x));
};

*/


template<class T, class U>
T sig(U x)
{
	return U(1)/(U(1)+hls::exp(-U(1)*x));
	//fp_type(1.0)/(fp_type(1.0) + hls::exp(-fp_type(1) * sum25));
	//hls::exp(-fp_type(1) * s)
};

template<class T, class U>
T tan(U x)
{
	//return (exp(-2*x)-1)/(exp(-2*x)+1);
	return (U(1) - U(2)*sig<fp1,fp1>(-2*x));
};


// PWL method-01 Hard Sigmoid
/*
template<class T, class U>
T sig(U x)
{
	if (x>2.5)
		return 1;
	else if (x>-2.5 && x<2.5)
		return (0.2*x+0.5);
	else
		return 0;

};

template<class T, class U> // Hard Tangent
T tan(U x)
{
	if (x>=1)
		return 1;
	else if (x>-1 && x<1)
		return x;
	else
		return (-1);
};
*/
// PWL method-01 for fixed point
/*
template<class T, class U>
T sig(U x)
{
	if (x>2.5)
		return 1;
	else if (x>-2.5 && x<2.5)
		return (U(0.2)*x+U(0.5));
	else
		return 0;

};

template<class T, class U>
T tan(U x)
{
	if (x>=1)
		return 1;
	else if (x>-1 && x<1)
		return x;
	else
		return (-1);
};
*/

/*template<class T, class U>
T tan(U x)
{
	 return (1-2*sig<fp1,fp1>(-2*x));
};*/

/*
// PWL method-02
template<class T, class U>
T sig(U x)
{
	  U temp = x;

	  if(temp < 0)
	  {
		  x = -x;
	  }
	  if(x >= 5)
	  {
		  // 1
		  x = 1;
	  }
	  else if(x >= 2.375 &&  x < 5)
	  {
		  //0.03125 * |x| + 0.84375
		  x = 0.03125*x + 0.84375;
	  }
	  else if(1 <= x  && x < 2.375)
	  {
		  // 0.125 * |x| + 0.625
		  x = 0.125*x + 0.625;
	  }
	  else if(0 <=x && x<1)
	  {
		  // 0.25 * |x| + 0.5
		  x = 0.25*x + 0.5;
	  }
	  if(temp < 0)
	  {
		  //1 - sig(x)
		  x = 1 - x;
	  }

	  return x;
};


template<class T, class U>
T tan(U x)
{
	  U in = (-2)*x;

	  U temp = in;

	  if(in < 0)
	  {
		  in = -in;
	  }
	  if(in > 5)
	  {
		  // 1
		  x = 1;
	  }
	  else if(in >= 2.375 &&  in<5)
	  {
		  //0.03125 * |x| + 0.84375
		  x = 0.03125*in + 0.84375;
	  }
	  else if(1 <= in  && in <2.375)
	  {
		  // 0.125 * |x| + 0.625
		  x = 0.125*in + 0.625;
	  }
	  else if(0 <= in && in <1)
	  {
		  // 0.25 * |x| + 0.5
		  x = 0.25*in + 0.5;
	  }
	  if(temp < 0)
	  {
		  //1 - sig(x)
		  x = 1 - x;
	  }
	  x = 1 - ((2)*x);

	  return x;

	  return (1-2*sig<fp1,fp1>(-2*x));
};
*/

// PWL method-02 for Fixed Point
/*
template<class T, class U>
T sig(U x)
{
	  U temp = x;

	  if(temp < 0)
	  {
		  x = -x;
	  }
	  if(x >= 5)
	  {
		  // 1
		  x = 1;
	  }
	  else if(x >= 2.375 &&  x < 5)
	  {
		  //0.03125 * |x| + 0.84375
		  x = U(0.03125)*x + U(0.84375);
	  }
	  else if(1 <= x  && x < 2.375)
	  {
		  // 0.125 * |x| + 0.625
		  x = U(0.125)*x + U(0.625);
	  }
	  else if(0 <=x && x<1)
	  {
		  // 0.25 * |x| + 0.5
		  x = U(0.25)*x + U(0.5);
	  }
	  if(temp < 0)
	  {
		  //1 - sig(x)
		  x = 1 - x;
	  }

	  return x;
};


template<class T, class U>
T tan(U x)
{
	  U in = (-2)*x;

	  U temp = in;

	  if(in < 0)
	  {
		  in = -in;
	  }
	  if(in > 5)
	  {
		  // 1
		  x = 1;
	  }
	  else if(in >= 2.375 &&  in<5)
	  {
		  //0.03125 * |x| + 0.84375
		  x = U(0.03125)*in + U(0.84375);
	  }
	  else if(1 <= in  && in <2.375)
	  {
		  // 0.125 * |x| + 0.625
		  x = U(0.125)*in + U(0.625);
	  }
	  else if(0 <= in && in <1)
	  {
		  // 0.25 * |x| + 0.5
		  x = U(0.25)*in + U(0.5);
	  }
	  if(temp < 0)
	  {
		  //1 - sig(x)
		  x = 1 - x;
	  }
	  x = 1 - ((2)*x);

	  return x;

	  //return (1-2*sig<fp1,fp1>(-2*x));
};
*/

/*
// LOOK UP TABLE METHOD-01
template<class T, class U>
T sig(U x)
{
	U temp = x;
	if(temp<0)
	{
		x = (-1)*x;
	}

	if(x>=0 && x<=6)
	{
		sigLUT: for(int j=0;j<384;j++)
		{
			if(x>=xSig[j] && x< xSig[j+1])
			{
				x = sigM[j];
				break;
			}
		}
		if(temp<0)
				x = 1-x;
	}
	else
		x = 1;



	return x;
};

template<class T, class U>
T tan(U x)
{
	U temp = x;
	if(temp<0)
		x = (-1)*x;

	if(x>=0 && x<0.25)
	{
		x = 1*x;
		if(temp<0)
			x = -x;
	}
	else if(x>=0.25 && x<=3)
	{
		tanLUT: for(int i=0;i<176;i++)
		{
			if(x>=xTan[i] && x<xTan[i+1])
			{
				x = tanH[i];
				break;
			}
		}
		if(temp<0)
				x = -x;
	}

	else
	{
		x = 1;
	}



	return x;
};
*/

/*
// LOOK UP TABLE METHOD-02
template<class T, class U>
T sig(U x)
{
	U temp1 = x;
	convert temp2 = x;
	if(temp1<0)
	{
		x = (-1)*x;
	}


	if(x>=0 && x<=6)
	{
		x = sigM[temp2];
		if(temp1<0)
			x = 1-x;
	}
	else
		x = 1;



	return x;
};

template<class T, class U>
T tan(U x)
{
	U temp1 = x;
	convert temp2 = x;
	if(temp1<0)
		x = (-1)*x;

	if(x>=0 && x<0.25)
	{
		x = 1*x;
		if(temp1<0)
			x = (-1)*x;
	}
	else if(x>=0.25 && x<=3)
	{
		x = tanH[temp2];
		if(temp1<0)
			x = (-1)*x;

	}

	else
	{
		x = 1;
	}



	return x;
};
*/

 //---------------------------------
 //------------------------------------------------------------------------------------------

