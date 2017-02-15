//
//  User.m
//  INNOVATIVE ITERATION PROJECT
//
//  Created by Varun Rathi
//  AddIntervalViewController.h
//  SetMyPace
//
//     02/02/17.
//   Copyright © 2017 varunrathi28. All rights reserved. on 00/00/00.
//  Copyright © 2016 INNOVATIVE ITERATION SOFTWARE SOLUTIONS. All rights reserved.
//

#import "User.h"

@implementation User

-(BOOL)isValidateUserForLogin
{
    CommonUtility *objUtility = [[CommonUtility alloc]init];

    //================BLANK FIELD VALIDATION===========//
    if(self.strEmail.length <= 0 ||  self.strPassword.length <=  0 )
    {
        
        if(self.strEmail.length <= 0)
        {
            self.strValidationMessage = @"Email cannot be empty.";
            return false;
        }
        if(self.strPassword.length <= 0)
        {
            self.strValidationMessage = @"Password cannot be empty.";
            return false;
        }
    }
    if(![objUtility isValidEmailAddress:self.strEmail])
    {
        self.strValidationMessage = @"Invalid Email Address.";
        return false;
    }
    else
    {
        return true;
    }
    return true;
}

-(BOOL)isValidateUserForRegistration
{
    CommonUtility *objUtility = [[CommonUtility alloc]init];
    
    if(self.strEmail.length <= 0 || self.strPassword.length <= 0 || self.strUserFullname.length <= 0 || self.strPhoneNumber.length <= 0)
    {
        if(self.strEmail.length <= 0)
        {
            self.strValidationMessage = @"Email cannot be empty.";
            return false;
        }
        if(self.strPassword.length <= 0)
        {
            self.strValidationMessage = @"Password cannot be empty.";
            return false;
        }
        if(self.strUserFullname.length <= 0)
        {
            self.strValidationMessage = @"Fullname cannot be empty.";
            return false;
        }
        if(self.strUserFullname.length <= 0)
        {
            self.strValidationMessage = @"Fullname cannot be empty.";
            return false;
        }
        if(self.strPhoneNumber.length <= 0)
        {
            self.strValidationMessage = @"Phone number cannot be empty.";
            return false;
        }
    }
    else if(![objUtility isValidEmailAddress:self.strEmail])
    {
        self.strValidationMessage = @"Invalid Email Address.";
        return false;
    }
    if(self.strPhoneNumber.length != 10)
    {
        self.strValidationMessage = @"Phone number must contain 10 digits.";
        return false;
    }
    else
    {
        return true;
    }
    return true;
}

-(BOOL)isValidateSocialMediaUserForRegistration
{
    CommonUtility *objUtility = [[CommonUtility alloc]init];
    
    if(self.strUserFullname.length <= 0 || self.strEmail.length <= 0)
    {
        if(self.strUserFullname.length <= 0)
        {
            self.strValidationMessage = @"Fullname cannot be empty.";
            return false;
        }
        if(self.strEmail.length <= 0)
        {
            self.strValidationMessage = @"Email cannot be empty.";
            return false;
        }
    }
    else if(![objUtility isValidEmailAddress:self.strEmail])
    {
        self.strValidationMessage = @"Invalid Email Address.";
        return false;
    }
    else
    {
        return true;
    }
    return true;
}

-(BOOL)isValidateUserForUpdation
{
    CommonUtility *objUtility = [[CommonUtility alloc]init];
    
    if(self.strUserFullname.length <= 0 || self.strEmail.length <= 0 || self.strPhoneNumber.length <= 0 || self.strGender.length <= 0)
    {
        if(self.strUserFullname.length <= 0)
        {
            self.strValidationMessage = @"Fullname cannot be empty.";
            return false;
        }
        if(self.strEmail.length <= 0)
        {
            self.strValidationMessage = @"Email cannot be empty.";
            return false;
        }
        if(self.strPhoneNumber.length <= 0)
        {
            self.strValidationMessage = @"Mobile Number cannot be empty.";
            return false;
        }
        if(self.strGender.length <= 0)
        {
            self.strValidationMessage = @"Gender cannot be empty.";
            return false;
        }
    }
    else if(![objUtility isValidEmailAddress:self.strEmail])
    {
        self.strValidationMessage = @"Invalid Email Address.";
        return false;
    }
    else
    {
        return true;
    }
    return true;
}

@end
