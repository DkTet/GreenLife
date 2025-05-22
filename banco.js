const { query } = require('express');
const mysql = require('mysql2/promise');
const bcrypt = require('bcrypt');

// Função de Conexão do Banco de Dados
async function conectarBD() {
    if(global.connection && global.connection.state !== 'disconnected'){
        return global.connection;}
    const con = await mysql.createConnection({
        host: 'localhost',
        port: 3306, 
        user: 'root',
        password: '159753',
        database: 'greenlife'});
    global.connection=con;
    return global.connection;
}

async function fecharBD() {
    if (global.connection && global.connection.end) {
        await global.connection.end();
    }
}




///////// FUNÇÔES DE USUARIOS
// Função Para Cadastras Usuario
async function cadastrarUsuario(usuario, email, senha) {
    const conex = await conectarBD();
    const hashSenha = await bcrypt.hash(senha, 10);
    const sql = 'insert into usuarios(usu_nomeusuario, usu_email, usu_senha) values (?,?,?);';
    await conex.query(sql, [usuario, email, hashSenha]);
}

// Função de Buscar Usuario
async function buscarUsuario(usuario){
    const conex = await conectarBD();
    const sql = 'select * from usuarios where usu_email=?;';
    const [usuarioEncontrado] = await conex.query(sql,[usuario.email]);
    let user;
    if (Array.isArray(usuarioEncontrado) && usuarioEncontrado.length > 0)
        user = usuarioEncontrado[0];
    else
        user = null;
    if (!user) return null;
    const senhaCorreta = await bcrypt.compare(usuario.senha, user.usu_senha);
    if (!senhaCorreta) return null;
    return user;
}





///////// FUNÇÔES DE Publicações
async function fazerPost(usuario, conteudo, imagem) {
    const banco = await conectarBD();
    const sql = 'insert into publicacoes(pub_conteudo, pub_anexo, usu_codigo) values (?,?,?);';
    await banco.query(sql, [conteudo, imagem, usuario.usu_codigo]);
}

async function buscarFeed() {
    const banco = await conectarBD();
    const sql = `select 
            p.pub_codigo,
            p.pub_conteudo,
            date_format(p.pub_criado , '%d %b %Y, %Hh%i') as pub_criado ,
            p.pub_repostado,
            p.pub_qtdrespostas,
            p.pub_qtdrepostado,
            p.pub_qtdcurtiu,
            p.pub_qtdsalvo,
            p.pub_anexo,
            u.usu_nomeusuario,
            u.usu_foto,
            u.usu_codigo,
            orig.usu_nomeusuario as user_original
        from publicacoes p
        join usuarios u on p.usu_codigo = u.usu_codigo
        left join publicacoes p2 on p.pub_repostado = p2.pub_codigo
        left join usuarios orig on p2.usu_codigo = orig.usu_codigo
        order by p.pub_criado desc
        limit 100;`;
    await banco.execute("set lc_time_names = 'pt_BR';");
    const [publicacoes] = await banco.execute(sql);
    return publicacoes;
}

async function BuscarPubliPorId(id) {
    const banco = await conectarBD();
    const sql = 'select * from publicacoes where pub_codigo = ?;';
    const [publis] = await banco.execute(sql, [id]);
    let publi;
    if (Array.isArray(publis) && publis.length > 0)
        publi = publis[0];
    else publi = null;
    return publi;
}

async function repostarPubli(publicacao, user) {
    const banco = await conectarBD();

    const sql1 = 'insert into publicacoes(pub_conteudo, pub_repostado, pub_anexo, usu_codigo) values(?,?,?,?);';
    await banco.query(sql1, [publicacao.pub_conteudo, publicacao.pub_codigo, publicacao.pub_anexo, user.usu_codigo]);

    const sql2 = 'update publicacoes set pub_qtdrepostado = pub_qtdrepostado + 1 where pub_codigo=?;';
    await banco.query(sql2, [publicacao.pub_codigo]);
}

