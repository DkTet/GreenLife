const { buscarUsuario } = require('../banco');

test('Usuário válido', async () => {
    const usuario = { email: 'xunda@gmail.com', senha: '123' };
    const result = await buscarUsuario(usuario);
    expect(result.usuemail).toBe(usuario.email);
    expect(result.ususenha).toBe(usuario.senha);
});

test('Usuário inválido', async () => {
    const usuario = { email: 'naoexiste@email.com', senha: 'senhaerrada' };
    const result = await buscarUsuario(usuario);
    expect(result).toEqual({});
});
