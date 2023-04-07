#include "Controller7.h"
#include "inputsLSTM2.h"
#include "bias.h"
#include "fcW.h"
#include "inw.h"
#include "forw.h"
#include "cellw.h"
#include "outw.h"
//#include "inputsLSTM2.h


int main()
{

	//hls::stream<AXI_VAL1> in_stream;
	//hls::stream<AXI_VAL2> out_stream;

	//AXI_VAL1 d1,d2,d3,d4,d5,d6;
	//AXI_VAL2 out;



	float Output[1];
	int i,j,k,l,m;
	int retval=0;
//	int *new_net;
//	uint1 start = 1;
//	uint1 done;
	int3 new_net = 1;
	//new_net1 = 1;
	//new_net = &new_net1;


	int h;
	float correct = 0;

	float in_stream[512];

//	static fp2 param_stream1[depth2];
//	static fp2 param_stream2[depth2];
//	static fp2 param_stream3[depth2];
//	static fp2 param_stream4[depth2];
//
	static float param_stream1[depth2];
	static float param_stream2[depth2];
	static float param_stream3[depth2];
	static float param_stream4[depth2];

	float out_stream[16]; //use BRAM port


//-----------------------------Configure registers ----------------------------------
	 FILE *f2;


	 int MIW1 = 4*INPUT_SIZE*hiddenUnitsLayer1;
	 //int MIW2 = 4*hiddenUnitsLayer1*hiddenUnitsLayer2;

	 cout<<"MaxW_input1:"<< MIW1<<'\n';

	 int MRW1 = 4*hiddenUnitsLayer1*hiddenUnitsLayer1+4*2*hiddenUnitsLayer1*hiddenUnitsLayer2+4*2*hiddenUnitsLayer2*hiddenUnitsLayer3;
	 //int MRW2 = 4*hiddenUnitsLayer1*hiddenUnitsLayer2;

	 cout<<"MaxW_recur1:"<< MRW1<<'\n';

	 int sizeBias = 4*hiddenUnitsLayer1+4*hiddenUnitsLayer2+4*hiddenUnitsLayer3;
	 int fcWsize = hiddenUnitsLayer3;

	 int total = MIW1+MRW1+sizeBias+fcWsize;

	 cout<<"total parameters:"<< total<<'\n';

     int P;
	// printf("---------start-------------------------------- \n");
	// for(P=0;P<29700;P++)
	 for(P=0;P<2;P++)//106450
	 {
		//f1=fopen("result.dat","a");
		if(P>0)
		{
			new_net=0;
			f2=fopen("./PredictedSignalAll_16bit.txt", "a");


			 if (!f2)
			 {
				cout << "File not created!\n\n";
			 }
			 else
			 {
//				cout << "File created successfully!\n\n";
				//f2.close();
			 }

			 for(i=0;i<INPUT_SIZE;i++)
			 {
				 in_stream[i] = input_arr[i+P*16];
//				 cout<<"in_stream["<<i<<"]=  " << in_stream[i]<< "\n";
			 }
			//in_stream[0] = input_arr[P];
		}
		else
		{

			f2=fopen("./PredictedSignalAll_16bit.txt", "w");


			 if (!f2)
			 {
				cout << "File not created!\n\n";
			 }
			 else
			 {
				//cout << "File created successfully!\n\n";
				//f2.close();
			 }

			 for(i=0;i<INPUT_SIZE;i++)
			 {

				 in_stream[i] = input_arr[i+P*16];
//				 cout<<"in_stream["<<i<<"]=  " << in_stream[i]<< "\n";
			 }
			//in_stream[0] = input_arr[P];

			for(i=0;i<hiddenUnitsLayer1;i++)
			{

				in_stream[i+INPUT_SIZE] = fcW[i];
//				cout<<"in_stream["<<i+INPUT_SIZE<<"]=  " << in_stream[i+INPUT_SIZE]<< "\n";
			}
			for(i=0;i<181;i++)
			{

				in_stream[i+INPUT_SIZE+hiddenUnitsLayer1] = biasAll[i];
//				cout<<"in_stream["<<i+INPUT_SIZE+hiddenUnitsLayer1<<"]=  " << in_stream[i+INPUT_SIZE+hiddenUnitsLayer1]<< "\n";
			}


			//for(j=0;j<hiddenUnitsLayer1;j++)
			//{
				for(i=0;i<1365;i++)
				{
					param_stream1[i] 	 = inW[i];
				}
				//for(i=0;i<450;i++)
				//{
				//	param_stream1[i+465] = inRe[i+1860];
				//}
			//}
/*			for(i=0;i<450;i++)
			{
				param_stream1[i+915] = inRe[i+3660];
			}
*/

			for(i=0;i<1365;i++)
			{
				param_stream2[i] 	 = forW[i];
			}
/*			for(i=0;i<450;i++)
			{
				param_stream2[i+465] = inRe[i+1860+450];
			}
			for(i=0;i<450;i++)
			{
				param_stream2[i+930] = inRe[i+3660+450];
			}
*/
			for(i=0;i<1365;i++)
			{
				param_stream3[i] 	 = cellW[i];
			}
/*			for(i=0;i<450;i++)
			{
				param_stream3[i+465] = inRe[i+1860+450+450];
			}
			for(i=0;i<450;i++)
			{
				param_stream3[i+930] = inRe[i+3660+450+450];
			}
*/
			for(i=0;i<1365;i++)
			{
				param_stream4[i] 	 = outW[i];
			}
/*			for(i=0;i<450;i++)
			{
				param_stream4[i+465] = inRe[i+1860+450+450+450];
			}
			for(i=0;i<450;i++)
			{
				param_stream4[i+930] = inRe[i+3660+450+450+450];
			}
*/
		}

    ///Controller(in_stream, weights_stream, out_stream, &Config, new_net);                // call the controller
    ///Controller(in_stream, out_stream, new_net);

		Controller(in_stream, param_stream1, param_stream2, param_stream3, param_stream4, out_stream, new_net);


	///out_stream.read(out);
	//out_stream>>out;
	Output[0] = out_stream[0] ;
	cout<<"Output["<<P<<"]=  " << Output[0] << "\n";
//	fprintf(f2, " Predicted:  %f,   Actual:  %f \n", Output[0]);//, labels[P]);
	fprintf(f2, "%f, \n", Output[0]);//, labels[P]);
	fclose(f2);

/*		for(k=0;k<2*hiddenUnitsLayer1;k++)
		{

				Output[k] = out_stream[k+1] ;
				cout<<"(hidden+cell)["<<k<<"]=  " << Output[k] << "\n";
		}
*/

    }

    /*for(l=0;l<INPUT_SIZE;l++)
    {
    	fprintf(f2, " Predicted:  %f,   Actual:  %f \n", Output[l], labels[l]);
        //cout<<"Output["<<i<<"]=  " << Output[i] << "\n";
    }*/

    //cout<< '\n' <<'\n'<<"tanh(2):" <<tan<fp1,fp1>(2)<< '\n';



	// fclose(f1);
	//fprintf(f2, "Actual: %f \n", labels[P]);

	/* if (get_label(Output,10)==labels[P])
	 {
		 printf(" Matched \n");
		 correct=correct+1;
	 }
	 else
		 printf(" UnMatched \n");
	}*/
	//printf(" Accuracy Final: %f\n", correct);
   	    /*
   		// Compare the results file with the golden results
   		retval = system("diff --brief -w result.dat result.golden.dat");
   		if (retval != 0)
   		{
   			printf("Test failed  !!!\n");
   			retval=1;
   		}
   		else
   		{
   			printf("Test passed !\n");
   		}
    // printf("last=%d \n",last);

   	     */
//	 }
   		return 0;
}


