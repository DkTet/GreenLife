var express = require('express');
var router = express.Router();
const multer = require('multer');
const fs = require('fs');
const path = require('path');
const upload = multer({ dest: 'public/images/imgPosts' });
global.usuarioLogado = {};



//
// GETS
//

//Get Index
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Login - GreenLife' });
});

// Get para Login
router.get('/login', function(req, res, next) {
  res.render('index', { title: 'Login - GreenLife' });
});

// Get para Registro
router.get('/registro', function(req, res, next) {
  res.render('registro', { title: 'Registro -  GreenLife' });
});

// Get Sair
router.get('/sair', async function(req, res, next) {
  global.usuarioLogado = null;
  res.redirect('/');
});

// Get para Timeline
router.get('/timeline', async (req, res, next) => {
  verificarLogin(res);
  const publicacoes = await global.db.buscarFeed();
  const dicaDia = await global.db.buscarDicaDoDia();
  const atividades = await global.db.buscarAtividades();
  res.render('timeline', {
    title: 'Greenlife',
    usuario: global.usuarioLogado,
    publicacoes,
    dicaDia,
    atividades
  });
});

//Get Dicas
router.get('/dicas', async function(req, res, next) {
  verificarLogin(res);
  const dicaDia = await global.db.buscarDicaDoDia();
  const atividades = await global.db.buscarAtividades();
  const dicas = await global.db.buscarDicas();
  const categorias = await global.db.buscarCategorias();
  res.render('dicas', {
    title: 'Dicas',
    usuario: global.usuarioLogado,
    dicas,
    dicaDia,
    atividades,
    categorias
  });
});

//Get Dica
router.get('/dica/:id', async function(req, res, next) {
  verificarLogin(res);
  const id = parseInt(req.params.id);
  const dica = await global.db.buscarDicaId(id);
  const dicaDia = await global.db.buscarDicaDoDia();
  const atividades = await global.db.buscarAtividades();
  const comentario = await global.db.buscarComentariosDicas(id);
  let tDica = dica.dic_titulo;
  let conteudoTexto;
  const caminho = path.resolve('public', 'txtDicas', dica.dic_conteudo.trim());
  conteudoTexto = fs.readFileSync(caminho, 'utf8');
  conteudoTexto = conteudoTexto.replace(/\n/g, '<br>');
  conteudoTexto = conteudoTexto.replace(/\*\*(.*?)\*\*/g, '<br><strong>$1</strong>');
  dica.dic_conteudo = conteudoTexto;
  res.render('dica', {
    title: `Dica - ${tDica}`,
    usuario: global.usuarioLogado,
    dica,
    dicaDia,
    atividades,
    comentario
  });
});

//Get de Salvar Dica
router.get('/salvarDic/:id', async function(req,res,next) {
  verificarLogin(res);
  const id = parseInt(req.params.id);
  const dica = await global.db.buscarDicaId(id);
  await global.db.salvarDica(dica.dic_codigo, global.usuarioLogado.usu_codigo);
  res.redirect('back');
});



//Get de Repostar Publicação
router.get('/repostar/:id', async function(req,res,next) {
  verificarLogin(res);
  const id = parseInt(req.params.id);
  if(!id){
    return res.status(400).render('error', {
      message: 'Id da publicação não informado.',
      error: {}});}
  const publi = await global.db.BuscarPubliPorId(id);
  if(!publi){
    res.status(404).render('error', {
      message: 'Publicaçao não encontrada',
      error: {}});}
  try {
    await global.db.repostarPubli(publi, global.usuarioLogado);
  } catch(erro) {
    return res.status(500).render('error', {
      message: "Erro ao processar a republicaçao",
      error: {}
    });}
  res.redirect('/timeline');
});

//Get de Curtir Publicação
router.get('/curtir/:id', async function(req,res,next) {
  verificarLogin(res);
  const id = parseInt(req.params.id);
  const publi = await global.db.BuscarPubliPorId(id);
  await global.db.curtirPubli(publi, global.usuarioLogado);
  res.redirect('back');
});

//Get de Salvar Publicação
router.get('/salvar/:id', async function(req,res,next) {
  verificarLogin(res);
  const id = parseInt(req.params.id);
  const publi = await global.db.BuscarPubliPorId(id);
  await global.db.salvarPubli(publi, global.usuarioLogado);
  res.redirect('back');
});

