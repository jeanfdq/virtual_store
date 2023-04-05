class GetFirebaseErrors {
  static String authExceptionsMessage(String code) {
    switch (code) {
      case 'invalid-email':
        return 'Seu e-mail é inválido.';
      case 'wrong-password':
        return 'Sua senha está incorreta.';
      case 'user-not-found':
        return 'Usuário não encontrado com este e-mail.';
      case 'user-disabled':
        return 'Este usuário foi desabilitado.';
      case 'email-already-in-use':
        return 'E-mail informado já cadastrado';
      default:
        return 'Não conseguimos criar a conta';
    }
  }

  static String createUserExceptionsMessage(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'E-mail já está sendo utilizado em outra conta.';
      case 'invalid-email':
        return 'Seu e-mail é inválido.';
      case 'operation-not-allowed':
        return 'Operação não permitida.';
      case 'weak-password':
        return 'Sua senha é muito fraca.';
      default:
        return 'Não conseguimos criar a conta';
    }
  }
}
