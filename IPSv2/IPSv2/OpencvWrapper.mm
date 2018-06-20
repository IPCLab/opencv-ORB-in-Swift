//
//  OpencvWrapper.m
//  IPSv2
//
//  Created by 邱嵩傑 on 2018/4/28.
//  Copyright © 2018年 邱嵩傑. All rights reserved.
//

#import "OpencvWrapper.h"
#import "opencv2/opencv.hpp"
#import <UIKit/UiKit.h>
#import <opencv2/imgcodecs/ios.h>
#import <IPSv2-Swift.h>
#import "pictureData.h"

using namespace cv;
using namespace std;

@implementation OpencvWrapper
+(UIImage*)getdescriptors:(UIImage*)picture{
    //UIImageToMat
    Mat imageMat;
    UIImageToMat(picture, imageMat);
    Mat Gray;
    cv::cvtColor(imageMat,Gray,COLOR_BGR2GRAY);
    
    //orb
    vector<KeyPoint> kp;
    Mat descriptors;
    Ptr<ORB> orb = ORB::create(50000);
    orb->detectAndCompute(Gray, Mat(),kp, descriptors);
    
    Mat orbimage;
    UIImage* final_image;
    drawKeypoints( Gray, kp, orbimage,Scalar::all(-1),DrawMatchesFlags::DEFAULT);
    
    
    Mat dst;
    transpose(orbimage, dst);
    flip(dst, orbimage, 1);
    
    final_image = MatToUIImage(orbimage);
    
    return final_image;
}

//從db取照片做bow
/*+(void) bow:(NSMutableArray *)array {
    int categories_size = 20;
    BOWKMeansTrainer BOWtrainer(categories_size); // 分成20類
    Mat all_descriptors;
    
    for(int number = 0; number < [array count]; number++){
        //parse images
        //cout << array[number] << endl;
        //int pic_ID = array[number].picture_ID;======>Property 'picture_ID' not found on object of type 'id'
        int pic_ID = ((pictureData *)array[number])->picture_ID;
        cout << pic_ID;
        
        UIImage *pic = ((pictureData *)array[number])->picture_Image;
        Mat imageMat;
        UIImageToMat(pic, imageMat, true);
        
        
        vector<KeyPoint> kp;
        Mat descriptors;
        Ptr<ORB> orb = ORB::create(5000);
        orb->detectAndCompute(imageMat, Mat(),kp, descriptors);
         
        all_descriptors.push_back(descriptors);
        
    }
    Mat vocabulary = BOWtrainer.cluster(all_descriptors);
    
    Ptr<ml::SVM> *stor_svms; //分類器
    map<string,Mat> allsamples_bow;
    vector<string> category_name;
    for(int i=0;i<categories_size;i++)
    {
        Mat tem_Samples( 0, allsamples_bow.at( category_name[i] ).cols, allsamples_bow.at( category_name[i] ).type() ); //获取上一步构建好的bag of word
        Mat responses( 0, 1, CV_32SC1 );
        tem_Samples.push_back( allsamples_bow.at( category_name[i] ) );
        Mat posResponses( allsamples_bow.at( category_name[i]).rows, 1, CV_32SC1, Scalar::all(1) );
        responses.push_back( posResponses );
        
        for ( map<string,Mat>::iterator itr = allsamples_bow.begin(); itr != allsamples_bow.end(); ++itr )
        {
            if ( itr -> first == category_name[i] ) {
                continue;
            }
            tem_Samples.push_back( itr -> second );
            Mat response( itr -> second.rows, 1, CV_32SC1, Scalar::all( -1 ) );
            responses.push_back( response );
        }
        //设置训练参数
        stor_svms[i] = ml::SVM::create();
        stor_svms[i]->setType(ml::SVM::C_SVC);
        stor_svms[i]->setKernel(ml::SVM::LINEAR);
        stor_svms[i]->setGamma(3);
        stor_svms[i]->setTermCriteria(TermCriteria(CV_TERMCRIT_ITER, 100, 1e-6));
        
        stor_svms[i]->train( tem_Samples, cv::ml::ROW_SAMPLE, responses); //关键步骤, 进行svm训练器的构建
        
    }
    
    
    
}*/
@end
