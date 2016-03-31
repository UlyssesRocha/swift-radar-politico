//
//  CDDeputado.m
//  DadosAbertosDeputados
//
//  Created by Ulysses on 3/10/16.
//  Copyright © 2016 DadosAbertosBrasil. All rights reserved.
//

#import "CDDeputado.h"
#import "CDURLManager.h"
#import "XMLReader.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"

@implementation CDDeputado

#pragma MARK Class Methods
+ (void)loadDeputados:(void(^)(NSArray* response))completionHandler{
    
    if (completionHandler == NULL) {
        return;
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[CDURLManager obterDeputados]]];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes =  [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/xml"];
    
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        //Parse XML Data to Dictionary
        NSError *parseError = nil;
        NSDictionary *xmlDictionary = [XMLReader dictionaryForXMLData:responseObject error:&parseError];
        if (parseError != NULL) {
            return;
        }
        //Parse from Dictionary for CDDeputado Object
        NSArray *test = [[[xmlDictionary objectForKey:@"deputados"] objectForKey:@"deputado"]allObjects] ;
        NSMutableArray *responseArray = [[NSMutableArray alloc]init];
        
        //Initiate each CDDeputado Object
        for (id currentMember in test){
            CDDeputado *currentDeputado = [[CDDeputado alloc]initWithBasicInfoDictionary:currentMember];
            if (currentDeputado){
                [responseArray addObject:currentDeputado];
            }
        }
        completionHandler(responseArray);
    }];
    
    [task resume];
}

#pragma MARK Instance Methods
- (instancetype) initWithBasicInfoDictionary:(NSDictionary*)dictionary{
    self = [super init];
    if(self) {
        @try {
            self.nomeParlamentar = [[dictionary valueForKey:@"nomeParlamentar"]valueForKey:@"text"];
            self.fone = [[dictionary valueForKey:@"fone"]valueForKey:@"text"];
            self.urlFoto = [[dictionary valueForKey:@"urlFoto"]valueForKey:@"text"];
            self.ideCadastro = [[dictionary valueForKey:@"ideCadastro"]valueForKey:@"text"];
            self.partido = [[dictionary valueForKey:@"partido"]valueForKey:@"text"];
            self.matricula = [[dictionary valueForKey:@"matricula"]valueForKey:@"text"];
            self.nome = [[dictionary valueForKey:@"nome"]valueForKey:@"text"];
            self.idParlamentar = [[dictionary valueForKey:@"idParlamentar"]valueForKey:@"text"];
            self.uf = [[dictionary valueForKey:@"uf"]valueForKey:@"text"];
            self.condicao = [[dictionary valueForKey:@"condicao"]valueForKey:@"text"];
            self.email = [[dictionary valueForKey:@"email"]valueForKey:@"text"];
        }
        @catch (NSException *exception) {
            return NULL;
        }
    }
    return self;
}


- (void)loadPhoto:(UIImageView*)photo{
    if (self.urlFoto){
        NSURL *urlImage = [[NSURL alloc] initWithString:self.urlFoto];
        [photo setImageWithURL:urlImage];
    }
}


- (void)loadPresencasInTheLast:(NSUInteger)months withCompletionHandler:(void(^)(void))completionHandler{

    NSDate *endDate = [[NSDate alloc] init]; //today
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:-months]; // n Months
    
    NSDate *beginDate = [calendar dateByAddingComponents:offsetComponents toDate:endDate options:0];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    
    NSString *inicioIntervalo = [dateFormatter stringFromDate:beginDate];
    NSString *fimIntervalo = [dateFormatter stringFromDate:endDate];
    NSString *matricula = [NSString stringWithFormat:@"%@",self.matricula];
    
    //Begin of request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[CDURLManager listarPresencasParlamentarComDataInicio:inicioIntervalo comDataFim:fimIntervalo comNumeroMatriculaParlamentar:matricula]]];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes =  [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/xml"];
    
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        //Parse XML Data to Dictionary
        NSError *parseError = nil;
        NSDictionary *xmlDictionary = [XMLReader dictionaryForXMLData:responseObject error:&parseError];
        if (parseError != NULL) {
            return;
        }
        
        //Get Sessoes
        NSArray *dias = [[[[xmlDictionary objectForKey:@"parlamentar"] objectForKey:@"diasDeSessoes2"] objectForKey:@"dia"] allObjects];
        if (dias){
            self.presencas = [[NSArray alloc] initWithArray:dias];
        }
        
        completionHandler();
    }];
    
    [task resume];


    
}


@end
