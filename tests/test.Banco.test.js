const Test = require('supertest/lib/test');
const { cadastrarUsuario, buscarUsuario, fecharBD, fazerPost} = require('../banco');


// TESTE CT01


// describe('CT-001 - Criar usuário com dados válidos', () => {
//     const usuario = {
//         user: "VictoryGrey",
//         email: "victory@gmail.com",
//         senha: "Vic123"};
//     test('fazer cadastro', async () => {
//         await expect(cadastrarUsuario(usuario.user, usuario.email, usuario.senha)).resolves.toBeUndefined();
//     });
//     test('retorna o usuário criado', async () => {
//         const usuarioCadastrado = await buscarUsuario(usuario);
//         expect(usuarioCadastrado).toBeDefined();
//         expect(usuarioCadastrado.usu_nomeusuario).toBe(usuario.user);
//         expect(usuarioCadastrado.usu_email).toBe(usuario.email);
//     });
// });


// TESTE CT02

// describe('CT-002 - Criar usuário com e-mail já cadastrado', () => {
//     const usuario = {
//         user: "VictoryGrey2",
//         email: "victory@gmail.com", // mesmo email
//         senha: "Vic1234"};
//     test('deve lançar erro ao tentar cadastrar um usuário com e-mail já existente', async () => {
//         await expect(cadastrarUsuario(usuario.user, usuario.email, usuario.senha)).rejects.toThrow();
//     });
// });



// TESTE CT03

// describe('CT-003	Criar usuário com username já cadastrado', () => {
//     const usuario = {
//         user: "VictoryGrey",
//         email: "victory2@gmail.com",
//         senha: "Vic12345"};
//     test('deve lançar erro ao tentar cadastrar um usuário com nome de usuário já existente', async () => {
//         await expect(cadastrarUsuario(usuario.user, usuario.email, usuario.senha)).rejects.toThrow();
//     });
// });


// TESTE CT04

// describe('CT-004 Criar usuário com campos obrigatórios vazios', () => {
//     const usuario = {
//         user: "",
//         email: "",
//         senha: ""
//     };
//     test('deve lançar erro ao tentar cadastrar um usuário com informações vazias', async () => {
//         await expect(cadastrarUsuario(usuario.user, usuario.email, usuario.senha)).rejects.toThrow();
//     });
// });



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// TESTE Buscar Usuário

// describe('CT-00?? - Buscar Usuario no banco', () => {
//     const usuario = {
//         user: "VictoryGrey",
//         email: "victory@gmail.com",
//         senha: "Vic123"};
//     const usuario2 = {
//         user: "TesteDeExistencia",
//         email: "existentencia@gmail.com",
//         senha: "exe123"};
        
//     test('retorna usuário', async () => {
//         const usuarioCadastrado = await buscarUsuario(usuario);
//         expect(usuarioCadastrado.usu_nomeusuario).toBe(usuario.user);
//         expect(usuarioCadastrado.usu_email).toBe(usuario.email);
//     });
//     test('não retorna usuario', async () => {
//         const result = await buscarUsuario(usuario2);
//         expect(result).toBeNull();
//     });
// });


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// /////////////////////////// TESTE DE POST

// describe('CT-009 Fazer Fazer publicação com sucesso', () => {
//     const usuario = {
//         usu_codigo: 6};
//     const publi = {
//         conteudo: "Bom dia Comunidade! Espero que estejam bem",
//         anexo: null
//     };
//     test('deve fazer um post', async () => {
//         await expect(fazerPost(usuario, publi.conteudo, publi.anexo)).resolves.toBeUndefined();
//     });
// });



// describe('CT-010 Fazer Fazer publicação com dados ínvalidos', () => {
//     const publi = {
//         conteudo: null,
//         anexo: null
//     };
//     test('Publicação sem usuario, ou usuario inexistente, deve retornar um erro', async () => {
//         const usuario = {
//             usu_codigo: 8};
//         await expect(fazerPost(usuario, publi.conteudo, publi.anexo)).rejects.toThrow();
//     });
//     test('Publicação sem conteudo, deve retornar um erro', async () => {
//         const usuario = {
//             usu_codigo: 6};
//         await expect(fazerPost(usuario, publi.conteudo, publi.anexo)).rejects.toThrow();
//     });
// });
















afterAll(async () => {
    await fecharBD();
});