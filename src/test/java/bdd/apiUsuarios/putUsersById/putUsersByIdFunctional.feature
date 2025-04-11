Feature: Não é permitido cadastrar usuário com email já utilizado.
  Caso não seja encontrado usuário com o ID informado é realizado novo cadastro ao invés de alteração.

  Background:
    * url urlBase + "/usuarios"
    #schemas
    * def schemaResponseOk = read("classpath:schema/putUserById/putUserByIdResponseOk.json")
    * def schemaResponseNoOk = read("classpath:schema/putUserById/putUserByIdResponseNoOk.json")
    #helpers
    * def dataGen = read('classpath:helpers/dataGenerator.js')
    #features
    * def listUsers = call read("classpath:bdd/apiUsuarios/getUsers/getUsersFunctional.feature@listUsers")
    #Body
    * def body = read('classpath:helpers/dataGenerator.js')

  @regresion
  Scenario: validar que busque un id existente y actualice el registro de todos los campos - Test ok
    * def list = listUsers.responseList.usuarios
    * def index = Math.floor(Math.random() * list.length)
    * def idUserRandom = list[index]._id
    * print "idRandom: ", idUserRandom
    * def newBody = dataGen().generateUserData(true)
    Given path idUserRandom
    And request newBody
    When method put
    Then status 200
    And match response.message == "Registro alterado com sucesso"
    And match response == schemaResponseOk

  @regresion
  Scenario: validar que busque un id no existente y que ingrese un nuevo registro - Test ok
    * def idUserRandom = dataGen().randomString(16)
    * print "idRandom: ", idUserRandom
    * def newBody = dataGen().generateUserData(true)
    Given path idUserRandom
    And request newBody
    When method put
    Then status 201
    And match response.message == "Cadastro realizado com sucesso"
    And match response == schemaResponseOk

  @regresion
  Scenario: validar que busque un id no registrado y realizar un registro con el campo nome vacio  - Test no ok
    * def idUserRandom = dataGen().randomString(16)
    * print "idRandom: ", idUserRandom
    * def newBody = dataGen().generateUserData(true)
    * set newBody.nome = ""
    Given path idUserRandom
    And request newBody
    When method put
    Then status 400
    And match response.nome == "nome não pode ficar em branco"
    And match response == schemaResponseNoOk

  @regresion
  Scenario: validar que busque un id no registrado y realizar un registro con el campo email vacio  - Test no ok
    * def idUserRandom = dataGen().randomString(16)
    * print "idRandom: ", idUserRandom
    * def newBody = dataGen().generateUserData(true)
    * set newBody.email = ""
    Given path idUserRandom
    And request newBody
    When method put
    Then status 400
    And match response.email == "email não pode ficar em branco"
    And match response == schemaResponseNoOk

  @regresion
  Scenario: validar que busque un id no registrado y realizar un registro con el campo password vacio  - Test no ok
    * def idUserRandom = dataGen().randomString(16)
    * print "idRandom: ", idUserRandom
    * def newBody = dataGen().generateUserData(true)
    * set newBody.password = ""
    Given path idUserRandom
    And request newBody
    When method put
    Then status 400
    And match response.password == "password não pode ficar em branco"
    And match response == schemaResponseNoOk

  @regresion
  Scenario: validar que busque un id no registrado y realizar un registro con el campo administrador vacio  - Test no ok
    * def idUserRandom = dataGen().randomString(16)
    * print "idRandom: ", idUserRandom
    * def newBody = dataGen().generateUserData(true)
    * set newBody.administrador = ""
    Given path idUserRandom
    And request newBody
    When method put
    Then status 400
    And match response.administrador == "administrador deve ser 'true' ou 'false'"
    And match response == schemaResponseNoOk

  @regresion
  Scenario: validar que busque un id no registrado y realizar un registro con el campo email valido  - Test no ok
    * def idUserRandom = dataGen().randomString(16)
    * print "idRandom: ", idUserRandom
    * def newBody = dataGen().generateUserData(true)
    * set newBody.email = idUserRandom + "@gmail"
    Given path idUserRandom
    And request newBody
    When method put
    Then status 400
    And match response.email == "email deve ser um email válido"
    And match response == schemaResponseNoOk