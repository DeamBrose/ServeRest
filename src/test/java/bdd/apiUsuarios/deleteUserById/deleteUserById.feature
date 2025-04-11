Feature: Não é permitido excluir usuário com carrinho.

  Background:
    * url urlBase + "/usuarios"
    #schemas
    * def schemaResponseOk = read("classpath:schema/deleteUserById/deleteUserResponseOk.json")
    * def schemaResponseNoOk = read("classpath:schema/deleteUserById/deleteUserResponseNoOK.json")
    #data
    * def data = read("classpath:data/apiUsuarios/deleteUsers/deleteUserData.json")
    #helpers
    * def dataGen = read('classpath:helpers/dataGenerator.js')
    #features
    * def listUsers = call read("classpath:bdd/apiUsuarios/getUsers/getUsersFunctional.feature@listUsers")

  @regresion @deleteAndReturnId
  Scenario: validar que se elimine un usuario con un id existente - Test ok
    * def list = listUsers.responseList.usuarios
    * def idUser = Math.floor(Math.random() * list.length)
    * def idUserRandom = list[idUser]._id
    * print 'idUserdelete:', idUserRandom
    Given path idUserRandom
    When method delete
    Then status 200
    And match response.message == "Registro excluído com sucesso"
    And match response == schemaResponseOk
    * def idSave = idUserRandom

  @regresion
  Scenario: validar que no se pueda eliminar un usuario con un id ya eliminado - Test No ok
    * def deleteAttempt = call read("classpath:bdd/apiUsuarios/deleteUserById/deleteUserById.feature@deleteAndReturnId")
    * def userIdDeleted = deleteAttempt.idSave
    * print 'idUserdeleted:', userIdDeleted
    Given path userIdDeleted
    When method delete
    Then status 200
    And match response.message == "Nenhum registro excluído"
    And match response == schemaResponseOk

  @regresion
  Scenario: validar que no se elimine un usuario con un id no existente - Test No ok
    * def userIdNoRegistered = dataGen().randomString(16)
    * print 'idUser:', userIdNoRegistered
    Given path userIdNoRegistered
    When method delete
    Then status 200
    And match response.message == "Nenhum registro excluído"
    And match response == schemaResponseOk

  @regresion
  Scenario: validar que no elimine un usuario con un id que tenga un carrito - Test No ok
    * def userIdWithCarrito = data.testFunctionals.userIdWithCarrito
    * print 'userIdWithCarrito:', userIdWithCarrito
    Given path userIdWithCarrito
    When method delete
    Then status 400
    And match response.message == "Não é permitido excluir usuário com carrinho cadastrado"
    And match response.idCarrinho == "aG7WKQvAAmvJMUFP"
    And match response == schemaResponseNoOk

