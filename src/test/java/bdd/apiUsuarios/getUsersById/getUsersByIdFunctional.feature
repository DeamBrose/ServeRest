Feature: Buscar usuarios por ID

  Background:
    * url urlBase + "/usuarios"
    #schemas
    * def schemaResponseOk = read("classpath:schema/getUsersById/getUserByIdResponseOk.json")
    * def schemaResponseNoOk = read("classpath:schema/getUsersById/getResponseByIdResponseNoOk.json")
    #helpers
    * def dataGen = read('classpath:helpers/dataGenerator.js')
    #features
    * def listUsers = call read("classpath:bdd/apiUsuarios/getUsers/getUsersFunctional.feature@listUsers")

  @regresion
  Scenario: validar que busque un usuario con id existente - Test ok
    * def list = listUsers.responseList.usuarios
    * def idUser = Math.floor(Math.random() * list.length)
    * def idUserRandom = list[idUser]._id
    * print 'idUser:', idUserRandom
    Given path idUserRandom
    When method get
    Then status 200
    And match response._id == idUserRandom
    And match response == schemaResponseOk

  @regresion
  Scenario: validar que busque un usuario con id no existente - Test no ok
    * def idGen = dataGen().randomString(16)
    * print 'idUser:', idGen
    Given path idGen
    When method get
    Then status 400
    And match response.message == "Usuário não encontrado"
    And match response == schemaResponseNoOk

  @regresion
  Scenario: validar que busque un usuario con id menos de 16 caracteres - Test no ok
    * def idGen = dataGen().randomString(15)
    * print 'idUserError:', idGen
    Given path idGen
    When method get
    Then status 400
    And match response.id == "id deve ter exatamente 16 caracteres alfanuméricos"
    And match response == schemaResponseNoOk

  @regresion
  Scenario: validar que busque un usuario con id mayor de 16 caracteres - Test no ok
    * def idGen = dataGen().randomString(17)
    * print 'idUserError:', idGen
    Given path idGen
    When method get
    Then status 400
    And match response.id == "id deve ter exatamente 16 caracteres alfanuméricos"
    And match response == schemaResponseNoOk

