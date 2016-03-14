//
//  CDVotacao.m
//  DadosAbertosDeputados
//
//  Created by Ulysses on 3/10/16.
//  Copyright © 2016 DadosAbertosBrasil. All rights reserved.
//

#import "CDVotacao.h"


@interface CDVotacao ()
- (void)processStatistics;

@end

@implementation CDVotacao

- (instancetype)initWithDictionary:(NSDictionary*)dictionary{
    self = [super self];
    if (self){
        
        self.resumo = [dictionary objectForKey:@"Resumo"];
        
        //Brazilia GMT-03:00
        NSDateFormatter *dataFormat = [[NSDateFormatter alloc] init];
        [dataFormat setDateFormat:@"dd/MM/yyy HH:mm ZZZZ"];
        NSString *dataHora = [NSString stringWithFormat:@"%@ %@ GMT-03:00",[dictionary objectForKey:@"Data"],[dictionary objectForKey:@"Hora"]];
        self.data = [dataFormat dateFromString: dataHora];
        
        self.hora = [dictionary objectForKey:@"Hora"];
        self.objVotacao = [[dictionary objectForKey:@"ObjVotacao"] capitalizedString];
        
        self.codSessao = [dictionary objectForKey:@"codSessao"];
        self.votoDeputados = [[dictionary objectForKey:@"votos"] objectForKey:@"Deputado"];
        
        [self processStatistics];
    }
    return self;
}

- (void)processStatistics{
    
    if ( self.votoDeputados == NULL) {
        return;
    }
    
    NSUInteger sim = 0;
    NSUInteger nao = 0;
    NSUInteger abstencao = 0;
    NSUInteger obstrucao = 0;
    
    for (NSDictionary *votoDeputado in self.votoDeputados) {
        
        NSString *voto = [[votoDeputado objectForKey:@"Voto"]stringByReplacingOccurrencesOfString:@" " withString:@""]; //remove spaces
        
        if ([voto isEqualToString:@"Sim"])
            sim++;
        else if ([voto isEqualToString:@"Não"])
            nao++;
        else if ([voto isEqualToString:@"Abstenção"])
            abstencao++;
        else if ([voto isEqualToString:@"Obstrução"])
            obstrucao++;
    }
    
    self.votoSim = [NSNumber numberWithUnsignedInteger:sim];
    self.votoNao = [NSNumber numberWithUnsignedInteger:nao];
    self.votoAbstencao = [NSNumber numberWithUnsignedInteger:abstencao];
    self.votoObstrucao = [NSNumber numberWithUnsignedInteger:obstrucao];
    
    //"obstrucao votes" does not count in the "oficial total numbers"
    self.votoTotal = [NSNumber numberWithUnsignedInteger:(sim + nao + abstencao)];
    
 }
    
    


@end
