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

#import <Foundation/Foundation.h>

@interface CDURLManager : NSObject

#pragma mark Deputados

/**
 * Retorna os deputados em exercício na Câmara dos Deputados
 */
+ (NSString*)obterDeputados;

/**
 * Retorna detalhes dos deputados com histórico de participação em comissões,
 * períodos de exercício, filiações partidárias e lideranças, 
 * \param ideCadastro  (Obrigatorio) Identificador do deputado obtido na chamada ao ObterDeputados.
 * \param numero (Opcional) Número da legislatura. Campo vazio, todas as legislaturas do Deputado.
 */
+ (NSString*)obterDetalhesDeputadoPorID:(NSString*)ideCadastro comNumLegislatura:(NSString*)numLegislatura;

/**
 * Retorna os deputados líderes e vice-líderes em exercício das 
 *bancadas dos partidos
 */
+ (NSString*)obterLideresBancadas;

/**
 * Retorna os partidos com representação na Câmara dos Deputados
 */
+ (NSString*)obterPartidosCD;

/**
 * Retorna os blocos parlamentares na Câmara dos Deputados.
 * \param idBloco  (Opcional) ID do Bloco Parlamentar
 * \param numLegislatura (Opcional) Número da Legislatura. Campo Vazio, legislatura atual. Apenas legislatura 53 em diante.
 */
+ (NSString*)obterPartidosBlocoCDPorID:(NSString*)idBloco comNumLegislatura:(NSString*)numLegislatura;

#pragma mark Orgaos

/**
 * Retorna a lista dos tipos de cargo para os órgãos legislativos da 
 * Câmara dos Deputados (ex: presidente, primeiro-secretário, etc)
 */
+ (NSString*)listarCargosOrgaosLegislativosCD;

/**
 * Retorna a lista dos tipos de órgãos que participam do processo legislativo na Câmara dos Deputados
 */
+ (NSString*)listarTiposOrgao;

/**
 * Retorna o andamento de uma proposição pelos órgãos internos da Câmara a partir de uma data específica
 * \param sigla  (Obrigatorio) Sigla do tipo de proposição
 * \param numero (Obrigatorio) Numero da proposição
 * \param ano (Obrigatorio) Ano da proposição Formato
 * \param dataIni (Opcional)Data a partir da qual as tramitações do histórico de andamento serão retornadas (dd/mm/aaaa)
 * \param codOrgao (Opcional)ID do órgão numerador da proposição
 */
+ (NSString*)obterAndamentoPorSigla:(NSString*)sigla comNumero:(NSNumber*)numero doAno:(NSString*)ano aPartirDaData:(NSString*)dataIni comIDOrgao:(NSString*)codOrgao;

/**
 *Retorna as emendas, substitutivos e redações finais de uma determinada proposição
 * \param tipo  (Obrigatorio) Sigla do tipo de proposição
 * \param numero (Obrigatorio) Numero da proposição
 * \param ano (Obrigatorio) Ano da proposição Formato
 */
+ (NSString*)obterEmendasSubstitutivoRedacaoFinalPorTipo:(NSString*)tipo comNumero:(NSString*)numero doAno:(NSString*)ano;

/**
 *Retorna os dados de relatores e pareces, e o link para a íntegra de uma determinada proposição
 * \param tipo  (Obrigatorio) Sigla do tipo de proposição
 * \param numero (Obrigatorio) Numero da proposição
 * \param ano (Obrigatorio) Ano da proposição Formato
 */
+ (NSString*)obterIntegraComissoesRelatorPorTipo:(NSString*)tipo comNumero:(NSString*)numero doAno:(NSString*)ano;

/**
 * Retorna os parlamentares membros de uma determinada comissão
 * \param idOrgao (Obrigatorio) ID do órgão numerador da proposição
 */
+(NSString*)obterMembrosOrgaoPorID:(NSString*)idOrgao;

/**
 * Retorna a lista de órgãos legislativos da Câmara dos Deputados (comissões, Mesa Diretora, conselhos, etc.)
 */
+ (NSString*)obterOrgaos;

/**
 * Retorna as pautas das reuniões de comissões e das sessões plenárias realizadas em um determinado período
 * \param idOrgao  (Obrigatorio) ID do órgão (comissão) da Câmara dos Deputados
 * \param datIni (Opcional) O métoto retorna a pauta das reuniões que foram realizadas em uma data maior ou igual a datIni, formato dd/mm/aaaa
 * \param datFim (Opcional) O métoto retorna a pauta das reuniões que foram realizadas em uma data menor ou igual a datFim, formato dd/mm/aaaa
 */