async function curtirPubli(publicacao, user) {
    const banco = await conectarBD();
    const sql = 'select * from curtidas_publicacoes where usu_codigo = ? and pub_codigo = ?;';
    const [resultado] = await banco.query(sql, [user.usu_codigo, publicacao.pub_codigo]);
    if (resultado.length > 0) {
        const sql2 = 'delete from curtidas_publicacoes where usu_codigo = ? and pub_codigo = ?;';
        await banco.query(sql2, [user.usu_codigo, publicacao.pub_codigo]);
        const sql3 = 'update publicacoes set pub_qtdcurtiu = pub_qtdcurtiu - 1 where pub_codigo = ? and pub_qtdcurtiu > 0;';
        await banco.query(sql3, [publicacao.pub_codigo]);
    } else {
        const sql4 = 'insert into curtidas_publicacoes (usu_codigo, pub_codigo) values (?,?);';
        await banco.query(sql4, [user.usu_codigo, publicacao.pub_codigo]);
        const sql5 = 'update publicacoes set pub_qtdcurtiu = pub_qtdcurtiu + 1 where pub_codigo = ?;';
        await banco.query(sql5, [publicacao.pub_codigo]);}
}

async function salvarPubli(publicacao, user) {
    const banco = await conectarBD();
    const sql = 'select * from salvos_publicacoes where usu_codigo = ? and pub_codigo = ?;';
    const [resultado] = await banco.query(sql, [user.usu_codigo, publicacao.pub_codigo]);
    if(resultado.length > 0){
        const sql = 'delete from salvos_publicacoes where usu_codigo = ? and pub_codigo = ?;';
        await banco.query(sql, [user.usu_codigo, publicacao.pub_codigo]);
        const sql2 = 'update publicacoes set pub_qtdsalvo = pub_qtdsalvo - 1 where pub_codigo = ? and pub_qtdsalvo > 0;';
        await banco.query(sql2, [publicacao.pub_codigo]);
    }else{
        const sql3 = 'insert into salvos_publicacoes (usu_codigo, pub_codigo) values (?, ?);';
        await banco.query(sql3, [user.usu_codigo, publicacao.pub_codigo]);
        const sql4 = 'update publicacoes set pub_qtdsalvo = pub_qtdsalvo + 1 where pub_codigo = ?;';
        await banco.query(sql4, [publicacao.pub_codigo]);}
}

async function buscarComentariosPubli(id) {
    const banco = await conectarBD();
    const sql = `select
            c.com_codigo,
            c.com_conteudo,
            date_format(c.com_criado , '%d %b %Y, %Hh%i') as com_criado,
            c.com_curtidas,
            c.com_deslikes,
            c.com_resposta,
            u.usu_nomeusuario,
            u.usu_foto,
            u.usu_codigo
        from comentarios c
        join usuarios u on c.usu_codigo = u.usu_codigo
        where c.pub_codigo = ?
        order by c.com_criado desc;`;
    const [coments] = await banco.query(sql, [id]);
    return montarHierarquiaComentarios(coments);
}

async function BuscarPubliPorIdResp(id) {
    const banco = await conectarBD();
    const sql = ` SELECT 
            p.pub_codigo,
            p.pub_conteudo,
            date_format(p.pub_criado , '%d %b %Y, %Hh%i') as pub_criado ,
            p.pub_repostado,
            p.pub_qtdrespostas,
            p.pub_qtdrepostado,
            p.pub_qtdcurtiu,
            p.pub_qtdsalvo,
            p.pub_anexo, 
            u.usu_nomeusuario, 
            u.usu_foto,
            u.usu_codigo,
        (select u2.usu_nomeusuario 
            from publicacoes pr
            join usuarios u2 on pr.usu_codigo = u2.usu_codigo
            where pr.pub_codigo = p.pub_repostado
            limit 1) as user_original
        from publicacoes p
        join usuarios u on p.usu_codigo = u.usu_codigo
        where p.pub_codigo = ? and p.pub_bloqueado = 0
        limit 1;`;
    const [resultado] = await banco.query(sql, [id]);
    return resultado[0];
}

async function fazerComentPubli(conteudo, id, user){
    const banco = await conectarBD();
    const sql = 'insert into comentarios (com_conteudo, usu_codigo, pub_codigo) values (?,?,?);';
    await banco.query(sql,[conteudo, user.usu_codigo, id]);
    const sql2 = 'update publicacoes set pub_qtdrespostas = pub_qtdrespostas + 1 where pub_codigo = ?;';
    await banco.query(sql2, [id]);
}

async function comentarioComent(conteudo, user, pubId, comentId) {
    const banco = await conectarBD();
    const sql = 'insert into comentarios (com_conteudo, usu_codigo, pub_codigo, com_resposta) values (?,?,?,?);';
    await banco.query(sql,[conteudo, user.usu_codigo, pubId, comentId]);
    const sql2 = 'update publicacoes set pub_qtdrespostas = pub_qtdrespostas + 1 where pub_codigo = ?;';
    await banco.query(sql2, [pubId]);
}



