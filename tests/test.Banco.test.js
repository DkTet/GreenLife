const Test = require('supertest/lib/test');
const { cadastrarUsuario, buscarUsuario, fecharBD, fazerPost, buscarFeed, BuscarPubliPorId} = require('../banco');


// // TESTE CT01


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


// // TESTE CT02

// describe('CT-002 - Criar usuário com e-mail já cadastrado', () => {
//     const usuario = {
//         user: "VictoryGrey2",
//         email: "victory@gmail.com", // mesmo email
//         senha: "Vic1234"};
//     test('deve lançar erro ao tentar cadastrar um usuário com e-mail já existente', async () => {
//         await expect(cadastrarUsuario(usuario.user, usuario.email, usuario.senha)).rejects.toThrow();
//     });
// });



// // TESTE CT03

// describe('CT-003	Criar usuário com username já cadastrado', () => {
//     const usuario = {
//         user: "VictoryGrey",
//         email: "victory2@gmail.com",
//         senha: "Vic12345"};
//     test('deve lançar erro ao tentar cadastrar um usuário com nome de usuário já existente', async () => {
//         await expect(cadastrarUsuario(usuario.user, usuario.email, usuario.senha)).rejects.toThrow();
//     });
// });


// // TESTE CT04

// describe('CT-004 Criar usuário com campos obrigatórios vazios', () => {
//     const usuario = {
//         user: null,
//         email: null,
//         senha: null
//     };
//     test('deve lançar erro ao tentar cadastrar um usuário com informações vazias', async () => {
//         await expect(cadastrarUsuario(usuario.user, usuario.email, usuario.senha)).rejects.toThrow();
//     });
// });



// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// // TESTE Login

// describe('Testes de Login', () => {
//     const usuario = {
//         user: "VictoryGrey",
//         email: "victory@gmail.com",
//         senha: "Vic123"};
//     const usuario2 = {
//         user: "VictoryGrey",
//         email: "victory@gmail.com",
//         senha: "Vic123456789"};
//     const usuario3 = { 
//         email: "victory2@gmail.com", 
//         senha: "sVic12345"};
        
//     test('CT-005 - Login com credenciais corretas', async () => {
//         const usuarioCadastrado = await buscarUsuario(usuario);
//         expect(usuarioCadastrado.usu_nomeusuario).toBe(usuario.user);
//         expect(usuarioCadastrado.usu_email).toBe(usuario.email);
//     });
//     test('CT-006 - Login com senha incorreta', async () => {
//         const result = await buscarUsuario(usuario2);
//         expect(result).toBeNull();
//     });

//     test('CT-007 - Login com usuário inexistente', async () => {
//         const result = await buscarUsuario(usuario3);
//         expect(result).toBeNull();
//     });
// });


// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// // /////////////////////////// TESTE DE POST

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





// //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// // /////////////////////////// TESTE DE BUSCAR FEED

// describe('CT-030 - Buscar feed com publicações existentes', () => {
//    test('deve retornar uma lista de publicações com campos esperados', async () => {
//        const resultado = await buscarFeed();

//        expect(Array.isArray(resultado)).toBe(true);
//        expect(resultado.length).toBeGreaterThan(0);

//        const publicacao = resultado[0];

//        expect(publicacao).toHaveProperty('pub_codigo');
//        expect(publicacao).toHaveProperty('pub_conteudo');
//        expect(publicacao).toHaveProperty('pub_criado');
//        expect(publicacao).toHaveProperty('pub_repostado');
//        expect(publicacao).toHaveProperty('pub_qtdrespostas');
//        expect(publicacao).toHaveProperty('pub_qtdrepostado');
//        expect(publicacao).toHaveProperty('pub_qtdcurtiu');
//        expect(publicacao).toHaveProperty('pub_qtdsalvo');
//        expect(publicacao).toHaveProperty('pub_anexo');
//        expect(publicacao).toHaveProperty('usu_nomeusuario');
//        expect(publicacao).toHaveProperty('usu_foto');
//        expect(publicacao).toHaveProperty('usu_codigo');
//        expect(publicacao).toHaveProperty('user_original');
//     });
// });

// describe('CT-031 - Verificar limite máximo de publicações retornadas', () => {
//  test('não deve retornar mais que 100 publicações', async () => {
//    const resultado = await buscarFeed();
//    expect(resultado.length).toBeLessThanOrEqual(100);
//   });
// });

// describe('CT-032 - Buscar publicação por ID existente', () => {
//     test('deve retornar a publicação correta', async () => {
//         const id = 5;
//         const publi = await BuscarPubliPorId(id);

//         expect(publi).not.toBeNull();
//         expect(publi).toHaveProperty('pub_codigo', id);
//         expect(publi).toHaveProperty('pub_conteudo');
//         expect(publi).toHaveProperty('pub_criado');
//     });
// });

// describe('CT-033 - Buscar publicação por ID inexistente', () => {
//    test('deve retornar null se não existir publicação com esse ID', async () => {
//         const id = 9999; 
//         const publi = await BuscarPubliPorId(id);
//         expect(publi).toBeNull();
//    });
// });

// describe('CT-034 - Buscar feed vazio', () => {
//       test('deve retornar uma lista vazia quando não há publicações', async () => {
//          const resultado = await buscarFeed();
 
//          expect(Array.isArray(resultado)).toBe(true);
//          expect(resultado.length).toBe(0);
//      });
// });









afterAll(async () => {
    await fecharBD();
});