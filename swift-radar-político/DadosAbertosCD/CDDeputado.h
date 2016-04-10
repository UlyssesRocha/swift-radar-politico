//
//  CDDeputado.h
//  DadosAbertosDeputados
//
//  Created by Ulysses on 3/10/16.
//  Copyright © 2016 DadosAbertosBrasil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CDDeputado : NSObject

#pragma mark Basic Information
@property (nonatomic) NSNumber *ideCadastro;
@property (nonatomic) NSNumber *matricula;
@property (nonatomic) NSNumber *idParlamentar;

@property (nonatomic) NSString *condicao;
@property (nonatomic) NSString *nome;
@property (nonatomic) NSString *nomeParlamentar;
@property (nonatomic) NSString *urlFoto;
@property (nonatomic) UIImageView *imgFoto;

@property (nonatomic) NSString *partido;

@property (nonatomic) NSString *gabinete;
@property (nonatomic) NSString *anexo;

//Contacts
@property (nonatomic) NSString *uf;
@property (nonatomic) NSString *fone;
@property (nonatomic) NSString *email;

#pragma mark Details
@property (nonatomic) NSDate *dataNascimento;
@property (nonatomic) NSString *situacaoNaLegislaturaAtual;
@property (nonatomic) NSString *ufRepresentacaoAtual;
@property (nonatomic) NSString *nomeProfissao;

@property (nonatomic) NSArray *presencas;


- (instancetype)initWithBasicInfoDictionary:(NSDictionary*)dictionary;
- (void)loadPhoto:(UIImageView*)photo;
- (void)loadPresencasInTheLast:(NSUInteger)months withCompletionHandler:(void(^)(void))completionHandler;

+ (void)loadDeputados:(void(^)(NSArray* response))completionHandler;



@end