///////// FUNÇÔES DE Atividades
async function buscarAtividades(){
    const banco = await conectarBD();
    const sql = `select 
            p.pub_codigo,
            p.pub_conteudo,
            date_format(p.pub_criado , '%d %b %Y, %Hh%i') as pub_criado ,
            p.pub_repostado,
            p.pub_qtdrespostas,
            p.pub_qtdrepostado,
            p.pub_qtdcurtiu,
            p.pub_qtdsalvo,
            p.pub_anexo,
            u.usu_nomeusuario,
            u.usu_foto,
            u.usu_codigo,
            orig.usu_nomeusuario as user_original
        from publicacoes p
        join usuarios u on p.usu_codigo = u.usu_codigo
        left join publicacoes p2 on p.pub_repostado = p2.pub_codigo
        left join usuarios orig on p2.usu_codigo = orig.usu_codigo
        order by p.pub_qtdcurtiu desc
        limit 20;`;
    await banco.execute("set lc_time_names = 'pt_BR';");
    const [atividades] = await banco.execute(sql);
    return atividades;
}




///////// FUNÇÔES DE Dicas do Dia
async function buscarDicaDoDia() {
    const banco = await conectarBD();
    const sql = 'select * from dia_dica where date(dia_criado) = curdate() order by dia_criado desc limit 1;';
    const [diadica] = await banco.execute(sql);
    return diadica;
}




///////// FUNÇÔES DE Dicas
async function buscarCategorias() {
    const banco = await conectarBD();
    const sql = 'select cat_codigo, cat_nome from categorias;';
    const [cats] = await banco.query(sql);
    return cats;
}

async function buscarDicas() {
    const banco = await conectarBD();
    const sql = `select 
            d.dic_codigo,
            d.dic_titulo,
            d.dic_conteudo,
            d.dic_imagem,
            date_format(d.dic_data, '%d %b %Y') as dic_data,
            a.adm_codigo,
            a.adm_nome,
            c.cat_codigo,
            c.cat_nome
        from dicas d
        join admins a on d.adm_codigo = a.adm_codigo
        join categorias c on d.cat_codigo = c.cat_codigo
        order by d.dic_data desc
        limit 100;`;
    await banco.execute("set lc_time_names = 'pt_BR';");
    const [dicas] = await banco.execute(sql);
    return dicas;
}

async function buscarDicaId(id) {
    const banco = await conectarBD();
    const sql = `select 
        d.dic_codigo,
        d.dic_titulo,
        d.dic_conteudo,
        d.dic_imagem,
        date_format(d.dic_data, '%d de %b de %Y') as dic_data,
        a.adm_codigo,
        a.adm_nome,
        c.cat_codigo,
        c.cat_nome
    from dicas d
    join admins a on d.adm_codigo = a.adm_codigo
    join categorias c on d.cat_codigo = c.cat_codigo
    where d.dic_codigo = ?;`;
    await banco.execute("set lc_time_names = 'pt_BR';");
    const [dica] = await banco.query(sql, [id]);
    return dica[0];
}

async function salvarDica(idDic, idUser) {
    const banco = await conectarBD();
    const sql = 'select * from salvos_dicas where usu_codigo = ? and dic_codigo = ?;';
    const [resp] = await banco.query(sql, [idUser, idDic]);
    if(resp.length > 0){
        const sql1 = 'delete from salvos_dicas where usu_codigo = ? and dic_codigo = ?;';
        await banco.query(sql1, [idUser, idDic]);
    } else {
        const sql2 = 'insert into salvos_dicas (usu_codigo, dic_codigo) values (?,?);';
        await banco.query(sql2, [idUser, idDic]);
    }
}

async function buscarComentariosDicas(id) {
    const banco = await conectarBD();
    const sql = `select
            c.com_codigo,
            c.com_conteudo,
            date_format(c.com_criado , '%d %b %Y, %Hh%i') as com_criado,
            c.com_curtidas,
            c.com_deslikes,
            c.com_resposta,
            u.usu_nomeusuario,
            u.usu_foto,
            u.usu_codigo
        from comentarios c
        join usuarios u on c.usu_codigo = u.usu_codigo
        where c.dic_codigo = ?
        order by c.com_criado desc;`;
    const [coments] = await banco.query(sql, [id]);
    return montarHierarquiaComentarios(coments);
}

async function fazerComentDica(conteudo, id, user) {
    const banco = await conectarBD();
    const sql = 'insert into comentarios(com_conteudo, usu_codigo, dic_codigo) values (?,?,?);';
    await banco.query(sql, [conteudo, user.usu_codigo, id]);
}

