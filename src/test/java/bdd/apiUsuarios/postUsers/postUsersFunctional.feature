Feature: Não é permitido cadastrar usuário com email já utilizado

  Background:
    * url urlBase + "/usuarios"
    #schemas
    * def schemaResponseOk = read("classpath:schema/postUsers/postUserResponseOk.json")
    * def schemaResponseNoOk = read("classpath:schema/postUsers/postUserResponseNoOk.json")
    #helpers
    * def dataGen = read('classpath:helpers/dataGenerator.js')
    #body
    * def body = read("classpath:bdd/body/postUsers/postUsersBody.json")

  @regresion
  Scenario: validar que la api registre un usuario nuevo administrador - Test ok
    * def newUser = dataGen().generateUserData(true)
    * print 'Payload generado:', newUser
    #Given No se requieren parámetros ni paths adicionales para registrar usuarios
    And request newUser
    When method post
    Then status 201
    And match response.message == "Cadastro realizado com sucesso"
    And match response == schemaResponseOk

  @regresion
  Scenario: validar que la api registre un usuario nuevo no administrador - Test ok
    * def newUser = dataGen().generateUserData(false)
    * print 'Payload generado:', newUser
    #Given No se requieren parámetros ni paths adicionales para registrar usuarios
    And request newUser
    When method post
    Then status 201
    And match response.message == "Cadastro realizado com sucesso"
    And match response == schemaResponseOk

  @regresion
  Scenario: validar que la api no registre un usuario con los campos vacios - Test no ok
    #Given No se requieren parámetros ni paths adicionales para registrar usuarios
    And request body
    When method post
    Then status 400
    And match response.nome == "nome não pode ficar em branco"
    And match response.email == "email não pode ficar em branco"
    And match response.password == "password não pode ficar em branco"
    And match response.administrador == "administrador deve ser 'true' ou 'false'"
    And match response == schemaResponseNoOk

  @regresion
  Scenario: validar que la api no registre un usuario solo con el campo nome y los otros campos vacios - Test no ok
    * set body.nome = "userTest" + dataGen().randomString(10)
    #Given No se requieren parámetros ni paths adicionales para registrar usuarios
    And request body
    When method post
    Then status 400
    And match response.email == "email não pode ficar em branco"
    And match response.password == "password não pode ficar em branco"
    And match response.administrador == "administrador deve ser 'true' ou 'false'"
    And match response == schemaResponseNoOk

  @regresion
  Scenario: validar que la api no registre un usuario solo con el campo email y los otros campos vacios - Test no ok
    * set body.email = dataGen().randomEmail()
    #Given No se requieren parámetros ni paths adicionales para registrar usuarios
    And request body
    When method post
    Then status 400
    And match response.nome == "nome não pode ficar em branco"
    And match response.password == "password não pode ficar em branco"
    And match response.administrador == "administrador deve ser 'true' ou 'false'"
    And match response == schemaResponseNoOk

  @regresion
  Scenario: validar que la api no registre un usuario solo con el campo password y los otros campos vacios - Test no ok
    * set body.password = dataGen().randomString(13)
    #Given No se requieren parámetros ni paths adicionales para registrar usuarios
    And request body
    When method post
    Then status 400
    And match response.nome == "nome não pode ficar em branco"
    And match response.email == "email não pode ficar em branco"
    And match response.administrador == "administrador deve ser 'true' ou 'false'"
    And match response == schemaResponseNoOk

  @regresion
  Scenario: validar que la api no registre un usuario solo con el campo administrador y los otros campos vacios - Test no ok
    * set body.administrador = "true"
    #Given No se requieren parámetros ni paths adicionales para registrar usuarios
    And request body
    When method post
    Then status 400
    And match response.nome == "nome não pode ficar em branco"
    And match response.email == "email não pode ficar em branco"
    And match response.password == "password não pode ficar em branco"
    And match response == schemaResponseNoOk