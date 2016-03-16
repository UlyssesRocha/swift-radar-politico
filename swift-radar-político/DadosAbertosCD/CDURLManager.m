// The MIT License (MIT)
//
// Copyright (c) 2016 Ulysses Rocha
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#import "CDURLManager.h"

@implementation CDURLManager

#pragma mark Deputados
+ (NSString*)obterDeputados{
    return @"http://www.camara.gov.br/SitCamaraWS/Deputados.asmx/ObterDeputados";
}

+ (NSString*)obterDetalhesDeputadoPorID:(NSString*)ideCadastro comNumLegislatura:(NSString*)numLegislatura{
    return [NSString stringWithFormat:@("http://www.camara.gov.br/SitCamaraWS/Deputados.asmx/ObterDetalhesDeputado?ideCadastro=%@&numLegislatura=%@"),ideCadastro,numLegislatura];
}

+ (NSString*)obterLideresBancadas{
    return @"http://www.camara.gov.br/SitCamaraWS/Deputados.asmx/ObterLideresBancadas";
}

+ (NSString*)obterPartidosCD{
    return @"http://www.camara.gov.br/SitCamaraWS/Deputados.asmx/ObterPartidosCD";
}

+ (NSString*)obterPartidosBlocoCDPorID:(NSString*)idBloco comNumLegislatura:(NSString*)numLegislatura{
    return [NSString stringWithFormat:@("http://www.camara.gov.br/SitCamaraWS/Deputados.asmx/ObterPartidosBlocoCD?numLegislatura=%@&idBloco=%@"),idBloco,numLegislatura];
}

#pragma mark Orgaos

+ (NSString*)listarCargosOrgaosLegislativosCD{
    return @"http://www.camara.gov.br/SitCamaraWS/Orgaos.asmx/ListarCargosOrgaosLegislativosCD";
}

+ (NSString*)listarTiposOrgao{
    return @"http://www.camara.gov.br/SitCamaraWS/Orgaos.asmx/ListarTiposOrgaos";
}

+ (NSString*)obterAndamentoPorSigla:(NSString*)sigla comNumero:(NSString*)numero doAno:(NSString*)ano aPartirDaData:(NSString*)dataIni comIDOrgao:(NSString*)codOrgao{
    return [NSString stringWithFormat:@("http://www.camara.gov.br/SitCamaraWS/Orgaos.asmx/ObterAndamento?sigla=%@&numero=%@&ano=%@&dataIni=%@&codOrgao=%@"),sigla,numero,ano,dataIni,codOrgao];
}

+ (NSString*)obterEmendasSubstitutivoRedacaoFinalPorTipo:(NSString*)tipo comNumero:(NSString*)numero doAno:(NSString*)ano{
    return [NSString stringWithFormat:@("http://www.camara.gov.br/SitCamaraWS/Orgaos.asmx/ObterEmendasSubstitutivoRedacaoFinal?tipo=%@&numero=%@&ano=%@"),tipo,numero,ano];
}

+ (NSString*)obterIntegraComissoesRelatorPorTipo:(NSString*)tipo comNumero:(NSString*)numero doAno:(NSString*)ano{
    return [NSString stringWithFormat:@("http://www.camara.gov.br/SitCamaraWS/Orgaos.asmx/ObterIntegraComissoesRelator?tipo=%@&numero=%@&ano=%@"),tipo,numero,ano];
}

+(NSString*)obterMembrosOrgaoPorID:(NSString*)idOrgao{
    return [NSString stringWithFormat:@("http://www.camara.gov.br/SitCamaraWS/Orgaos.asmx/ObterMembrosOrgao?IDOrgao=%@"),idOrgao];
}

+ (NSString*)obterOrgaos{
    return [NSString stringWithFormat:@"http://www.camara.gov.br/SitCamaraWS/Orgaos.asmx/ObterOrgaos"];
}

+ (NSString*)obterPautaPorID:(NSString*)idOrgao deDataIni:(NSString*)datIni ateDataFim:(NSString*)datFim{
    return [NSString stringWithFormat:@("http://www.camara.gov.br/SitCamaraWS/Orgaos.asmx/ObterPauta?IDOrgao=%@&datIni=%@&datFim=%@"),idOrgao,datIni,datFim];
}

+ (NSString*)obterRegimeTramitacaoDespachoPorTipo:(NSString*)tipo comNumero:(NSString*)numero noAno:(NSString*)ano{
    return [NSString stringWithFormat:@("http://www.camara.gov.br/SitCamaraWS/Orgaos.asmx/ObterRegimeTramitacaoDespacho?tipo=%@&numero=%@&ano=%@"),tipo,numero,ano];
}

#pragma mark Proposicoes

+ (NSString*)listarProposicoesPorSigla:(NSString*)sigla comNumero:(NSString*)numero noAno:(NSString*)ano comDatApresetacaoIni:(NSString*)datApresentacaoIni comDataApresentacaoFim:(NSString*)datApresentacaoFim comIdTipoAutor:(NSString*)idTipoAutor comParteNomeAutor:(NSString*)parteNomeAutor comSiglaPartidoAutor:(NSString*)siglaPartidoAutor comUFAutor:(NSString*)siglaUfAutor comGeneroAutor:(NSString*)generoAutor comIDSituacaoProposicao:(NSString*)idsituacaoProposicao comIDOrgaoSituacaoProposicao:(NSString*)idOrgaoSituacaoProposicao comTramitacao:(NSString*)emTramitacao{
    
    return [NSString stringWithFormat:@("hhttp://www.camara.gov.br/SitCamaraWS/Proposicoes.asmx/ListarProposicoes?sigla=%@&numero=%@&ano=%@&datApresentacaoIni=%@&datApresentacaoFim=%@&parteNomeAutor=%@&idTipoAutor=%@&siglaPartidoAutor=%@&siglaUFAutor=%@&generoAutor=%@&codEstado=%@&codOrgaoEstado=%@&emTramitacao=%@"),sigla,numero,ano,datApresentacaoIni,datApresentacaoFim,parteNomeAutor,idTipoAutor,siglaPartidoAutor,siglaUfAutor,generoAutor,idsituacaoProposicao,idOrgaoSituacaoProposicao,emTramitacao];
}

