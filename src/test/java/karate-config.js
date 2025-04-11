function fn() {
//variables
  var urlBase = "";

  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  // Deshabilitar validación SSL para todos los features en este entorno
  karate.configure('ssl', { trustAll: true });


  if (env == 'dev') {
    // customize
    urlBase = "https://serverest.dev"

  } else if (env == 'e2e') {
    // customize

  }

  var config = {
      env: env,
      myVarName: 'someValue',
      urlBase: urlBase
    }

  return config;
}