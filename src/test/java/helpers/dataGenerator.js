    function() {

      // Función para generar un string aleatorio de una longitud dada
      function generateRandomString(length) {
        var chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
        var result = '';
        for (var i = 0; i < length; i++) {
          result += chars.charAt(Math.floor(Math.random() * chars.length));
        }
        return result;
      };

      // Función para generar un email aleatorio y único
      function generateRandomEmail() {
      var fullUuid = java.util.UUID.randomUUID();
      var shortUuid = fullUuid.toString().substring(0, 5);
        // Usamos karate.random.uuid() para asegurar alta probabilidad de unicidad
        return 'testuser' + shortUuid + '@mailinator.com';
      };

      // Puede aceptar parámetros para personalizar, ej: si es admin o no
      function generateUserData(isAdmin) {
        var userData = {
          nome: "Usuario Test " + generateRandomString(8),
          email: generateRandomEmail(),
          password: "pwd" + generateRandomString(10),
          // Convierte el booleano JS a string si la API lo espera así
          administrador: String(isAdmin)
        };
        return userData;
      };

      //funciones para que estén disponibles en Karate
      return {
        randomString: generateRandomString,
        randomEmail: generateRandomEmail,
        generateUserData: generateUserData
      };
    }