async function comentarioComentDica(conteudo, user, dicId, comentId) {
    const banco = await conectarBD();
    const sql = 'insert into comentarios (com_conteudo, usu_codigo, dic_codigo, com_resposta) values (?,?,?,?);';
    await banco.query(sql,[conteudo, user.usu_codigo, dicId, comentId]);
}





// FUNÇÔES DE Comentários
async function curtirComent(user, id) {
    const banco = await conectarBD();

    const sqlVerfC = 'select * from curtidas_comentarios where usu_codigo = ? and com_codigo = ?;';
    const [curtida] = await banco.query(sqlVerfC , [user.usu_codigo, id]);

    const sqlVerfD = 'select * from deslikes_comentarios where usu_codigo = ? and com_codigo = ?;';
    const [deslike] = await banco.query(sqlVerfD, [user.usu_codigo, id]);

    if (deslike.length > 0) {
        const sql1 = 'delete from deslikes_comentarios where usu_codigo = ? and com_codigo = ?;';
        await banco.query(sql1, [user.usu_codigo, id]);
        const sql2 = 'update comentarios set com_deslikes = com_deslikes - 1 where com_codigo = ? and com_deslikes > 0;';
        await banco.query(sql2, [id]);}

    if (curtida.length > 0){
        const sql3 = 'delete from curtidas_comentarios where usu_codigo = ? and com_codigo = ?;';
        await banco.query(sql3, [user.usu_codigo, id]);
        const sql4 = 'update comentarios set com_curtidas = com_curtidas - 1 where com_codigo = ? and com_curtidas > 0;';
        await banco.query(sql4, [id]);
    } else {
        const sql5 = 'insert into curtidas_comentarios (usu_codigo, com_codigo) values (?,?);';
        await banco.query(sql5, [user.usu_codigo, id]);

        const sql6 = 'update comentarios set com_curtidas = com_curtidas + 1 where com_codigo = ?;';
        await banco.query(sql6, [id]);}
}

async function deslikeComent(user, id) {
    const banco = await conectarBD();

    const sqlVerfC = 'select * from curtidas_comentarios where usu_codigo = ? and com_codigo = ?;';
    const [curtida] = await banco.query(sqlVerfC , [user.usu_codigo, id]);

    const sqlVerfD = 'select * from deslikes_comentarios where usu_codigo = ? and com_codigo = ?;';
    const [deslike] = await banco.query(sqlVerfD, [user.usu_codigo, id]);

    if (curtida.length > 0) {
    const sql1 = 'delete from curtidas_comentarios where usu_codigo = ? and com_codigo = ?;';
    await banco.query(sql1, [user.usu_codigo, id]);
    const sql2 = 'update comentarios set com_curtidas = com_curtidas - 1 where com_codigo = ? and com_curtidas > 0;';
    await banco.query(sql2, [id]);}

    if (deslike.length > 0) {
        const sql2 = 'delete from deslikes_comentarios where usu_codigo = ? and com_codigo = ?;';
        await banco.query(sql2, [user.usu_codigo, id]);

        const sql3 = 'update comentarios set com_deslikes = com_deslikes - 1 where com_codigo = ? and com_deslikes > 0;';
        await banco.query(sql3, [id]);
    } else {
        const sql4 = 'insert into deslikes_comentarios (usu_codigo, com_codigo) values (?,?);';
        await banco.query(sql4, [user.usu_codigo, id]);

        const sql5 = 'update comentarios set com_deslikes = com_deslikes + 1 where com_codigo = ?;';
        await banco.query(sql5, [id]);}
}

function montarHierarquiaComentarios(lista) {
    const mapa = {};
    const raiz = [];

    lista.forEach(com => {
        com.respostas = [];
        mapa[com.com_codigo] = com;});

    lista.forEach(com => {
        if (com.com_resposta) {
            const pai = mapa[com.com_resposta];
            if (pai) pai.respostas.push(com);
        } else {
            raiz.push(com);}});
    return raiz;
}




//FUNÇÔES de Salvos


module.exports= {conectarBD, fecharBD, buscarUsuario, cadastrarUsuario, buscarFeed, buscarDicaDoDia, fazerPost, BuscarPubliPorId, repostarPubli, curtirPubli, salvarPubli, buscarAtividades, buscarComentariosPubli, BuscarPubliPorIdResp, fazerComentPubli, comentarioComent, curtirComent, deslikeComent, buscarDicas, buscarCategorias, buscarDicaId, salvarDica, buscarComentariosDicas, fazerComentDica, comentarioComentDica}


