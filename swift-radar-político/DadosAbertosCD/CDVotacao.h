//
//  CDVotacao.h
//  DadosAbertosDeputados
//
//  Created by Ulysses on 3/10/16.
//  Copyright © 2016 DadosAbertosBrasil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDVotacao : NSObject

@property NSString *resumo;
@property NSDate *data;
@property NSString *hora;
@property NSString *objVotacao;
@property NSString *codSessao;

@property NSNumber *votoSim;
@property NSNumber *votoNao;
@property NSNumber *votoAbstencao;
@property NSNumber *votoObstrucao;
@property NSNumber *votoTotal;

@property NSArray *votoDeputados;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

@end
