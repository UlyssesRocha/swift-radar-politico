//
//  CDProposicao.m
//  DadosAbertosDeputados
//
//  Created by Ulysses on 3/10/16.
//  Copyright © 2016 DadosAbertosBrasil. All rights reserved.
//

#import "CDProposicao.h"
#import "AFNetworking.h"
#import "CDURLManager.h"
#import "XMLReader.h"
#import "CDVotacao.h"

@interface CDProposicao () 
- (void)loadPreposicaoFromServer:(void(^)(NSDictionary* response))completionHandler;
- (void)loadVotacoesFromServer:(void(^)(NSArray* response))completionHandler;
@end

@implementation CDProposicao

- (instancetype)initWithCodProposicao:(NSNumber*)codProposicao{
    self = [super init];
    if(self) {
        self.idProposicao = codProposicao;
    }
    return self;
}

-(void)loadVotacoes:(void(^)(void))completionHandler{
    [self loadVotacoesFromServer:^(NSArray *response) {
        
        if (response){
            
            NSMutableArray *votacoes = [[NSMutableArray alloc] init];

            for (id votacao in response) {
                /* -!! WARNING !!-
                 * Is import double check if is a NSDictionary
                 * do NOT remove this check, or it may fail
                 */
                if ([votacao isKindOfClass:[NSDictionary class]]) {
                    
                    CDVotacao *votacaoSessao = [[CDVotacao alloc]initWithDictionary:votacao];
                    
                    if (votacaoSessao){
                        [votacoes addObject:votacaoSessao];
                    }
                    
                }
            }
            
            self.votacoes = [[NSArray alloc]initWithArray:votacoes];
        }
        completionHandler();
    }];
}

-(void)loadProposicao:(void(^)(void))completionHandler{
    
    [self loadPreposicaoFromServer:^(NSDictionary *response) {
        if (response){
            //Number Formatter to convert String to Number.
            NSNumberFormatter *formater = [[NSNumberFormatter alloc] init];
            formater.numberStyle = NSNumberFormatterDecimalStyle;
            
            self.nome = [[response objectForKey:@"nomeProposicao"] objectForKey:@"text"];
            
            self.sigla = [[response objectForKey:@"tipo"] stringByReplacingOccurrencesOfString:@" " withString:@""]; //remove spaces
            self.numero = [formater numberFromString:[response objectForKey:@"numero"]];
            self.ano = [formater numberFromString:[response objectForKey:@"ano"]];
            
            self.tipoProposicao = [[response objectForKey:@"tipoProposicao"] objectForKey:@"text"];
            self.tema  = [[response objectForKey:@"tema"] objectForKey:@"text"];
            self.ementa = [[response objectForKey:@"Ementa"] objectForKey:@"text"];
            self.explicacaoEmenta = [[response objectForKey:@"ExplicacaoEmenta"] objectForKey:@"text"];
            self.indexacao = [[response objectForKey:@"Indexacao"] objectForKey:@"text"];
            
            self.regimeTramitacao = [[response objectForKey:@"RegimeTramitacao"] objectForKey:@"text"];
            self.situacao = [[response objectForKey:@"Situacao"] objectForKey:@"text"];
            
            self.urlInteiroTeor = [[response objectForKey:@"LinkInteiroTeor"] objectForKey:@"text"];
            
            self.nomeAutor = [[response objectForKey:@"Autor"] objectForKey:@"text"];
            
            NSString *localIdAutor = [[response objectForKey:@"ideCadastro"] objectForKey:@"text"];
            if (localIdAutor){ //May be NULL
                self.idAutor = [formater numberFromString:localIdAutor];
            }
            
            //DEBUG -------------
            if (self.nome != NULL){
            }else{
                NSLog(@" %@  error",self.idProposicao);
            }
            //DEBUG -------------
            completionHandler();
        }
    }];
}



#pragma MARK private functions

- (void)loadVotacoesFromServer:(void(^)(NSArray* response))completionHandler{
    
    if ( self.sigla  == NULL  ||
         self.numero == NULL  ||
         self.ano    == NULL   ) {
        return;
    }
    
    NSString * numeroProposicao = [NSString stringWithFormat:@"%@", self.numero];
    NSString * anoProposicao = [NSString stringWithFormat:@"%@", self.ano];

    NSURL * urlRequest = [NSURL URLWithString:[CDURLManager obterVotacaoProposicaoPorTipo:self.sigla comNumero:numeroProposicao noAno:anoProposicao]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlRequest];
    
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
        
        //Isolate the dictionary
        NSArray *votacoes = [[[[xmlDictionary allValues] objectAtIndex:0] objectForKey:@"Votacoes"] allValues];
        
        /* In some cases, when the object was voted only once, at this level,
         * it should have the vote data, but, if there was more *than one vote, a vote array should appear, there is probably a more
         * elegant solution, but let test this one for now
         */
        if ([[votacoes objectAtIndex:0] isKindOfClass:[NSArray class]]){
            votacoes = [votacoes objectAtIndex:0];
        }
    
        completionHandler(votacoes);
    }];
    
    [task resume];

    
}


- (void)loadPreposicaoFromServer:(void(^)(NSDictionary* response))completionHandler{
    
    if ( self.idProposicao == NULL || completionHandler == NULL) {
        return;
    }
    
    NSString * codProposicao = [NSString stringWithFormat:@"%@", self.idProposicao];
    NSURL * urlRequest = [NSURL URLWithString:[CDURLManager obterProposicaoPorID:codProposicao]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlRequest];
    
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
        
        //Isolate the dictionary
        NSDictionary *contentDictionary = [[xmlDictionary allValues] objectAtIndex:0];
        
        completionHandler(contentDictionary);
    }];
    
    [task resume];
}



#pragma MARK Class Methods

+(void)loadDistinctCodProposicoesVotedIn:(NSUInteger)year withCompletionHandler:(void(^)(NSArray* response))completionHandler{
    
    [CDProposicao loadCodProposicoesVotedIn:year withCompletionHandler:^(NSArray *response) {
        
        NSSet* categories = [NSSet setWithArray:response ];

        completionHandler([categories allObjects]);
    }];
}



+(void)loadCodProposicoesVotedIn:(NSUInteger)year withCompletionHandler:(void(^)(NSArray* response))completionHandler{
    
    if ( year == NULL || completionHandler == NULL) {
        return;
    }
    
    NSString * ano = [NSString stringWithFormat:@"%tu", year];
    NSURL * urlRequest = [NSURL URLWithString:[CDURLManager listarProposicoesVotadasEmPlenarioNoAno:ano comTipo:@""]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlRequest];
    
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
        
        //Isolate the dictionary
        NSArray *contentDictionary = [[[[[xmlDictionary allValues] objectAtIndex:0]valueForKey:@"proposicao"] valueForKey: @"codProposicao"] valueForKey:@"text"];
        
        completionHandler(contentDictionary );
    }];
    
    [task resume];
}


@end
