//
//  NSArray+BestHandsArray.m
//  BlackJackHoldem31
//
//  Created by signity solutions on 1/21/15.
//  Copyright (c) 2015 signity solutions. All rights reserved.
//

#import "NSArray+BestHandsArray.h"
#import "AppDelegate.h"

@implementation NSArray (BestHandsArray)

+(NSArray*)bestHandsInFlopCardsWithOpencards:(NSArray*)myOpencards
{
    NSMutableArray *heartsArray =[[NSMutableArray alloc]init];
    NSMutableArray *spadesArray=[[NSMutableArray alloc]init];
    NSMutableArray *clubesArray=[[NSMutableArray alloc]init];
    NSMutableArray *diamondsArray=[[NSMutableArray alloc]init];
    NSMutableArray *cardsArray=[[NSMutableArray alloc]init];
    NSMutableArray *arrayScores=[[NSMutableArray alloc]init];
    NSMutableArray *bestArray=[[NSMutableArray alloc]init];
    for(int i=0;i<myOpencards.count;i++)
    {
        Card *card =[myOpencards objectAtIndex:i];
        NSMutableDictionary  *dict =[[NSMutableDictionary alloc]init];
        [dict setObject:card forKey:@"Card"];
        [dict setObject:@"HoleCard" forKey:@"Type"];
        [cardsArray addObject:dict];
    }
    for(int i =0;i<2;i++)
    {
        Card *card =[appDelegate().cummulativeCards objectAtIndex:i];
        NSMutableDictionary  *dict =[[NSMutableDictionary alloc]init];
        [dict setObject:card forKey:@"Card"];
        [dict setObject:@"CummunityCard" forKey:@"Type"];
        [cardsArray addObject:dict];
    }
    
    for(int i=0;i<4;i++)
    {
        Card *card =[[cardsArray valueForKey:@"Card"] objectAtIndex:i];
        NSString *suitString;
        switch (card.suit)
        {
            case SuitClubs:    suitString = @"Clubs"; break;
            case SuitDiamonds: suitString = @"Diamonds"; break;
            case SuitHearts:   suitString = @"Hearts"; break;
            case SuitSpades:   suitString = @"Spades"; break;
            default:           suitString = [NSString stringWithFormat:@"%d", card.suit];
        }
        NSString *valueString;
        switch (card.value)
        {
            case CardAce:   valueString = @"11"; break;
            case CardJack:  valueString = @"10"; break;
            case CardQueen: valueString = @"10"; break;
            case CardKing:  valueString = @"10"; break;
            default:        valueString = [NSString stringWithFormat:@"%d", card.value];
        }
        int cardValue =[valueString intValue];
        NSMutableDictionary  *dict =[[NSMutableDictionary alloc]init];
        if([suitString isEqual:@"Clubs"])
        {
            [dict setObject:card forKey:@"Card"];
            [dict setObject:[NSNumber numberWithInt:cardValue] forKey:@"Value"];
            [dict setObject:suitString forKey:@"Suit"];
            [dict setObject:[[cardsArray valueForKey:@"Type"] objectAtIndex:i] forKey:@"Type"];
            [clubesArray addObject:dict];
        }
        else if ([suitString isEqual:@"Diamonds"])
        {
            [dict setObject:card forKey:@"Card"];
            [dict setObject:[NSNumber numberWithInt:cardValue] forKey:@"Value"];
            [dict setObject:suitString forKey:@"Suit"];
            [dict setObject:[[cardsArray valueForKey:@"Type"] objectAtIndex:i] forKey:@"Type"];
            [diamondsArray addObject:dict];
        }
        else if ([suitString isEqual:@"Hearts"])
        {
            [dict setObject:card forKey:@"Card"];
            [dict setObject:[NSNumber numberWithInt:cardValue] forKey:@"Value"];
            [dict setObject:suitString forKey:@"Suit"];
            [dict setObject:[[cardsArray valueForKey:@"Type"] objectAtIndex:i] forKey:@"Type"];
            [heartsArray addObject:dict];
        }
        else if ([suitString isEqual:@"Spades"])
        {
            [dict setObject:card forKey:@"Card"];
            [dict setObject:[NSNumber numberWithInt:cardValue] forKey:@"Value"];
            [dict setObject:suitString forKey:@"Suit"];
            [dict setObject:[[cardsArray valueForKey:@"Type"] objectAtIndex:i] forKey:@"Type"];
            [spadesArray addObject:dict];
        }
        
    }
    if(heartsArray.count>0)
    {
        NSMutableDictionary  *dict =[[NSMutableDictionary alloc]init];
        NSMutableArray *filteredArray = [heartsArray mutableCopy];
        NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"Value" ascending:NO];
        [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
        [heartsArray removeAllObjects];
        [heartsArray addObjectsFromArray:filteredArray];
        int total=0;
        for(int i=0;i<heartsArray.count;i++)
        {
            total =total+[[[heartsArray valueForKey:@"Value"] objectAtIndex:i] intValue];
        }
        [dict setObject:@"heartsArray" forKey:@"Suit"];
        [dict setObject:heartsArray forKey:@"Array"];
        [dict setObject:[NSNumber numberWithInt:heartsArray.count] forKey:@"Count"];
        [dict setObject:[NSNumber numberWithInt:total] forKey:@"Total"];
        [arrayScores addObject:dict];
    }
    if(spadesArray.count>0)
    {
        NSMutableDictionary  *dict =[[NSMutableDictionary alloc]init];
        NSMutableArray *filteredArray = [spadesArray mutableCopy];
        NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"Value" ascending:NO];
        [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
        [spadesArray removeAllObjects];
        [spadesArray addObjectsFromArray:filteredArray];
        int total=0;
        for(int i=0;i<spadesArray.count;i++)
        {
            total =total+[[[spadesArray valueForKey:@"Value"] objectAtIndex:i] intValue];
        }
        [dict setObject:@"spadesArray" forKey:@"Suit"];
        [dict setObject:spadesArray forKey:@"Array"];
        [dict setObject:[NSNumber numberWithInt:spadesArray.count] forKey:@"Count"];
        [dict setObject:[NSNumber numberWithInt:total] forKey:@"Total"];
        [arrayScores addObject:dict];
    }
    if(diamondsArray.count>0)
    {
        NSMutableDictionary  *dict =[[NSMutableDictionary alloc]init];
        NSMutableArray *filteredArray = [diamondsArray mutableCopy];
        NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"Value" ascending:NO];
        [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
        [diamondsArray removeAllObjects];
        [diamondsArray addObjectsFromArray:filteredArray];
        int total=0;
        for(int i=0;i<diamondsArray.count;i++)
        {
            total =total+[[[diamondsArray valueForKey:@"Value"] objectAtIndex:i] intValue];
        }
        [dict setObject:@"diamondsArray" forKey:@"Suit"];
        [dict setObject:diamondsArray forKey:@"Array"];
        [dict setObject:[NSNumber numberWithInt:diamondsArray.count] forKey:@"Count"];
        [dict setObject:[NSNumber numberWithInt:total] forKey:@"Total"];
        [arrayScores addObject:dict];
    }
    if(clubesArray.count>0)
    {
        NSMutableDictionary  *dict =[[NSMutableDictionary alloc]init];
        NSMutableArray *filteredArray = [clubesArray mutableCopy];
        NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"Value" ascending:NO];
        [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
        [clubesArray removeAllObjects];
        [clubesArray addObjectsFromArray:filteredArray];
        int total=0;
        for(int i=0;i<clubesArray.count;i++)
        {
            total =total+[[[clubesArray valueForKey:@"Value"] objectAtIndex:i] intValue];
        }
        [dict setObject:@"clubesArray" forKey:@"Suit"];
        [dict setObject:clubesArray forKey:@"Array"];
        [dict setObject:[NSNumber numberWithInt:clubesArray.count] forKey:@"Count"];
        [dict setObject:[NSNumber numberWithInt:total] forKey:@"Total"];
        [arrayScores addObject:dict];
    }
    NSMutableArray *filteredArray = [arrayScores mutableCopy];
    NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"Total" ascending:NO];
    [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
    [arrayScores removeAllObjects];
    [arrayScores addObjectsFromArray:filteredArray];
    if([[[arrayScores valueForKey:@"Suit"] objectAtIndex:0] isEqual:@"clubesArray"])
    {   if([[clubesArray valueForKey:@"Type"] containsObject:@"HoleCard"]){
        [bestArray addObjectsFromArray:clubesArray];
        NSMutableArray *filteredArray = [[NSMutableArray alloc]init];
        for(int i=1;i<arrayScores.count;i++)
        {
            [filteredArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:i]];
        }
        NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"Value" ascending:NO];
        [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
        [bestArray addObjectsFromArray:filteredArray];
    }
    else{
        [bestArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:1]];
        NSMutableArray *filteredArray = [[NSMutableArray alloc]init];
        [bestArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:0]];
        for(int i=2;i<arrayScores.count;i++)
        {
            [filteredArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:i]];
        }
        NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"Value" ascending:NO];
        [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
        [bestArray addObjectsFromArray:filteredArray];
    }
        
    }
    else if ([[[arrayScores valueForKey:@"Suit"] objectAtIndex:0] isEqual:@"heartsArray"])
    {  if([[heartsArray valueForKey:@"Type"] containsObject:@"HoleCard"]){
        [bestArray addObjectsFromArray:heartsArray];
        NSMutableArray *filteredArray = [[NSMutableArray alloc]init];
        for(int i=1;i<arrayScores.count;i++)
        {
            [filteredArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:i]];
        }
        NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"Value" ascending:NO];
        [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
        [bestArray addObjectsFromArray:filteredArray];
    }
    else{
        [bestArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:1]];
        NSMutableArray *filteredArray = [[NSMutableArray alloc]init];
        [bestArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:0]];
        for(int i=2;i<arrayScores.count;i++)
        {
            [filteredArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:i]];
        }
        NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"Value" ascending:NO];
        [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
        [bestArray addObjectsFromArray:filteredArray];
    }
    }
    else if ([[[arrayScores valueForKey:@"Suit"] objectAtIndex:0] isEqual:@"diamondsArray"])
    { if([[diamondsArray valueForKey:@"Type"] containsObject:@"HoleCard"]){
        [bestArray addObjectsFromArray:diamondsArray];
        NSMutableArray *filteredArray = [[NSMutableArray alloc]init];
        for(int i=1;i<arrayScores.count;i++)
        {
            [filteredArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:i]];
        }
        NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"Value" ascending:NO];
        [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
        [bestArray addObjectsFromArray:filteredArray];
    }
    else{
        [bestArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:1]];
        NSMutableArray *filteredArray = [[NSMutableArray alloc]init];
        [bestArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:0]];
        for(int i=2;i<arrayScores.count;i++)
        {
            [filteredArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:i]];
        }
        NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"Value" ascending:NO];
        [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
    }
    }
    else if ([[[arrayScores valueForKey:@"Suit"] objectAtIndex:0] isEqual:@"spadesArray"])
    {  if([[spadesArray valueForKey:@"Type"] containsObject:@"HoleCard"]){
        [bestArray addObjectsFromArray:spadesArray];
        NSMutableArray *filteredArray = [[NSMutableArray alloc]init];
        for(int i=1;i<arrayScores.count;i++)
        {
            [filteredArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:i]];
        }
        NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"Value" ascending:NO];
        [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
        [bestArray addObjectsFromArray:filteredArray];
    }
    else{
        [bestArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:1]];
        NSMutableArray *filteredArray = [[NSMutableArray alloc]init];
        [bestArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:0]];
        for(int i=2;i<arrayScores.count;i++)
        {
            [filteredArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:i]];
        }
        NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"Value" ascending:NO];
        [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
    }
    }
    NSMutableArray *bestHands =[[NSMutableArray alloc]init];
    if(bestArray.count>2){
    for(int z=0;z<3;z++)
    {
        [bestHands addObject:[bestArray objectAtIndex:z]];
    }
    if([[bestHands valueForKey:@"Type"] containsObject:@"HoleCard"])
    {
        NSLog(@"Contains");
    }
    else
    {
        [bestHands removeObjectAtIndex:2];
        [bestHands addObject:[bestArray objectAtIndex:3]];
    }
    }
    else{
        for(int z=0;z<2;z++)
        {
            [bestHands addObject:[bestArray objectAtIndex:z]];
        }
        if([[bestHands valueForKey:@"Type"] containsObject:@"HoleCard"])
        {
            NSLog(@"Contains");
        }
    }
    return bestHands;
}
+(NSArray*)bestHandsInTurnCardsWithOpencards:(NSArray*)myOpencards
{
    NSMutableArray *heartsArray =[[NSMutableArray alloc]init];
    NSMutableArray *spadesArray=[[NSMutableArray alloc]init];
    NSMutableArray *clubesArray=[[NSMutableArray alloc]init];
    NSMutableArray *diamondsArray=[[NSMutableArray alloc]init];
    NSMutableArray *cardsArray=[[NSMutableArray alloc]init];
    NSMutableArray *arrayScores=[[NSMutableArray alloc]init];
    NSMutableArray *bestArray=[[NSMutableArray alloc]init];
    for(int i=0;i<myOpencards.count;i++)
    {
        Card *card =[myOpencards objectAtIndex:i];
        NSMutableDictionary  *dict =[[NSMutableDictionary alloc]init];
        [dict setObject:card forKey:@"Card"];
        [dict setObject:@"HoleCard" forKey:@"Type"];
        [cardsArray addObject:dict];
    }
    for(int i =0;i<4;i++)
    {
        Card *card =[appDelegate().cummulativeCards objectAtIndex:i];
        NSMutableDictionary  *dict =[[NSMutableDictionary alloc]init];
        [dict setObject:card forKey:@"Card"];
        [dict setObject:@"CummunityCard" forKey:@"Type"];
        [cardsArray addObject:dict];
    }
    
    for(int i=0;i<6;i++)
    {
        Card *card =[[cardsArray valueForKey:@"Card"] objectAtIndex:i];
        NSString *suitString;
        switch (card.suit)
        {
            case SuitClubs:    suitString = @"Clubs"; break;
            case SuitDiamonds: suitString = @"Diamonds"; break;
            case SuitHearts:   suitString = @"Hearts"; break;
            case SuitSpades:   suitString = @"Spades"; break;
            default:           suitString = [NSString stringWithFormat:@"%d", card.suit];
        }
        NSString *valueString;
        switch (card.value)
        {
            case CardAce:   valueString = @"11"; break;
            case CardJack:  valueString = @"10"; break;
            case CardQueen: valueString = @"10"; break;
            case CardKing:  valueString = @"10"; break;
            default:        valueString = [NSString stringWithFormat:@"%d", card.value];
        }
        int cardValue =[valueString intValue];
        NSMutableDictionary  *dict =[[NSMutableDictionary alloc]init];
        if([suitString isEqual:@"Clubs"])
        {
            [dict setObject:card forKey:@"Card"];
            [dict setObject:[NSNumber numberWithInt:cardValue] forKey:@"Value"];
            [dict setObject:suitString forKey:@"Suit"];
            [dict setObject:[[cardsArray valueForKey:@"Type"] objectAtIndex:i] forKey:@"Type"];
            [clubesArray addObject:dict];
        }
        else if ([suitString isEqual:@"Diamonds"])
        {
            [dict setObject:card forKey:@"Card"];
            [dict setObject:[NSNumber numberWithInt:cardValue] forKey:@"Value"];
            [dict setObject:suitString forKey:@"Suit"];
            [dict setObject:[[cardsArray valueForKey:@"Type"] objectAtIndex:i] forKey:@"Type"];
            [diamondsArray addObject:dict];
        }
        else if ([suitString isEqual:@"Hearts"])
        {
            [dict setObject:card forKey:@"Card"];
            [dict setObject:[NSNumber numberWithInt:cardValue] forKey:@"Value"];
            [dict setObject:suitString forKey:@"Suit"];
            [dict setObject:[[cardsArray valueForKey:@"Type"] objectAtIndex:i] forKey:@"Type"];
            [heartsArray addObject:dict];
        }
        else if ([suitString isEqual:@"Spades"])
        {
            [dict setObject:card forKey:@"Card"];
            [dict setObject:[NSNumber numberWithInt:cardValue] forKey:@"Value"];
            [dict setObject:suitString forKey:@"Suit"];
            [dict setObject:[[cardsArray valueForKey:@"Type"] objectAtIndex:i] forKey:@"Type"];
            [spadesArray addObject:dict];
        }
        
    }
    if(heartsArray.count>0)
    {
        NSMutableDictionary  *dict =[[NSMutableDictionary alloc]init];
        NSMutableArray *filteredArray = [heartsArray mutableCopy];
        NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"Value" ascending:NO];
        [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
        [heartsArray removeAllObjects];
        [heartsArray addObjectsFromArray:filteredArray];
        int total=0;
        for(int i=0;i<heartsArray.count;i++)
        {
            total =total+[[[heartsArray valueForKey:@"Value"] objectAtIndex:i] intValue];
        }
        [dict setObject:@"heartsArray" forKey:@"Suit"];
        [dict setObject:heartsArray forKey:@"Array"];
        [dict setObject:[NSNumber numberWithInt:heartsArray.count] forKey:@"Count"];
        [dict setObject:[NSNumber numberWithInt:total] forKey:@"Total"];
        [arrayScores addObject:dict];
    }
    if(spadesArray.count>0)
    {
        NSMutableDictionary  *dict =[[NSMutableDictionary alloc]init];
        NSMutableArray *filteredArray = [spadesArray mutableCopy];
        NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"Value" ascending:NO];
        [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
        [spadesArray removeAllObjects];
        [spadesArray addObjectsFromArray:filteredArray];
        int total=0;
        for(int i=0;i<spadesArray.count;i++)
        {
            total =total+[[[spadesArray valueForKey:@"Value"] objectAtIndex:i] intValue];
        }
        [dict setObject:@"spadesArray" forKey:@"Suit"];
        [dict setObject:spadesArray forKey:@"Array"];
        [dict setObject:[NSNumber numberWithInt:spadesArray.count] forKey:@"Count"];
        [dict setObject:[NSNumber numberWithInt:total] forKey:@"Total"];
        [arrayScores addObject:dict];
    }
    if(diamondsArray.count>0)
    {
        NSMutableDictionary  *dict =[[NSMutableDictionary alloc]init];
        NSMutableArray *filteredArray = [diamondsArray mutableCopy];
        NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"Value" ascending:NO];
        [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
        [diamondsArray removeAllObjects];
        [diamondsArray addObjectsFromArray:filteredArray];
        int total=0;
        for(int i=0;i<diamondsArray.count;i++)
        {
            total =total+[[[diamondsArray valueForKey:@"Value"] objectAtIndex:i] intValue];
        }
        [dict setObject:@"diamondsArray" forKey:@"Suit"];
        [dict setObject:diamondsArray forKey:@"Array"];
        [dict setObject:[NSNumber numberWithInt:diamondsArray.count] forKey:@"Count"];
        [dict setObject:[NSNumber numberWithInt:total] forKey:@"Total"];
        [arrayScores addObject:dict];
    }
    if(clubesArray.count>0)
    {
        NSMutableDictionary  *dict =[[NSMutableDictionary alloc]init];
        NSMutableArray *filteredArray = [clubesArray mutableCopy];
        NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"Value" ascending:NO];
        [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
        [clubesArray removeAllObjects];
        [clubesArray addObjectsFromArray:filteredArray];
        int total=0;
        for(int i=0;i<clubesArray.count;i++)
        {
            total =total+[[[clubesArray valueForKey:@"Value"] objectAtIndex:i] intValue];
        }
        [dict setObject:@"clubesArray" forKey:@"Suit"];
        [dict setObject:clubesArray forKey:@"Array"];
        [dict setObject:[NSNumber numberWithInt:clubesArray.count] forKey:@"Count"];
        [dict setObject:[NSNumber numberWithInt:total] forKey:@"Total"];
        [arrayScores addObject:dict];
    }
    NSMutableArray *filteredArray = [arrayScores mutableCopy];
    NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"Total" ascending:NO];
    [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
    [arrayScores removeAllObjects];
    [arrayScores addObjectsFromArray:filteredArray];
    if([[[arrayScores valueForKey:@"Suit"] objectAtIndex:0] isEqual:@"clubesArray"])
    {   if([[clubesArray valueForKey:@"Type"] containsObject:@"HoleCard"]){
        [bestArray addObjectsFromArray:clubesArray];
        NSMutableArray *filteredArray = [[NSMutableArray alloc]init];
        for(int i=1;i<arrayScores.count;i++)
        {
            [filteredArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:i]];
        }
        NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"Value" ascending:NO];
        [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
        [bestArray addObjectsFromArray:filteredArray];
    }
    else{
       [bestArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:1]];
        NSMutableArray *filteredArray = [[NSMutableArray alloc]init];
        [bestArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:0]];
        for(int i=2;i<arrayScores.count;i++)
        {
            [filteredArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:i]];
        }
        NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"Value" ascending:NO];
        [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
        [bestArray addObjectsFromArray:filteredArray];
    }
        
    }
    else if ([[[arrayScores valueForKey:@"Suit"] objectAtIndex:0] isEqual:@"heartsArray"])
    {  if([[heartsArray valueForKey:@"Type"] containsObject:@"HoleCard"]){
        [bestArray addObjectsFromArray:heartsArray];
        NSMutableArray *filteredArray = [[NSMutableArray alloc]init];
        for(int i=1;i<arrayScores.count;i++)
        {
            [filteredArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:i]];
        }
        NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"Value" ascending:NO];
        [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
        [bestArray addObjectsFromArray:filteredArray];
    }
    else{
        [bestArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:1]];
        NSMutableArray *filteredArray = [[NSMutableArray alloc]init];
        [bestArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:0]];
        for(int i=2;i<arrayScores.count;i++)
        {
            [filteredArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:i]];
        }
        NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"Value" ascending:NO];
        [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
        [bestArray addObjectsFromArray:filteredArray];
    }
    }
    else if ([[[arrayScores valueForKey:@"Suit"] objectAtIndex:0] isEqual:@"diamondsArray"])
    { if([[diamondsArray valueForKey:@"Type"] containsObject:@"HoleCard"]){
        [bestArray addObjectsFromArray:diamondsArray];
        NSMutableArray *filteredArray = [[NSMutableArray alloc]init];
        for(int i=1;i<arrayScores.count;i++)
        {
            [filteredArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:i]];
        }
        NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"Value" ascending:NO];
        [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
        [bestArray addObjectsFromArray:filteredArray];
    }
    else{
        [bestArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:1]];
        NSMutableArray *filteredArray = [[NSMutableArray alloc]init];
        [bestArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:0]];
        for(int i=2;i<arrayScores.count;i++)
        {
            [filteredArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:i]];
        }
        NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"Value" ascending:NO];
        [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
    }
    }
    else if ([[[arrayScores valueForKey:@"Suit"] objectAtIndex:0] isEqual:@"spadesArray"])
    {  if([[spadesArray valueForKey:@"Type"] containsObject:@"HoleCard"]){
        [bestArray addObjectsFromArray:spadesArray];
        NSMutableArray *filteredArray = [[NSMutableArray alloc]init];
        for(int i=1;i<arrayScores.count;i++)
        {
            [filteredArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:i]];
        }
        NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"Value" ascending:NO];
        [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
        [bestArray addObjectsFromArray:filteredArray];
    }
    else{
        [bestArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:1]];
        NSMutableArray *filteredArray = [[NSMutableArray alloc]init];
        [bestArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:0]];
        for(int i=2;i<arrayScores.count;i++)
        {
            [filteredArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:i]];
        }
        NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"Value" ascending:NO];
        [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
    }
    }
    NSMutableArray *bestHands =[[NSMutableArray alloc]init];
    if(bestArray.count>2){
    for(int z=0;z<3;z++)
    {
        [bestHands addObject:[bestArray objectAtIndex:z]];
    }
    if([[bestHands valueForKey:@"Type"] containsObject:@"HoleCard"])
    {
        NSLog(@"Contains");
    }
    else
    {
        [bestHands removeObjectAtIndex:2];
        [bestHands addObject:[bestArray objectAtIndex:3]];
        if([[bestHands valueForKey:@"Type"] containsObject:@"HoleCard"])
        {
            NSLog(@"Contains");
        }
        else
        {
            [bestHands removeObjectAtIndex:2];
            [bestHands addObject:[bestArray objectAtIndex:4]];
            if([[bestHands valueForKey:@"Type"] containsObject:@"HoleCard"])
            {
                NSLog(@"Contains");
            }
            else
            {
                [bestHands removeObjectAtIndex:2];
                [bestHands addObject:[bestArray objectAtIndex:5]];
            }
        }
    }
    }
    else{
            for(int z=0;z<2;z++)
            {
                [bestHands addObject:[bestArray objectAtIndex:z]];
            }
            if([[bestHands valueForKey:@"Type"] containsObject:@"HoleCard"])
            {
                NSLog(@"Contains");
            }
    }
    return bestHands;
}
+(NSArray*)bestHandsInRiverCardsWithOpencards:(NSArray*)myOpencards{
    NSMutableArray *heartsArray =[[NSMutableArray alloc]init];
    NSMutableArray *spadesArray=[[NSMutableArray alloc]init];
    NSMutableArray *clubesArray=[[NSMutableArray alloc]init];
    NSMutableArray *diamondsArray=[[NSMutableArray alloc]init];
    NSMutableArray *cardsArray=[[NSMutableArray alloc]init];
    NSMutableArray *arrayScores=[[NSMutableArray alloc]init];
    NSMutableArray *bestArray=[[NSMutableArray alloc]init];
    for(int i=0;i<myOpencards.count;i++)
    {
        Card *card =[myOpencards objectAtIndex:i];
        NSMutableDictionary  *dict =[[NSMutableDictionary alloc]init];
        [dict setObject:card forKey:@"Card"];
        [dict setObject:@"HoleCard" forKey:@"Type"];
        [cardsArray addObject:dict];
    }
    for(int i =0;i<5;i++)
    {
        Card *card =[appDelegate().cummulativeCards objectAtIndex:i];
        NSMutableDictionary  *dict =[[NSMutableDictionary alloc]init];
        [dict setObject:card forKey:@"Card"];
        [dict setObject:@"CummunityCard" forKey:@"Type"];
        [cardsArray addObject:dict];
    }
    
    for(int i=0;i<7;i++)
    {
        Card *card =[[cardsArray valueForKey:@"Card"] objectAtIndex:i];
        NSString *suitString;
        switch (card.suit)
        {
            case SuitClubs:    suitString = @"Clubs"; break;
            case SuitDiamonds: suitString = @"Diamonds"; break;
            case SuitHearts:   suitString = @"Hearts"; break;
            case SuitSpades:   suitString = @"Spades"; break;
            default:           suitString = [NSString stringWithFormat:@"%d", card.suit];
        }
        NSString *valueString;
        switch (card.value)
        {
            case CardAce:   valueString = @"11"; break;
            case CardJack:  valueString = @"10"; break;
            case CardQueen: valueString = @"10"; break;
            case CardKing:  valueString = @"10"; break;
            default:        valueString = [NSString stringWithFormat:@"%d", card.value];
        }
        int cardValue =[valueString intValue];
        NSMutableDictionary  *dict =[[NSMutableDictionary alloc]init];
        if([suitString isEqual:@"Clubs"])
        {
            [dict setObject:card forKey:@"Card"];
            [dict setObject:[NSNumber numberWithInt:cardValue] forKey:@"Value"];
            [dict setObject:suitString forKey:@"Suit"];
            [dict setObject:[[cardsArray valueForKey:@"Type"] objectAtIndex:i] forKey:@"Type"];
            [clubesArray addObject:dict];
        }
        else if ([suitString isEqual:@"Diamonds"])
        {
            [dict setObject:card forKey:@"Card"];
            [dict setObject:[NSNumber numberWithInt:cardValue] forKey:@"Value"];
            [dict setObject:suitString forKey:@"Suit"];
            [dict setObject:[[cardsArray valueForKey:@"Type"] objectAtIndex:i] forKey:@"Type"];
            [diamondsArray addObject:dict];
        }
        else if ([suitString isEqual:@"Hearts"])
        {
            [dict setObject:card forKey:@"Card"];
            [dict setObject:[NSNumber numberWithInt:cardValue] forKey:@"Value"];
            [dict setObject:suitString forKey:@"Suit"];
            [dict setObject:[[cardsArray valueForKey:@"Type"] objectAtIndex:i] forKey:@"Type"];
            [heartsArray addObject:dict];
        }
        else if ([suitString isEqual:@"Spades"])
        {
            [dict setObject:card forKey:@"Card"];
            [dict setObject:[NSNumber numberWithInt:cardValue] forKey:@"Value"];
            [dict setObject:suitString forKey:@"Suit"];
            [dict setObject:[[cardsArray valueForKey:@"Type"] objectAtIndex:i] forKey:@"Type"];
            [spadesArray addObject:dict];
        }
    }
    if(heartsArray.count>0)
    {
        NSMutableDictionary  *dict =[[NSMutableDictionary alloc]init];
        NSMutableArray *filteredArray = [heartsArray mutableCopy];
        NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"Value" ascending:NO];
        [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
        [heartsArray removeAllObjects];
        [heartsArray addObjectsFromArray:filteredArray];
        int total=0;
        for(int i=0;i<heartsArray.count;i++)
        {
            total =total+[[[heartsArray valueForKey:@"Value"] objectAtIndex:i] intValue];
        }
        [dict setObject:@"heartsArray" forKey:@"Suit"];
        [dict setObject:heartsArray forKey:@"Array"];
        [dict setObject:[NSNumber numberWithInt:heartsArray.count] forKey:@"Count"];
        [dict setObject:[NSNumber numberWithInt:total] forKey:@"Total"];
        [arrayScores addObject:dict];
    }
    if(spadesArray.count>0)
    {
        NSMutableDictionary  *dict =[[NSMutableDictionary alloc]init];
        NSMutableArray *filteredArray = [spadesArray mutableCopy];
        NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"Value" ascending:NO];
        [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
        [spadesArray removeAllObjects];
        [spadesArray addObjectsFromArray:filteredArray];
        int total=0;
        for(int i=0;i<spadesArray.count;i++)
        {
            total =total+[[[spadesArray valueForKey:@"Value"] objectAtIndex:i] intValue];
        }
        [dict setObject:@"spadesArray" forKey:@"Suit"];
        [dict setObject:spadesArray forKey:@"Array"];
        [dict setObject:[NSNumber numberWithInt:spadesArray.count] forKey:@"Count"];
        [dict setObject:[NSNumber numberWithInt:total] forKey:@"Total"];
        [arrayScores addObject:dict];
    }
    if(diamondsArray.count>0)
    {
        NSMutableDictionary  *dict =[[NSMutableDictionary alloc]init];
        NSMutableArray *filteredArray = [diamondsArray mutableCopy];
        NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"Value" ascending:NO];
        [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
        [diamondsArray removeAllObjects];
        [diamondsArray addObjectsFromArray:filteredArray];
        int total=0;
        for(int i=0;i<diamondsArray.count;i++)
        {
            total =total+[[[diamondsArray valueForKey:@"Value"] objectAtIndex:i] intValue];
        }
        [dict setObject:@"diamondsArray" forKey:@"Suit"];
        [dict setObject:diamondsArray forKey:@"Array"];
        [dict setObject:[NSNumber numberWithInt:diamondsArray.count] forKey:@"Count"];
        [dict setObject:[NSNumber numberWithInt:total] forKey:@"Total"];
        [arrayScores addObject:dict];
    }
    if(clubesArray.count>0)
    {
        NSMutableDictionary  *dict =[[NSMutableDictionary alloc]init];
        NSMutableArray *filteredArray = [clubesArray mutableCopy];
        NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"Value" ascending:NO];
        [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
        [clubesArray removeAllObjects];
        [clubesArray addObjectsFromArray:filteredArray];
        int total=0;
        for(int i=0;i<clubesArray.count;i++)
        {
            total =total+[[[clubesArray valueForKey:@"Value"] objectAtIndex:i] intValue];
        }
        [dict setObject:@"clubesArray" forKey:@"Suit"];
        [dict setObject:clubesArray forKey:@"Array"];
        [dict setObject:[NSNumber numberWithInt:clubesArray.count] forKey:@"Count"];
        [dict setObject:[NSNumber numberWithInt:total] forKey:@"Total"];
        [arrayScores addObject:dict];
    }
    NSMutableArray *filteredArray = [arrayScores mutableCopy];
    NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"Total" ascending:NO];
    [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
    [arrayScores removeAllObjects];
    [arrayScores addObjectsFromArray:filteredArray];
    if([[[arrayScores valueForKey:@"Suit"] objectAtIndex:0] isEqual:@"clubesArray"])
    {   if([[clubesArray valueForKey:@"Type"] containsObject:@"HoleCard"]){
        [bestArray addObjectsFromArray:clubesArray];
        NSMutableArray *filteredArray = [[NSMutableArray alloc]init];
        for(int i=1;i<arrayScores.count;i++)
        {
            [filteredArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:i]];
        }
        NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"Value" ascending:NO];
        [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
        [bestArray addObjectsFromArray:filteredArray];
    }
    else if([[[[arrayScores valueForKey:@"Array"] objectAtIndex:1] valueForKey:@"Type"] containsObject:@"HoleCard"]){
        [bestArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:1]];
        NSMutableArray *filteredArray = [[NSMutableArray alloc]init];
        [bestArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:0]];
        for(int i=2;i<arrayScores.count;i++)
        {
            [filteredArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:i]];
        }
        NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"Value" ascending:NO];
        [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
        [bestArray addObjectsFromArray:filteredArray];
    }
    else{
        if(arrayScores.count>2){
        [bestArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:2]];
        NSMutableArray *filteredArray = [[NSMutableArray alloc]init];
        [bestArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:0]];
        [bestArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:1]];
        for(int i=3;i<arrayScores.count;i++)
        {
            [filteredArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:i]];
        }
        NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"Value" ascending:NO];
        [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
        [bestArray addObjectsFromArray:filteredArray];
    }
    }
        
    }
    else if ([[[arrayScores valueForKey:@"Suit"] objectAtIndex:0] isEqual:@"heartsArray"])
    {  if([[heartsArray valueForKey:@"Type"] containsObject:@"HoleCard"]){
        [bestArray addObjectsFromArray:heartsArray];
        NSMutableArray *filteredArray = [[NSMutableArray alloc]init];
        for(int i=1;i<arrayScores.count;i++)
        {
            [filteredArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:i]];
        }
        NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"Value" ascending:NO];
        [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
        [bestArray addObjectsFromArray:filteredArray];
    }
    else if([[[[arrayScores valueForKey:@"Array"] objectAtIndex:1] valueForKey:@"Type"] containsObject:@"HoleCard"]){
        [bestArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:1]];
        NSMutableArray *filteredArray = [[NSMutableArray alloc]init];
        [bestArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:0]];
        for(int i=2;i<arrayScores.count;i++)
        {
            [filteredArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:i]];
        }
        NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"Value" ascending:NO];
        [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
        [bestArray addObjectsFromArray:filteredArray];
    }
    else {if(arrayScores.count>2){
        [bestArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:2]];
        NSMutableArray *filteredArray = [[NSMutableArray alloc]init];
        [bestArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:0]];
        [bestArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:1]];
        for(int i=3;i<arrayScores.count;i++)
        {
            [filteredArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:i]];
        }
        NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"Value" ascending:NO];
        [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
        [bestArray addObjectsFromArray:filteredArray];
    }
    }
    }
    else if ([[[arrayScores valueForKey:@"Suit"] objectAtIndex:0] isEqual:@"diamondsArray"])
    { if([[diamondsArray valueForKey:@"Type"] containsObject:@"HoleCard"]){
        [bestArray addObjectsFromArray:diamondsArray];
        NSMutableArray *filteredArray = [[NSMutableArray alloc]init];
        for(int i=1;i<arrayScores.count;i++)
        {
            [filteredArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:i]];
        }
        NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"Value" ascending:NO];
        [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
        [bestArray addObjectsFromArray:filteredArray];
    }
     else if([[[[arrayScores valueForKey:@"Array"] objectAtIndex:1] valueForKey:@"Type"] containsObject:@"HoleCard"]){
        [bestArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:1]];
        NSMutableArray *filteredArray = [[NSMutableArray alloc]init];
        [bestArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:0]];
        for(int i=2;i<arrayScores.count;i++)
        {
            [filteredArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:i]];
        }
        NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"Value" ascending:NO];
        [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
     } else {if(arrayScores.count>2){
         [bestArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:2]];
         NSMutableArray *filteredArray = [[NSMutableArray alloc]init];
         [bestArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:0]];
         [bestArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:1]];
         for(int i=3;i<arrayScores.count;i++)
         {
             [filteredArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:i]];
         }
         NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"Value" ascending:NO];
         [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
         [bestArray addObjectsFromArray:filteredArray];
     }
     }
    }
    else if ([[[arrayScores valueForKey:@"Suit"] objectAtIndex:0] isEqual:@"spadesArray"])
    {  if([[spadesArray valueForKey:@"Type"] containsObject:@"HoleCard"]){
        [bestArray addObjectsFromArray:spadesArray];
        NSMutableArray *filteredArray = [[NSMutableArray alloc]init];
        for(int i=1;i<arrayScores.count;i++)
        {
            [filteredArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:i]];
        }
        NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"Value" ascending:NO];
        [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
        [bestArray addObjectsFromArray:filteredArray];
    }
    else if([[[[arrayScores valueForKey:@"Array"] objectAtIndex:1] valueForKey:@"Type"] containsObject:@"HoleCard"]){
        [bestArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:1]];
        NSMutableArray *filteredArray = [[NSMutableArray alloc]init];
        [bestArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:0]];
        for(int i=2;i<arrayScores.count;i++)
        {
            [filteredArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:i]];
        }
        NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"Value" ascending:NO];
        [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
    }
    else {if(arrayScores.count>2){
        [bestArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:2]];
        NSMutableArray *filteredArray = [[NSMutableArray alloc]init];
        [bestArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:0]];
        [bestArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:1]];
        for(int i=3;i<arrayScores.count;i++)
        {
            [filteredArray addObjectsFromArray:[[arrayScores valueForKey:@"Array"] objectAtIndex:i]];
        }
        NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"Value" ascending:NO];
        [filteredArray sortUsingDescriptors:[NSArray arrayWithObject:lowestToHighest]];
        [bestArray addObjectsFromArray:filteredArray];
    }
    }
    }
    NSMutableArray *bestHands =[[NSMutableArray alloc]init];
    for(int z=0;z<3;z++)
    {
        [bestHands addObject:[bestArray objectAtIndex:z]];
    }
    if([[bestHands valueForKey:@"Type"] containsObject:@"HoleCard"])
    {
        NSLog(@"Contains");
    }
    else
    {
        [bestHands removeObjectAtIndex:2];
        [bestHands addObject:[bestArray objectAtIndex:3]];
        if([[bestHands valueForKey:@"Type"] containsObject:@"HoleCard"])
        {
            NSLog(@"Contains");
        }
        else
        {
            [bestHands removeObjectAtIndex:2];
            [bestHands addObject:[bestArray objectAtIndex:4]];
            if([[bestHands valueForKey:@"Type"] containsObject:@"HoleCard"])
            {
                NSLog(@"Contains");
            }
            else
            {
                [bestHands removeObjectAtIndex:2];
                [bestHands addObject:[bestArray objectAtIndex:5]];
                if([[bestHands valueForKey:@"Type"] containsObject:@"HoleCard"])
                {
                    NSLog(@"Contains");
                }
                else
                {
                    [bestHands removeObjectAtIndex:2];
                    [bestHands addObject:[bestArray objectAtIndex:6]];
                }
            }
        }
    }
    return bestHands;
}

@end