+ (NSString*)listarSiglasTipoProposicao{
    return @"http://www.camara.gov.br/SitCamaraWS/Proposicoes.asmx/ListarSiglasTipoProposicao";
}

+ (NSString*)listarSituacoesProposicao{
    return @"http://www.camara.gov.br/SitCamaraWS/Proposicoes.asmx/ListarSituacoesProposicao";
}

+ (NSString*)listarTiposAutores{
    return @"http://www.camara.gov.br/SitCamaraWS/Proposicoes.asmx/ListarTiposAutores";
}

+ (NSString*)obterProposicaoPorTipo:(NSString*)tipo comNumero:(NSString*)numero noAno:(NSString*)ano{
    return [NSString stringWithFormat:@("http://www.camara.gov.br/SitCamaraWS/Proposicoes.asmx/ObterProposicao?tipo=%@&numero=%@&ano=%@"),tipo,numero,ano];
}

+ (NSString*)obterProposicaoPorID:(NSString*)idProp {
    return [NSString stringWithFormat:@("http://www.camara.gov.br/SitCamaraWS/Proposicoes.asmx/ObterProposicaoPorID?IdProp=%@"),idProp];
}

+ (NSString*)obterVotacaoProposicaoPorTipo:(NSString*)tipo comNumero:(NSString*)numero noAno:(NSString*)ano{
    return [NSString stringWithFormat:@("http://www.camara.gov.br/SitCamaraWS/Proposicoes.asmx/ObterVotacaoProposicao?tipo=%@&numero=%@&ano=%@"),tipo,numero,ano];
}

+ (NSString*)listarProposicoesVotadasEmPlenarioNoAno:(NSString*)ano comTipo:(NSString*)tipo{
    return [NSString stringWithFormat:@("http://www.camara.gov.br/SitCamaraWS/Proposicoes.asmx/ListarProposicoesVotadasEmPlenario?ano=%@&tipo=%@"),ano,tipo];
}

+ (NSString*)listarProposicoesTramitadasNoPeriodoDataInicio:(NSString*)dtInicio comDataFim:(NSString*)dtFim{
    return [NSString stringWithFormat:@("http://www.camara.gov.br/SitCamaraWS/Proposicoes.asmx/ListarProposicoesTramitadasNoPeriodo?dtInicio=%@&dtFim=%@"),dtInicio,dtFim];
}

#pragma mark SessoesReunioes

+ (NSString*)listarDiscursosPlenarioPorDataIni:(NSString*)dataIni comDataFim:(NSString*)dataFim comCodigoSessao:(NSString*)codigoSessao comParteNomeParlamentar:(NSString*)parteNomeParlamentar porSiglaPartido:(NSString*)siglaPartido porSigaUF:(NSString*)siglaUF{
    return [NSString stringWithFormat:@("http://www.camara.gov.br/sitcamaraws/SessoesReunioes.asmx/ListarDiscursosPlenario?dataIni=%@&dataFim=%@&codigoSessao=%@&parteNomeParlamentar=%@&siglaPartido=%@&siglaUF=%@"),dataIni,dataFim,codigoSessao,parteNomeParlamentar,siglaPartido,siglaUF];
}

+ (NSString*)listarPresencasDoDia:(NSString*)data comNumMatriculaParlamentar:(NSString*)numMatriculaParlamentar comSiglaPartido:(NSString*)siglaPartido comSiglaUF:(NSString*)siglaUF{
    return [NSString stringWithFormat:@("http://www.camara.gov.br/SitCamaraWS/sessoesreunioes.asmx/ListarPresencasDia?data=%@&numLegislatura=%@&numMatriculaParlamentar=%@&siglaPartido=%@&siglaUF=%@"),data,numMatriculaParlamentar,siglaPartido,siglaUF];
}

+ (NSString*)listarPresencasParlamentarComDataInicio:(NSString*)dataIni comDataFim:(NSString*)dataFim comNumeroMatriculaParlamentar:(NSString*)numMatriculaParlamentar{
    return [NSString stringWithFormat:@("http://www.camara.gov.br/SitCamaraWS/sessoesreunioes.asmx/ListarPresencasParlamentar?dataIni=%@&dataFim=%@&numMatriculaParlamentar=%@"),dataIni,dataFim,numMatriculaParlamentar];
}

+ (NSString*)listarSituacoesProposicaoReuniaoSessao{
    return @"http://www.camara.gov.br/SitCamaraWS/SessoesReunioes.asmx/ListarSituacoesReuniaoSessao";
}

+ (NSString*)obterInteiroTeorDiscursosPlenarioPorCodSessao:(NSString*)codSessao comNumOrador:(NSString*)numOrador comNumQuarto:(NSString*)numQuarto comNumInsercao:(NSString*)numInsercao{
    return [NSString stringWithFormat:@("http://www.camara.gov.br/SitCamaraWS/SessoesReunioes.asmx/obterInteiroTeorDiscursosPlenario?codSessao=%@&numOrador=%@&numQuarto=%@&numInsercao=%@"),codSessao,numOrador,numQuarto,numInsercao];
}



@end