//Get de Responder Publicação
router.get('/responderPubli/:id', async function(req,res,next) {
  verificarLogin(res);
  const id = parseInt(req.params.id);
  const publicacao = await global.db.BuscarPubliPorIdResp(id);
  const comentarios = await global.db.buscarComentariosPubli(id);
  const atividades = await global.db.buscarAtividades();
  const dicaDia = await global.db.buscarDicaDoDia();
  let nomeUsuario = publicacao.usu_nomeusuario;
  res.render('publicacao', {
    title: `Publicação - ${nomeUsuario}`,
    usuario: global.usuarioLogado,
    publicacao,
    comentarios,
    atividades,
    dicaDia
  });
});

//Get Curtir Comentário
router.get('/curtirComent/:id', async function(req, res, next) {
  verificarLogin(res);
  const id = parseInt(req.params.id);
  await global.db.curtirComent(global.usuarioLogado, id);
  res.redirect('back');
});

//Get Deslike Comentário
router.get('/deslikeComent/:id', async function(req, res, next) {
  verificarLogin(res);
  const id = parseInt(req.params.id);
  await global.db.deslikeComent(global.usuarioLogado, id);
  res.redirect('back');
});




//
// POSTS
//

//Post Login
router.post('/login', async function(req, res, next) {
  const { email, senha } = req.body;
  const usuario = await global.db.buscarUsuario({ email, senha });
  if (usuario && usuario.usu_codigo) {
    global.usuarioLogado = usuario;
    global.sessao = email;
    res.redirect('/timeline');
  }else{
    res.render('index', { title: 'Login - GreenLife', mensagem: 'E-mail ou senha inválidos!', sucesso: false });}
});

//Post Registro
router.post('/registro', async function(req,res,next) {
  const { usuario, email, senha, confsenha } = req.body;
  if (!usuario || !email || !senha || !confsenha) {
    return res.render('registro', {title: 'Registro -  GreenLife', mensagem: 'Todos os campos são obrigatórios', sucesso: false});}
  if (senha !== confsenha) {
    return res.render('registro', {title: 'Registro -  GreenLife', mensagem: 'As senhas não coincidem', sucesso: false});}
  await global.db.cadastrarUsuario(usuario, email, senha);
  res.redirect('/')
});

//Post Postar
router.post('/fazerpost', upload.single('imagem'), async function(req, res, next) {
  verificarLogin(res);
  const conteudo = req.body.conteudo;
  const imagem = req.file ? req.file.filename : null;
  await global.db.fazerPost(global.usuarioLogado, conteudo, imagem);
  res.redirect('/timeline');
});

// Post Comentar Publicação
router.post('/fazercomentario/:id', async function(req, res, next) {
  verificarLogin(res);
  const idPubli = parseInt(req.params.id);
  const conteudo = req.body.conteudo;
  await global.db.fazerComentPubli(conteudo, idPubli, global.usuarioLogado);
  res.redirect(`/responderPubli/${idPubli}`);
});

// Post Comentar Comentário Publicação
router.post('/responderComent/:pubId/:comentId', async function(req, res, next) { 
  verificarLogin(res);
  const pubId = parseInt(req.params.pubId);
  const comentId = parseInt(req.params.comentId);
  const conteudo = req.body.conteudo;
  await global.db.comentarioComent(conteudo,global.usuarioLogado, pubId, comentId);
  res.redirect(`/responderPubli/${pubId}`);
});

// Post Comentar Dica
router.post('/fazercomentarioDica/:id', async function(req, res, next) {
  verificarLogin(res);
  const idComent= parseInt(req.params.id);
  const conteudo = req.body.conteudo;
  await global.db.fazerComentDica(conteudo, idComent, global.usuarioLogado);
  res.redirect('back');
});


// Post Comentar Comentário Dica
router.post('/responderComentDica/:dicId/:comentId', async function(req, res, next) { 
  verificarLogin(res);
  const dicId = parseInt(req.params.dicId);
  const comentId = parseInt(req.params.comentId);
  const conteudo = req.body.conteudo;
  await global.db.comentarioComentDica(conteudo,global.usuarioLogado, dicId, comentId);
  res.redirect('back');
});

module.exports = router;

function verificarLogin(res){
  if (!global.sessao || global.sessao == ""){
    res.redirect('/');}
}