+ (NSString*)obterPautaPorID:(NSString*)idOrgao deDataIni:(NSString*)datIni ateDataFim:(NSString*)datFim;

/**
 * Retorna as pautas das reuniões de comissões e das sessões plenárias realizadas em um determinado período
 * \param tipo  (Obrigatorio) Sigla do tipo de proposição
 * \param numero (Obrigatorio) Numero da proposição
 * \param ano (Obrigatorio) Ano da proposição
 */
+ (NSString*)obterRegimeTramitacaoDespachoPorTipo:(NSString*)tipo comNumero:(NSString*)numero noAno:(NSString*)ano;

#pragma mark Proposicoes

/**
 * Retorna a lista de proposições que satisfaçam os critérios estabelecidos
 * \param sigla Obrigatorio se ParteNomeAutor não for preenchido) Sigla do tipo de proposição
 * \param numero (Opcional) Numero da proposição
 * \param ano (Obrigatorio se ParteNomeAutor não for preenchido) Ano da proposição
 * \param datApresentacaoIni (Opcional) Menor data desejada para a data de apresentação da proposição,formato dd/mm/aaaa
 * \param datApresentacaoFim (Opcional) Maior data desejada para a data de apresentação da proposição,formato dd/mm/aaaa
 * \param idTipoAutor (Optional) Identificador do tipo de órgão autor da proposição, como obtido na chamada ao ListarTiposOrgao
 * \param parteNomeAutor (Optional) Parte do nome do autor(5 ou + caracteres) da proposição.
 * \param siglaPartidoAutor (Optional) Sigla do partido do autor da proposição
 * \param siglaUfAutor (Optional) UF de representação do autor da proposição
 * \param seneroAutor (Optional) Gênero do autor<BR>M - Masculino; F - Feminino; Default - Todos
 * \param idSituacaoProposicao (Opcional) ID da situação da proposição
 * \param idOrgaoSituacaoProposicao (Opcional) ID do órgão de referência da situação da proposição
 * \param emTramitacao (Opcional) Indicador da situação de tramitação da proposição<BR>1 - Em Tramitação no Congresso; 2- Tramitação Encerrada no Congresso; Default - Todas
 */
+ (NSString*)listarProposicoesPorSigla:(NSString*)sigla comNumero:(NSString*)numero noAno:(NSString*)ano comDatApresetacaoIni:(NSString*)datApresentacaoIni comDataApresentacaoFim:(NSString*)datApresentacaoFim comIdTipoAutor:(NSString*)idTipoAutor comParteNomeAutor:(NSString*)parteNomeAutor comSiglaPartidoAutor:(NSString*)siglaPartidoAutor comUFAutor:(NSString*)siglaUfAutor comGeneroAutor:(NSString*)generoAutor comIDSituacaoProposicao:(NSString*)idsituacaoProposicao comIDOrgaoSituacaoProposicao:(NSString*)idOrgaoSituacaoProposicao comTramitacao:(NSString*)emTramitacao;

/**
 * Retorna a lista de siglas de proposições
 */
+ (NSString*)listarSiglasTipoProposicao;

/**
 * Retorna a lista de siglas de proposições
 */
+ (NSString*)listarSituacoesProposicao;

/**
 * Retorna a lista de tipos de autores das proposições
 */
+ (NSString*)listarTiposAutores;

/**
 * Retorna os dados de uma determinada proposição a partir do tipo, número e ano
 * \param tipo  (Obrigatorio) Sigla do tipo de proposição
 * \param numero (Obrigatorio) Numero da proposição
 * \param ano (Obrigatorio) Ano da proposição
 */
+ (NSString*)obterProposicaoPorTipo:(NSString*)tipo comNumero:(NSString*)numero noAno:(NSString*)ano;

/**
 * Retorna os dados de uma determinada proposição a partir do seu ID
 * \param idProp  (Obrigatorio) ID da proposição desejada
 */
+ (NSString*)obterProposicaoPorID:(NSString*)idProp;

/**
 * Retorna os votos dos deputados a uma determinada proposição em votações ocorridas no Plenário da Câmara dos Deputados
 * \param tipo  (Obrigatorio) Sigla do tipo de proposição
 * \param numero (Obrigatorio) Numero da proposição
 * \param ano (Obrigatorio) Ano da proposição
 */
+ (NSString*)obterVotacaoProposicaoPorTipo:(NSString*)tipo comNumero:(NSString*)numero noAno:(NSString*)ano;

