package compartircoche;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import org.junit.jupiter.api.Test;


public class AppCompartirCocheTest {
    @Test
    void testCrearViaje() {
        // Probas con valores baleiros ou inválidos nos que o método devolve false
        boolean valorReal = AppCompartirCoche.crearViaje("", "", "", "", 0);
        assertFalse(valorReal);
        assertFalse(AppCompartirCoche.crearViaje("admin", "", "", "", 0));
        assertFalse(AppCompartirCoche.crearViaje("admin", "2025/11/01 14:30", "", "", 0)); 
        assertFalse(AppCompartirCoche.crearViaje("admin", "2025/11/01 14:30", "Pontevedra", "Marín", 0));
        assertFalse(AppCompartirCoche.crearViaje("admin", "2025/11/01 14:30", "Pontevedra", "Marín", -1));        
        // Proba con valores correctos nos que o método devolve true
        assertTrue(AppCompartirCoche.crearViaje("admin", "2025/11/01 14:30", "Pontevedra", "Marín", 1));        
    }

    @Test
    void testLoginUsuario() {
        // Probas con valores baleiros ou incorrectos nos que o método devolve false
        assertFalse(AppCompartirCoche.loginUsuario("", "")); // Usuario baleiro
        assertFalse(AppCompartirCoche.loginUsuario("usuarioInexistente", "contrasinal"));        
        assertFalse(AppCompartirCoche.loginUsuario("admin", "contrasinalIncorrecto"));        
        // Proba con valores correctos nos que o método devolve true
        assertTrue(AppCompartirCoche.loginUsuario("admin", "abc123.,"));
    }
}
