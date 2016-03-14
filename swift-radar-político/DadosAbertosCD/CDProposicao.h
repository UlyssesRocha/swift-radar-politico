//
//  CDProposicao.h
//  DadosAbertosDeputados
//
//  Created by Ulysses on 3/10/16.
//  Copyright © 2016 DadosAbertosBrasil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDProposicao : NSObject

@property NSNumber *idProposicao;
@property NSString *nome;

@property NSString *sigla;
@property NSNumber *numero;
@property NSNumber *ano;

@property NSString *tipoProposicao;
@property NSString *tema;
@property NSString *ementa;
@property NSString *explicacaoEmenta;
@property NSString *indexacao;

@property NSString *regimeTramitacao;
@property NSString *situacao;

@property NSString *urlInteiroTeor;

@property NSNumber *qtdeAutores;

@property NSNumber *idAutor;
@property NSString *nomeAutor;

@property NSArray *votacoes;

- (instancetype)initWithCodProposicao:(NSNumber*)codProposicao;
-(void)loadProposicao:(void(^)(void))completionHandler;
-(void)loadVotacoes:(void(^)(void))completionHandler;

+(void)loadDistinctCodProposicoesVotedIn:(NSUInteger*)year withCompletionHandler:(void(^)(NSArray* response))completionHandler;
+(void)loadCodProposicoesVotedIn:(NSUInteger*)year withCompletionHandler:(void(^)(NSArray* response))completionHandler;

@end
