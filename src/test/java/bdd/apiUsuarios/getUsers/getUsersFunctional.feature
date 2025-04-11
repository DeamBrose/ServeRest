Feature: Lista de usuários

  Background:
    * url urlBase + "/usuarios"
    #schemas
    * def schemaUserResponseOk = read("classpath:schema/getUsers/getUserResponseOk.json")
    * def data = read("classpath:data/apiUsuarios/getUsers/getUsersData.json")
    * def schemaUserResponseNoOk = read("classpath:schema/getUsers/getUserResponseNoOk.json")

  @regresion @listUsers
  Scenario: validar que la api liste todos los usuarios - Test ok
    # Given No se requieren parámetros ni paths adicionales para obtener todos los usuarios
    When method get
    Then status 200
    * def responseList = response
    And match response.quantidade == schemaUserResponseOk.quantidade
    And match response.usuarios[*] contains schemaUserResponseOk.usuarios

  @regresion
  Scenario: validar que la api liste todos los usuarios por la categoria administrador en false - Test ok
    Given param administrador = "false"
    When method get
    Then status 200
    And match response.usuarios[*].administrador contains "false"
    And match response.quantidade == schemaUserResponseOk.quantidade
    And match response.usuarios[*] contains schemaUserResponseOk.usuarios

  @regresion
  Scenario: validar que la api liste todos los usuarios por la categoria administrador en true - Test ok
    Given param administrador = "true"
    When method get
    Then status 200
    And match response.usuarios[*].administrador contains "true"
    And match response.quantidade == schemaUserResponseOk.quantidade
    And match response.usuarios[*] contains schemaUserResponseOk.usuarios

  @regresion
  Scenario Outline: validar que la api liste usuarios por el campo id - Test ok
    Given param _id = data.testCaseFunctional.listOfIdUsers[<id>]
    When method get
    Then status 200
    And match response.quantidade == schemaUserResponseOk.quantidade
    And match response.usuarios[*] contains schemaUserResponseOk.usuarios
    Examples:
      | id |
      | 0  |
      | 1  |

  @regresion
  Scenario Outline: validar que la api liste usuarios con el campo id que no existe - Test No ok
    Given param _id = data.testCaseFunctional.listOfIdUsersNoRegistered[<id>]
    When method get
    Then status 200
    And match response == schemaUserResponseNoOk
    Examples:
      | id |
      | 0  |
      | 1  |

  @regresion
  Scenario: validar que la api liste todos los usuarios por el campo nombre - Test ok
    * def nameUser = data.testCaseFunctional.listByNameUser
    Given param nome = nameUser
    When method get
    Then status 200
    And match response.usuarios[*].nome contains nameUser
    And match response.quantidade == schemaUserResponseOk.quantidade
    And match response.usuarios[*] contains schemaUserResponseOk.usuarios

  @regresion
  Scenario: validar que la api liste todos los usuarios por el campo nombre que no exista - Test No ok
    * def nameUserNoRegistered = data.testCaseFunctional.listByNameUserNoRegistered
    Given param nome = nameUserNoRegistered
    When method get
    Then status 200
    And match response == schemaUserResponseNoOk

  @regresion
  Scenario: validar que la api liste todos los usuarios por el campo email - Test ok
    * def emailUser = data.testCaseFunctional.listByEmailUser
    Given param email = emailUser
    When method get
    Then status 200
    And match response.usuarios[*].email contains emailUser
    And match response.quantidade == schemaUserResponseOk.quantidade
    And match response.usuarios[*] contains schemaUserResponseOk.usuarios

  @regresion
  Scenario: validar que la api liste todos los usuarios por el campo email que no exista - Test No ok
    * def emailUserNoRegistered = data.testCaseFunctional.listByEmailUserNoRegistered
    Given param email = emailUserNoRegistered
    When method get
    Then status 200
    And match response == schemaUserResponseNoOk

  @regresion
  Scenario: validar que la api liste todos los usuarios por el campo password - Test ok
    * def passwordUser = data.testCaseFunctional.listByPassword
    Given param password = passwordUser
    When method get
    Then status 200
    And match response.usuarios[*].password contains passwordUser
    And match response.quantidade == schemaUserResponseOk.quantidade
    And match response.usuarios[*] contains schemaUserResponseOk.usuarios

  @regresion
  Scenario: validar que la api liste todos los usuarios por el campo email que no exista - Test No ok
    * def passwordUserNoRegistered = data.testCaseFunctional.listByPasswordNoRegistered
    Given param password = passwordUserNoRegistered
    When method get
    Then status 200
    And match response == schemaUserResponseNoOk