/**
 * Retorna a lista de proposições que sofreram votação em plenário em determinado ano.
 * \param ano (Obrigatorio) Ano da proposição
 * \param tipo  (Opcional) Sigla do tipo de proposição
 */
+ (NSString*)listarProposicoesVotadasEmPlenarioNoAno:(NSString*)ano comTipo:(NSString*)tipo;

/**
 * Retorna a lista de proposições que sofreram votação em plenário em determinado ano.
 * \param dtInicio (Obrigatorio) Data de início do periodo,formato dd/mm/aaaa
 * \param dtFim  (Obrigatorio) Data fim do periodo,formato dd/mm/aaaa
 */
+ (NSString*)listarProposicoesTramitadasNoPeriodoDataInicio:(NSString*)dtInicio comDataFim:(NSString*)dtFim;

#pragma mark SessoesReunioes

/**
 * Retorna a lista dos deputados que proferiam discurso no Plenário da Câmara dos Deputados em um determinado período.
 * \param dataIni (Obrigatorio) Data de início do periodo,formato dd/mm/aaaa
 * \param dataFim  (Obrigatorio) Data fim do periodo,formato dd/mm/aaaa
 * \param codigoSessao  (Opcional) Código da sessão a ser pesquisada
 * \param parteNomeParlamentar (Opcional) Parte do nome do autor(5 ou + caracteres) da proposição.
 * \param siglaPartido  (Opcional) Sigla do Partido do Deputado
 * \param siglaUF  (Opcional) Sigla da UF do Deputado
 */
+ (NSString*)listarDiscursosPlenarioPorDataIni:(NSString*)dataIni comDataFim:(NSString*)dataFim comCodigoSessao:(NSString*)codigoSessao comParteNomeParlamentar:(NSString*)parteNomeParlamentar porSiglaPartido:(NSString*)siglaPartido porSigaUF:(NSString*)siglaUF;

/**
 * Retorna a quantidade de sessões ocorridas no dia especificado e a presença dos parlamentares em cada sessão.
 * \param data (Obrigatorio) Data da sessao,formato dd/mm/aaaa
 * \param numMatriculaParlamentar  (Opcional) Numero da matrícula do Parlamentar obtido pelo método ObterDeputados
 * \param codigoSessao  (Opcional) Código da sessão a ser pesquisada
 * \param siglaPartido (Opcional) Sigla do Partido
 * \param siglaUF  (Opcional) Sigla da UF a ser pesquisada
 */
+ (NSString*)listarPresencasDoDia:(NSString*)data comNumMatriculaParlamentar:(NSString*)numMatriculaParlamentar comSiglaPartido:(NSString*)siglaPartido comSiglaUF:(NSString*)siglaUF;

/**
 * Retorna a quantidade de sessões ocorridas no Plenário em um período especificado e a presença dos parlamentares em cada sessão.
 * \param dataIni (Obrigatorio) Data de início do periodo,formato dd/mm/aaaa
 * \param dataFim (Obrigatorio) Data fim do periodo,formato dd/mm/aaaa
 * \param numMatriculaParlamentar  (Obrigatorio) Numero da matrícula do Parlamentar obtido pelo método ObterDeputados
 */
+ (NSString*)listarPresencasParlamentarComDataInicio:(NSString*)dataIni comDataFim:(NSString*)dataFim comNumeroMatriculaParlamentar:(NSString*)numMatriculaParlamentar;

/**
 * Retorna a lista de situações para as reuniões de comissão e sessões plenárias da Câmara dos Deputados
 */
+ (NSString*)listarSituacoesProposicaoReuniaoSessao;

/**
 * Retorna o inteiro teor de um discurso proferido no Plenário.
 * \details primeiro deve-se chamar o método ListarDiscursosPlenario para obtenção dos parâmetros necessários para a identificação única do discurso desejado. São eles o código da sessão, o número do orador, e mais 2 parâmetros numéricos, numQuarto e numInsercao.
 * \param codSessao (Obrigatorio) Código que identifica uma sessão do Plenário
 * \param numOrador (Obrigatorio) Identificador do orador na sessão
 * \param numQuarto (Obrigatorio) Número da fração taquigráfica que identifica o início do discurso
 * \param numInsercao (Obrigatorio) Número da inserção taquigráfica que identifica o início do discurso
 */
+ (NSString*)obterInteiroTeorDiscursosPlenarioPorCodSessao:(NSString*)codSessao comNumOrador:(NSString*)numOrador comNumQuarto:(NSString*)numQuarto comNumInsercao:(NSString*)numInsercao;

@end
